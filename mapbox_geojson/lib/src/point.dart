// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A point represents a single geographic position and is one of the seven
/// Geometries found in the GeoJson spec.
///
/// This adheres to the RFC 7946 internet standard when serialized into JSON.
///
/// Coordinates are in x, y order (easting, northing for projected coordinates),
/// longitude, and latitude for geographic coordinates), precisely in that order
/// and using double values. Altitude or elevation MAY be included as an
/// optional third parameter while creating this object.
///
/// The size of a GeoJson text in bytes is a major interoperability
/// consideration, and precision of coordinate values has a large impact on the
/// size of texts when serialized. For geographic coordinates with units of
/// degrees, 6 decimal places (a default common in, e.g., sprintf) amounts to
/// about 10 centimeters, a precision well within that of current GPS systems.
/// Implementations should consider the cost of using a greater precision than
/// necessary.
///
/// Furthermore, pertaining to altitude, the WGS 84 datum is a relatively coarse
/// approximation of the geoid, with the height varying by up to 5 m (but
/// generally between 2 and 3 meters) higher or lower relative to a surface
/// parallel to Earth's mean sea level.
///
/// A sample GeoJson Point's provided below (in its serialized state).
/// ```json
/// {
///   "type": "Point",
///   "coordinates": [100, 0]
/// }
/// ```
class Point implements CoordinateContainer<List<double>> {
  factory Point.fromJson(String json) {
    return Point.fromJsonMap(Map<String, dynamic>.from(jsonDecode(json)));
  }

  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String. If you are creating a Point object from scratch it is better to
  /// use one of the other provided factory constructors such as
  /// [Point.fromLngLat].
  ///
  /// Longitude values should not exceed the spec defined -180 to 180 range and
  /// latitude's limit of -90 to 90. While no limit is placed on decimal
  /// precision, for performance reasons when serializing and deserializing it
  /// is suggested to limit decimal precision to within 6 decimal places.
  factory Point.fromJsonMap(Map<String, dynamic> data) {
    if (data['coordinates'] == null) {
      throw ArgumentError.notNull('coordinates');
    }

    final List<double> coordinates =
        GeoJsonUtils.normalize(data['coordinates']);

    BoundingBox bbox;
    if (data['bbox'] != null) {
      bbox = BoundingBox.fromCoordinates(GeoJsonUtils.normalize(data['bbox']));
    }

    return Point._(coordinates, bbox);
  }

  /// Create a new instance of this class defining a longitude and latitude
  /// value in that respective order.
  ///
  /// Longitude values are limited to a -180 to 180 range and latitude's limited
  /// to -90 to 90 as the spec defines. While no limit is placed on decimal
  /// precision, for performance reasons when serializing and deserializing it
  /// is suggested to limit decimal precision to within 6 decimal places. An
  /// optional altitude value can be passed in and can vary between negative
  /// infinity and positive infinity.
  factory Point.fromLngLat(
    double longitude,
    double latitude, {
    double altitude,
    BoundingBox bbox,
  }) {
    assert(longitude >= kMinLongitude && longitude <= kMaxLongitude);
    assert(latitude >= kMinLatitude && latitude <= kMaxLatitude);

    List<double> coordinates = CoordinateShifterManager.getCoordinateShifter()
        .shiftLonLatAlt(longitude, latitude, altitude);
    coordinates = GeoJsonUtils.normalize(coordinates);

    return Point._(coordinates, bbox);
  }

  factory Point.fromCoordinates(List<double> coordinates) {
    assert(coordinates != null && coordinates.length >= 2);
    coordinates = GeoJsonUtils.normalize(coordinates);

    return Point.fromLngLat(
      coordinates[0],
      coordinates[1],
      altitude: coordinates.length > 2 ? coordinates[2] : null,
    );
  }

  Point._(this.coordinates, [this.bbox])
      : assert(coordinates != null && coordinates.isNotEmpty);

  /// This describes the TYPE of GeoJson geometry this object is, thus this will
  /// always return [GeoJsonType.point].
  @override
  GeoJsonType get type => GeoJsonType.point;

  /// Return a list of double coordinate values describing a bounding box
  ///
  /// A Feature Collection might have a member named [bbox] to include
  /// information on the coordinate range for it's [Feature]s. The value of the
  /// bbox member MUST be a list of size 2*n where n is the number of dimensions
  /// represented in the contained feature geometries, with all axes of the most
  /// southwesterly point followed by all axes of the more northeasterly point.
  /// The axes order of a bbox follows the axes order of geometries.
  @override
  final BoundingBox bbox;

  /// Return a double list which holds this points coordinates
  ///
  /// Provide a single double list containing the longitude, latitude, and
  /// optionally an altitude/elevation. [longitude], [latitude], and [altitude]
  /// are all available which make getting specific coordinates more direct.
  @override
  final List<double> coordinates;

  /// Returns a double value ranging from -180 to 180 representing the x or
  /// easting position of this point
  ///
  /// Ideally, this value would be restricted to 6 decimal places to correctly
  /// follow the GeoJson spec.
  double get longitude => coordinates[0];

  /// Return a double value ranging from -90 to 90 representing the y or
  /// northing position of this point
  ///
  /// Ideally, this value would be restricted to 6 decimal places to correctly
  /// follow the GeoJson spec.
  double get latitude => coordinates[1];

  /// Optionally, the coordinate spec in GeoJson allows for altitude values to
  /// be placed inside the coordinate array.
  ///
  /// Can be used to determine if this value was set during initialization of
  /// this Point instance. This double value should only be used to represent
  /// either the elevation or altitude value at this particular point.
  double get altitude {
    if (coordinates.length < 3) {
      return double.nan;
    }
    return coordinates[2];
  }

  /// Return true if this instance of point contains an altitude value
  bool get hasAltitude => !altitude.isNaN;

  @override
  Map<String, dynamic> get jsonMap {
    final List<double> unshiftedCoordinates =
        CoordinateShifterManager.getCoordinateShifter().unshiftPoint(this);

    return <String, dynamic>{
      if (bbox != null) 'bbox': bbox.json,
      'type': type.name,
      'coordinates': <double>[
        unshiftedCoordinates[0],
        unshiftedCoordinates[1],
        if (hasAltitude) unshiftedCoordinates[2],
      ],
    };
  }

  @override
  String get json => jsonEncode(jsonMap);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<double>().equals(coordinates, other.coordinates);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<double>().hash(coordinates);
}
