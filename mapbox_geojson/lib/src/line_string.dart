// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A linestring represents two or more geographic points that share a
/// relationship and is one of the seven geometries found in the GeoJson spec.
///
/// This adheres to the RFC 7946 internet standard when serialized into JSON.
///
/// The list of points must be equal to or greater than 2. A LineString has
/// non-zero length and zero area. It may approximate a curve and need not be
/// straight. Unlike a LinearRing, a LineString is not closed.
///
/// When representing a LineString that crosses the antimeridian,
/// interoperability is improved by modifying their geometry. Any geometry that
/// crosses the antimeridian SHOULD be represented by cutting it in two such
/// that neither part's representation crosses the antimeridian.
///
/// For example, a line extending from 45 degrees N, 170 degrees E across the
/// antimeridian to 45 degrees N, 170 degrees W should be cut in two and
/// represented as a MultiLineString.
///
/// A sample GeoJson LineString's provided below (in it's serialized state).
/// ```json
/// {
///   "TYPE": "LineString",
///   "coordinates": [
///     [100.0, 0.0],
///     [101.0, 1.0]
///   ]
/// }
/// ```
/// Look over the [Point] documentation to get more information about formatting
/// your list of point objects correctly.
class LineString implements CoordinateContainer<List<Point>> {
  factory LineString.fromJson(String json) {
    return LineString.fromJsonMap(Map<String, dynamic>.from(jsonDecode(json)));
  }

  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String. If you are creating a LineString object from scratch it is better
  /// to use one of the other provided factory constructors such as
  /// [LineString.fromLngLats].
  ///
  /// For a valid lineString to exist, it must have at least 2 coordinate
  /// entries. The LineString should also have non-zero distance and zero area.
  factory LineString.fromJsonMap(Map<String, dynamic> data) {
    if (data['coordinates'] == null) {
      throw ArgumentError.notNull('coordinates');
    }

    final List<Point> coordinates = data['coordinates']
        .map((dynamic it) => Point.fromCoordinates(GeoJsonUtils.normalize(it)))
        .cast<Point>()
        .toList();

    BoundingBox bbox;
    if (data['bbox'] != null) {
      bbox = BoundingBox.fromCoordinates(GeoJsonUtils.normalize(data['bbox']));
    }

    return LineString._(coordinates, bbox);
  }

  /// Create a new instance of this class by defining a [LineString] object and
  /// passing. The multipoint object should comply with the GeoJson
  /// specifications described in the documentation.
  factory LineString.fromMultipoint(MultiPoint multiPoint, [BoundingBox bbox]) {
    return LineString.fromLngLats(multiPoint.coordinates, bbox);
  }

  /// Create a new instance of this class by defining a list of [Point]s which
  /// follow the correct specifications described in the Point documentation.
  ///
  /// Note that there should not be any duplicate points inside the list and the
  /// points combined should create a LineString with a distance greater than 0.
  ///
  /// Note that if less than 2 points are passed in, a runtime exception will
  /// occur.
  factory LineString.fromLngLats(List<Point> points, [BoundingBox bbox]) {
    return LineString._(points, bbox);
  }

  factory LineString.fromCoordinates(List<List<double>> coordinates) {
    assert(coordinates != null);

    return LineString._(coordinates
        .map((List<double> it) =>
            Point.fromCoordinates(GeoJsonUtils.normalize(it)))
        .toList());
  }

  /// Create a new instance of this class by convert a polyline string into a
  /// lineString.
  ///
  /// This is handy when an API provides you with an encoded string representing
  /// the line geometry and you'd like to convert it to a useful [LineString]
  /// object.
  ///
  /// Note that the precision that the string geometry was encoded with needs to
  /// be known and passed into this method using the precision parameter.
  factory LineString.fromPolyline(String polyline, int precision) {
    return LineString.fromLngLats(PolylineUtils.decode(polyline, precision));
  }

  LineString._(this.coordinates, [this.bbox]) : assert(coordinates != null);

  /// This describes the TYPE of GeoJson geometry this object is, thus this will
  /// always return [GeoJsonType.lineString]
  @override
  GeoJsonType get type => GeoJsonType.lineString;

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

  /// Provides the list of [Point]s that make up the [LineString] geometry.
  @override
  final List<Point> coordinates;

  /// Encode this [LineString] into a Polyline string for easier serializing.
  /// When passing geometry information over a mobile network connection,
  /// encoding the geometry first will generally result in less bandwidth usage.
  ///
  /// [precision] the encoded precision which fits your best use-case
  String toPolyline(int precision) =>
      PolylineUtils.encode(coordinates.toList(), precision);

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      'coordinates': coordinates.map((Point it) => it.coordinates).toList(),
    };
  }

  @override
  String get json => jsonEncode(jsonMap);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineString && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<Point>().equals(coordinates, other.coordinates);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<Point>().hash(coordinates);
}
