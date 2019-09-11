// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A [GeoJson] object MAY have a member named "bbox" to include information on
/// the coordinate range for its [Geometry]ies, [Feature]s, or
/// [FeatureCollection]s.
///
/// This class simplifies the build process for creating a bounding box and
/// working with them when deserialized. Specific parameter naming helps define
/// which coordinates belong where when a bounding box instance is being
/// created.
///
/// Note that since [GeoJson] objects only have the option of including a
/// bounding box JSON element, the [bbox] value returned by a GeoJson object
/// might be null.
///
/// At a minimum, a bounding box will have two [Point]s or four coordinates
/// which define the box. A 3rd dimensional bounding box can be produced if
/// elevation or altitude is defined.
class BoundingBox {
  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String.
  factory BoundingBox.fromJson(String json) {
    final List<double> rawCoordinates = List<double>.from(jsonDecode(json));
    return BoundingBox.fromCoordinates(GeoJsonUtils.normalize(rawCoordinates));
  }

  /// Define a new instance of this class by passing in two [Point]s,
  /// representing both the [southwest] and [northwest] corners of the bounding
  /// box.
  factory BoundingBox.fromPoints({
    @required Point southwest,
    @required Point northeast,
  }) {
    assert(southwest != null);
    assert(northeast != null);
    return BoundingBox._(southwest, northeast);
  }

  /// Define a new instance of this class by passing in four coordinates in the
  /// same order they would appear in the serialized GeoJson form. Limits are
  /// placed on the minimum and maximum coordinate values which can exist and
  /// comply with the GeoJson spec.
  factory BoundingBox.fromLngLats({
    double west,
    double south,
    double southwestAltitude,
    double east,
    double north,
    double northEastAltitude,
  }) {
    assert(west <= kMaxLongitude && west >= kMinLongitude);
    assert(south <= kMaxLatitude && south >= kMinLatitude);
    assert(east <= kMaxLongitude && east >= kMinLongitude);
    assert(north <= kMaxLatitude && north >= kMinLatitude);

    return BoundingBox._(
      Point.fromLngLat(west, south, altitude: southwestAltitude),
      Point.fromLngLat(east, north, altitude: northEastAltitude),
    );
  }

  factory BoundingBox.fromCoordinates(final List<double> coordinates) {
    if (coordinates.length == 6) {
      return BoundingBox.fromLngLats(
        west: coordinates[0],
        south: coordinates[1],
        southwestAltitude: coordinates[2],
        east: coordinates[3],
        north: coordinates[4],
        northEastAltitude: coordinates[5],
      );
    }
    if (coordinates.length == 4) {
      return BoundingBox.fromLngLats(
        west: coordinates[0],
        south: coordinates[1],
        east: coordinates[2],
        north: coordinates[3],
      );
    } else {
      throw ArgumentError(
          'The value of the bbox member MUST be an array of length 2*n where n '
          'is the number of dimensions represented in the contained geometries,'
          ' with all axes of the most southwesterly point followed by all axes '
          'of the more northeasterly point. The axes order of a bbox follows '
          'the axes order of geometries.');
    }
  }

  const BoundingBox._(this.southwest, this.northeast)
      : assert(southwest != null),
        assert(northeast != null);

  /// Provides the [Point] which represents the southwest corner of this
  /// bounding box when the map is facing due north.
  final Point southwest;

  /// Provides the [Point] which represents the northeast corner of this
  /// bounding box when the map is facing due north.
  final Point northeast;

  /// Convenience method for getting the bounding box most westerly point
  /// (longitude) as a double coordinate.
  double get west => southwest.longitude;

  /// Convenience method for getting the bounding box most southerly point
  /// (latitude) as a double coordinate.
  double get south => southwest.latitude;

  /// Convenience method for getting the bounding box most easterly point
  /// (longitude) as a double coordinate.
  double get east => northeast.longitude;

  /// Convenience method for getting the bounding box most westerly point
  /// (longitude) as a double coordinate.
  double get north => northeast.latitude;

  List<double> get json {
    final List<double> southwest =
        CoordinateShifterManager.getCoordinateShifter()
            .unshiftPoint(this.southwest);
    final List<double> northeast =
        CoordinateShifterManager.getCoordinateShifter()
            .unshiftPoint(this.northeast);

    return <double>[
      southwest[0],
      southwest[1],
      if (this.southwest.hasAltitude) southwest[2],
      northeast[0],
      northeast[1],
      if (this.northeast.hasAltitude) northeast[2],
    ];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoundingBox && //
          runtimeType == other.runtimeType &&
          southwest == other.southwest &&
          northeast == other.northeast;

  @override
  int get hashCode =>
      southwest.hashCode ^ //
      northeast.hashCode;
}
