import 'dart:math' as math;

import 'package:mapbox_geojson/src/point.dart';

/// Polyline utils class contains method that can decode/encode a polyline, simplify a line, and
/// more.
class PolylineUtils {
  PolylineUtils._();

  // 1 by default (in the same metric as the point coordinates)
  static const double _simplifyDefaultTolerance = 1;

  // False by default (excludes distance-based preprocessing step which leads to highest quality
  // simplification but runs slower)
  static const bool _simplifyDefaultHighestQuality = false;

  /// Decodes an encoded path string into a sequence of {@link Point}.
  ///
  /// @param encodedPath a String representing an encoded path string
  /// @param precision   OSRMv4 uses 6, OSRMv5 and Google uses 5
  /// @return list of {@link Point} making up the line
  /// @see <a href="https://github.com/mapbox/polyline/blob/master/src/polyline.js">Part of algorithm came from this source</a>
  /// @see <a href="https://github.com/googlemaps/android-maps-utils/blob/master/library/src/com/google/maps/android/PolyUtil.java">Part of algorithm came from this source.</a>
  static List<Point> decode(final String encodedPath, int precision) {
    int len = encodedPath.length;

    // OSRM uses precision=6, the default Polyline spec divides by 1E5, capping at precision=5
    double factor = math.pow(10, precision);

    // For speed we preallocate to an upper bound on the final length, then
    // truncate the array before returning.
    final List<Point> path = [];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int result = 1;
      int shift = 0;
      int temp;
      do {
        temp = encodedPath.codeUnitAt(index++) - 63 - 1;
        result += temp << shift;
        shift += 5;
      } while (temp >= 0x1f);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      result = 1;
      shift = 0;
      do {
        temp = encodedPath.codeUnitAt(index++) - 63 - 1;
        result += temp << shift;
        shift += 5;
      } while (temp >= 0x1f);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      path.add(Point.fromLngLat(longitude: lng / factor, latitude: lat / factor));
    }

