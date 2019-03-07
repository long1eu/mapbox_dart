///  Contains constants used throughout the GeoJson classes.
class GeoJsonConstants {
  const GeoJsonConstants._();

  /// A Mercator project has a finite longitude values, this constant represents the lowest value
  /// available to represent a geolocation.
  static final double MIN_LONGITUDE = -180;

  /// A Mercator project has a finite longitude values, this constant represents the highest value
  /// available to represent a geolocation.
  static final double MAX_LONGITUDE = 180;

  /// While on a Mercator projected map the width (longitude) has a finite values, the height
  /// (latitude) can be infinitely long. This constant restrains the lower latitude value to -90 in
  /// order to preserve map readability and allows easier logic for tile selection.
  static final double MIN_LATITUDE = -90;

  /// While on a Mercator projected map the width (longitude) has a finite values, the height
  /// (latitude) can be infinitely long. This constant restrains the upper latitude value to 90 in
  /// order to preserve map readability and allows easier logic for tile selection.
  static final double MAX_LATITUDE = 90;
}
