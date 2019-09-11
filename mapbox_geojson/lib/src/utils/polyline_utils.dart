// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// Polyline utils class contains method that can decode/encode a polyline,
/// simplify a line, and more.
class PolylineUtils {
  PolylineUtils._();

  // 1 by default (in the same metric as the point coordinates)
  static const double _simplifyDefaultTolerance = 1;

  // False by default (excludes distance-based preprocessing step which leads to highest quality
  // simplification but runs slower)
  static const bool _simplifyDefaultHighestQuality = false;

  /// Decodes an encoded path string into a sequence of [Point].
  static List<Point> decode(final String encodedPath, int precision) {
    final int len = encodedPath.length;

    // OSRM uses precision=6, the default Polyline spec divides by 1E5, capping at precision=5
    final double factor = math.pow(10, precision);

    // For speed we preallocate to an upper bound on the final length, then
    // truncate the array before returning.
    final List<Point> path = <Point>[];
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

      path.add(Point.fromLngLat(lng / factor, lat / factor));
    }

    return path;
  }

  /// Encodes a sequence of Points into an encoded path string.
  static String encode(final List<Point> path, int precision) {
    int lastLat = 0;
    int lastLng = 0;

    final StringBuffer result = StringBuffer();

    // OSRM uses precision=6, the default Polyline spec divides by 1E5, capping at precision=5
    final double factor = math.pow(10, precision).toDouble();

    for (final Point point in path) {
      final int lat = (point.latitude * factor).round();
      final int lng = (point.longitude * factor).round();

      final int varLat = lat - lastLat;
      final int varLng = lng - lastLng;

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
      result.writeCharCode((0x20 | (variable & 0x1f)) + 63);
      variable >>= 5;
    }
    result.writeCharCode(variable + 63);
  }

  /*
   * Polyline simplification method. It's a direct port of simplify.js to Java.
   * See: https://github.com/mourner/simplify-js/blob/master/simplify.js
   */

  /// Reduces the number of points in a polyline while retaining its shape,
  /// giving a performance boost when processing it and also reducing visual
  /// noise.
  static List<Point> simplify(List<Point> points,
      {double tolerance = _simplifyDefaultTolerance,
      bool highestQuality = _simplifyDefaultHighestQuality}) {
    tolerance ??= _simplifyDefaultTolerance;
    highestQuality ??= _simplifyDefaultHighestQuality;

    if (points.length <= 2) {
      return points;
    }

    final double sqTolerance = tolerance * tolerance;

    points = highestQuality ? points : _simplifyRadialDist(points, sqTolerance);
    points = _simplifyDouglasPeucker(points, sqTolerance);

    return points;
  }

  /// Square distance between 2 points.
  static double _getSqDist(Point p1, Point p2) {
    final double dx = p1.longitude - p2.longitude;
    final double dy = p1.latitude - p2.latitude;
    return dx * dx + dy * dy;
  }

  /// Square distance from a point to a segment.
  static double _getSqSegDist(Point point, Point p1, Point p2) {
    double horizontal = p1.longitude;
    double vertical = p1.latitude;
    double diffHorizontal = p2.longitude - horizontal;
    double diffVertical = p2.latitude - vertical;

    if (diffHorizontal != 0 || diffVertical != 0) {
      final double total = ((point.longitude - horizontal) * diffHorizontal +
              (point.latitude - vertical) * diffVertical) /
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
  static List<Point> _simplifyRadialDist(
      List<Point> points, double sqTolerance) {
    Point prevPoint = points[0];
    final List<Point> newPoints = <Point>[];
    newPoints.add(prevPoint);
    Point point;

    final int len = points.length;
    for (int i = 1; i < len; i++) {
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

  static List<Point> _simplifyDpStep(List<Point> points, int first, int last,
      double sqTolerance, List<Point> simplified) {
    double maxSqDist = sqTolerance;
    int index = 0;

    final List<Point> stepList = <Point>[];
    for (int i = first + 1; i < last; i++) {
      final double sqDist =
          _getSqSegDist(points[i], points[first], points[last]);
      if (sqDist > maxSqDist) {
        index = i;
        maxSqDist = sqDist;
      }
    }

    if (maxSqDist > sqTolerance) {
      if (index - first > 1) {
        stepList.addAll(
            _simplifyDpStep(points, first, index, sqTolerance, simplified));
      }

      stepList.add(points[index]);

      if (last - index > 1) {
        stepList.addAll(
            _simplifyDpStep(points, index, last, sqTolerance, simplified));
      }
    }

    return stepList;
  }

  /// Simplification using Ramer-Douglas-Peucker algorithm.
  static List<Point> _simplifyDouglasPeucker(
      List<Point> points, double sqTolerance) {
    final int last = points.length - 1;
    final List<Point> simplified = <Point>[];
    simplified.add(points[0]);
    simplified
        .addAll(_simplifyDpStep(points, 0, last, sqTolerance, simplified));
    simplified.add(points[last]);
    return simplified;
  }
}
