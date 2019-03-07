import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/shifter/coordinate_shifter.dart';

/// CoordinateShifterManager keeps track of currently set CoordinateShifter.
class CoordinateShifterManager {
  static CoordinateShifter coordinateShifter = _defaultShifter;

  /// Currently set CoordinateShifterManager.
  static CoordinateShifter getCoordinateShifter() {
    return coordinateShifter;
  }

  /// Sets CoordinateShifterManager.
  static void setCoordinateShifter(CoordinateShifter coordinateShifter) {
    CoordinateShifterManager.coordinateShifter = coordinateShifter == null ? _defaultShifter : coordinateShifter;
  }
}

CoordinateShifter _defaultShifter = _DefaultCoordinateShifter();

class _DefaultCoordinateShifter extends CoordinateShifter {
  const _DefaultCoordinateShifter();

  @override
  List<double> shiftLonLat(double lon, double lat) => <double>[lon, lat];

  @override
  List<double> shiftLonLatAlt(double lon, double lat, double altitude) {
    return altitude.isNaN ? <double>[lon, lat] : <double>[lon, lat, altitude];
  }

  @override
  List<double> unshiftPoint(Point shiftedPoint) => shiftedPoint.coordinates.toList();
}
