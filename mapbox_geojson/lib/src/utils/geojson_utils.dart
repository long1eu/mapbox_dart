// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// GeoJson utils class contains method that can be used throughout geojson
/// package.
class GeoJsonUtils {
  /// Trims a double value to have only 7 digits after period.
  static double trim(double value) => (value * 10e6).round() / 10e6;

  static List<double> normalize(List<dynamic> it) {
    return List<num>.from(it).map((num it) => trim(it.toDouble())).toList();
  }
}
