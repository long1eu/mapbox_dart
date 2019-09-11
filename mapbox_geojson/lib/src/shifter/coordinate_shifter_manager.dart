import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:mapbox_geojson/src/shifter/coordinate_shifter.dart';

// ignore: avoid_classes_with_only_static_members
/// CoordinateShifterManager keeps track of currently set CoordinateShifter.
class CoordinateShifterManager {
  static CoordinateShifter coordinateShifter = _defaultShifter;

  /// Currently set CoordinateShifterManager.
  static CoordinateShifter getCoordinateShifter() {
    return coordinateShifter;
  }

  /// Sets CoordinateShifterManager.
  static void setCoordinateShifter(CoordinateShifter coordinateShifter) {
    CoordinateShifterManager.coordinateShifter =
        coordinateShifter ?? _defaultShifter;
  }
}

CoordinateShifter _defaultShifter = const _DefaultCoordinateShifter();

class _DefaultCoordinateShifter extends CoordinateShifter {
  const _DefaultCoordinateShifter();

  @override
  List<double> shiftLonLat(double lon, double lat) => <double>[lon, lat];

  @override
  List<double> shiftLonLatAlt(double lon, double lat, double altitude) {
    return altitude == null || altitude.isNaN
        ? <double>[lon, lat]
        : <double>[lon, lat, altitude];
  }

  @override
  List<double> unshiftPoint(Point shiftedPoint) =>
      shiftedPoint.coordinates.toList();
}