    return path;
  }

  /// Encodes a sequence of Points into an encoded path string.
  ///
  /// @param path      list of {@link Point}s making up the line
  /// @param precision OSRMv4 uses 6, OSRMv5 and Google uses 5
  /// @return a String representing a path string
  static String encode(final List<Point> path, int precision) {
    int lastLat = 0;
    int lastLng = 0;

    final StringBuffer result = new StringBuffer();

    // OSRM uses precision=6, the default Polyline spec divides by 1E5, capping at precision=5
    double factor = math.pow(10, precision);

    for (final Point point in path) {
      int lat = (point.latitude * factor).round();
      int lng = (point.longitude * factor).round();

      int varLat = lat - lastLat;
      int varLng = lng - lastLng;

      _encode(varLat, result);
      _encode(varLng, result);

      lastLat = lat;
      lastLng = lng;
    }
    return result.toString();
  }

  static void _encode(int variable, StringBuffer result) {
    variable = variable < 0 ? ~(variable << 1) : variable << 1;
    while (variable >= 0x20) {
      result.writeCharCode(((0x20 | (variable & 0x1f)) + 63));
      variable >>= 5;
    }
    result.writeCharCode(variable + 63);
  }

  /*
   * Polyline simplification method. It's a direct port of simplify.js to Java.
   * See: https://github.com/mourner/simplify-js/blob/master/simplify.js
   */

  /// Reduces the number of points in a polyline while retaining its shape, giving a performance
  /// boost when processing it and also reducing visual noise.
  ///
  /// @param points         an array of points
  /// @param tolerance      affects the amount of simplification (in the same metric as the point
  /// coordinates)
  /// @param highestQuality excludes distance-based preprocessing step which leads to highest quality
  /// simplification
  /// @return an array of simplified points
  /// @see <a href="http://mourner.github.io/simplify-js/">JavaScript implementation</a>
  static List<Point> simplify(List<Point> points,
      {double tolerance = _simplifyDefaultTolerance, bool highestQuality = _simplifyDefaultHighestQuality}) {
    tolerance ??= _simplifyDefaultTolerance;
    highestQuality ??= _simplifyDefaultHighestQuality;

    if (points.length <= 2) {
      return points;
    }

    double sqTolerance = tolerance * tolerance;

    points = highestQuality ? points : _simplifyRadialDist(points, sqTolerance);
    points = _simplifyDouglasPeucker(points, sqTolerance);

    return points;
  }

  /// Square distance between 2 points.
  ///
  /// @param p1 first {@link Point}
  /// @param p2 second Point
  /// @return square of the distance between two input points
  static double _getSqDist(Point p1, Point p2) {
    double dx = p1.longitude - p2.longitude;
    double dy = p1.latitude - p2.latitude;
    return dx * dx + dy * dy;
  }

  /// Square distance from a point to a segment.
  ///
  /// @param point {@link Point} whose distance from segment needs to be determined
  /// @param p1,p2 points defining the segment
  /// @return square of the distance between first input point and segment defined by
  /// other two input points
  static double _getSqSegDist(Point point, Point p1, Point p2) {
    double horizontal = p1.longitude;
    double vertical = p1.latitude;
    double diffHorizontal = p2.longitude - horizontal;
    double diffVertical = p2.latitude - vertical;

    if (diffHorizontal != 0 || diffVertical != 0) {
      double total = ((point.longitude - horizontal) * diffHorizontal + (point.latitude - vertical) * diffVertical) /
          (diffHorizontal * diffHorizontal + diffVertical * diffVertical);
      if (total > 1) {
        horizontal = p2.longitude;
        vertical = p2.latitude;
      } else if (total > 0) {
        horizontal += diffHorizontal * total;
        vertical += diffVertical * total;
      }
    }

    diffHorizontal = point.longitude - horizontal;
    diffVertical = point.latitude - vertical;

    return diffHorizontal * diffHorizontal + diffVertical * diffVertical;
  }

  /// Basic distance-based simplification.
  ///
  /// @param points a list of points to be simplified
  /// @param sqTolerance square of amount of simplification
  /// @return a list of simplified points
  static List<Point> _simplifyRadialDist(List<Point> points, double sqTolerance) {
    Point prevPoint = points[0];
    List<Point> newPoints = <Point>[];
    newPoints.add(prevPoint);
    Point point;

    for (int i = 1, len = points.length; i < len; i++) {
      point = points[i];

      if (_getSqDist(point, prevPoint) > sqTolerance) {
        newPoints.add(point);
        prevPoint = point;
      }
    }

    if (prevPoint != point) {
      newPoints.add(point);
    }
    return newPoints;
  }

  static List<Point> _simplifyDpStep(
      List<Point> points, int first, int last, double sqTolerance, List<Point> simplified) {
    double maxSqDist = sqTolerance;
    int index = 0;

    List<Point> stepList = <Point>[];

    for (int i = first + 1; i < last; i++) {
      double sqDist = _getSqSegDist(points[i], points[first], points[last]);
      if (sqDist > maxSqDist) {
        index = i;
        maxSqDist = sqDist;
      }
    }

    if (maxSqDist > sqTolerance) {
      if (index - first > 1) {
        stepList.addAll(_simplifyDpStep(points, first, index, sqTolerance, simplified));
      }

      stepList.add(points[index]);

      if (last - index > 1) {
        stepList.addAll(_simplifyDpStep(points, index, last, sqTolerance, simplified));
      }
    }

    return stepList;
  }

  /// Simplification using Ramer-Douglas-Peucker algorithm.
  ///
  /// @param points a list of points to be simplified
  /// @param sqTolerance square of amount of simplification
  /// @return a list of simplified points
  static List<Point> _simplifyDouglasPeucker(List<Point> points, double sqTolerance) {
    int last = points.length - 1;
    List<Point> simplified = <Point>[];
    simplified.add(points[0]);
    simplified.addAll(_simplifyDpStep(points, 0, last, sqTolerance, simplified));
    simplified.add(points[last]);
    return simplified;
  }
}
