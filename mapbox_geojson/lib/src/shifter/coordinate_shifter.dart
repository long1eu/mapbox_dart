import 'package:mapbox_geojson/mapbox_geojson.dart';

/// ShifterManager allows the movement of all Point objects according to a custom algorithm.
/// Once set, it will be applied to all Point objects created through this method.
abstract class CoordinateShifter {
  const CoordinateShifter();

  /// Shifted coordinate values according to its algorithm.
  ///
  /// Returns shifted longitude, shifted latitude in the form of a List of double values
  List<double> shiftLonLat(double lon, double lat);

  /// Shifted coordinate values according to its algorithm.
  ///
  /// Returns shifted longitude, shifted latitude, shifted altitude in the form of a List of double values
  List<double> shiftLonLatAlt(double lon, double lat, double altitude);

  /// Unshifted coordinate values according to its algorithm.
  ///
  /// Returns unshifted longitude, shifted latitude, and altitude (if present)
  /// in the form of List of double
  List<double> unshiftPoint(Point shiftedPoint);
}
