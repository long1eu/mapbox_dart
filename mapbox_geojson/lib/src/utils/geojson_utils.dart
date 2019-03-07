/// GeoJson utils class contains method that can be used throughout geojson package.
class GeoJsonUtils {
  static double ROUND_PRECISION = 10000000.0;
  static int MAX_DOUBLE_TO_ROUND = 2 ^ 53 ~/ ROUND_PRECISION;

  /// Trims a double value to have only 7 digits after period.
  ///
  /// @param value to be trimed
  /// @return trimmed value
  static double trim(double value) {
    if (value > MAX_DOUBLE_TO_ROUND || value < -MAX_DOUBLE_TO_ROUND) {
      return value;
    }
    return (value * ROUND_PRECISION).round() / ROUND_PRECISION;
  }
}
