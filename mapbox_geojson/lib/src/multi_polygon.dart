// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A multiPolygon is an array of [Polygon] coordinate arrays.
///
/// This adheres to the RFC 7946 internet standard when serialized into JSON.
///
/// When representing a [Polygon] that crosses the antimeridian,
/// interoperability is improved by modifying their geometry. Any geometry that
/// crosses the antimeridian SHOULD be represented by cutting it in two such
/// that neither part's representation crosses the antimeridian.
///
/// For example, a line extending from 45 degrees N, 170 degrees E across the
/// antimeridian to 45 degrees N, 170 degrees W should be cut in two and
/// represented as a MultiLineString.
///
/// A sample GeoJson [MultiPolygon]'s provided below (in it's serialized state).
/// ```json
/// {
///   "type": "MultiPolygon",
///   "coordinates": [
///     [
///       [
///         [102.0, 2.0],
///         [103.0, 2.0],
///         [103.0, 3.0],
///         [102.0, 3.0],
///         [102.0, 2.0]
///       ]
///     ],
///     [
///       [
///         [100.0, 0.0],
///         [101.0, 0.0],
///         [101.0, 1.0],
///         [100.0, 1.0],
///         [100.0, 0.0]
///       ],
///       [
///         [100.2, 0.2],
///         [100.2, 0.8],
///         [100.8, 0.8],
///         [100.8, 0.2],
///         [100.2, 0.2]
///       ]
///     ]
///   ]
/// }
/// ```
/// Look over the [Polygon] documentation to get more information about
/// formatting your list of [Polygon] objects correctly.
class MultiPolygon implements CoordinateContainer<List<List<List<Point>>>> {
  factory MultiPolygon.fromJson(String json) {
    return MultiPolygon.fromJsonMap(
        Map<String, dynamic>.from(jsonDecode(json)));
  }

  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String. If you are creating a [MultiPolygon] object from scratch it is
  /// better to use one of the other provided static factory methods such as
  /// [MultiPolygon.fromPolygons].
  factory MultiPolygon.fromJsonMap(Map<String, dynamic> data) {
    if (data['coordinates'] == null) {
      throw ArgumentError.notNull('coordinates');
    }

    final List<List<List<Point>>> coordinates = data['coordinates']
        .map((dynamic it) => it //
            .map((dynamic it) => it //
                .map((dynamic it) =>
                    Point.fromCoordinates(GeoJsonUtils.normalize(it)))
                .cast<Point>()
                .toList())
            .cast<List<Point>>()
            .toList())
        .cast<List<List<Point>>>()
        .toList();

    BoundingBox bbox;
    if (data['bbox'] != null) {
      bbox = BoundingBox.fromCoordinates(GeoJsonUtils.normalize(data['bbox']));
    }

    return MultiPolygon._(coordinates, bbox);
  }

  /// Create a new instance of this class by defining a list of [Polygon]
  /// objects and passing that list in as a parameter in this method. The
  /// [Polygon]s should comply with the GeoJson specifications described in
  /// the documentation. Optionally, pass in an instance of a [BoundingBox]
  /// which better describes this [MultiPolygon].
  factory MultiPolygon.fromPolygons(List<Polygon> polygons,
      [BoundingBox bbox]) {
    return MultiPolygon._(
        polygons.map((Polygon it) => it.coordinates).toList(), bbox);
  }

  /// Create a new instance of this class by defining a single [Polygon] object
  /// and passing it in as a parameter in this method. The Polygon should comply
  /// with the GeoJson specifications described in the documentation.
  factory MultiPolygon.fromPolygon(Polygon polygon, [BoundingBox bbox]) {
    return MultiPolygon._(<List<List<Point>>>[polygon.coordinates], bbox);
  }

  /// Create a new instance of this class by defining a list of a list of a list
  /// of [Point]s which follow the correct specifications described in the
  /// [Point] documentation.
  factory MultiPolygon.fromLngLats(List<List<List<Point>>> points,
      [BoundingBox bbox]) {
    return MultiPolygon._(points, bbox);
  }

  factory MultiPolygon.fromCoordinates(
      List<List<List<List<double>>>> coordinates) {
    assert(coordinates != null);

    return MultiPolygon._(coordinates
        .map((List<List<List<double>>> it) => it
            .map((List<List<double>> it) => it //
                .map((List<double> it) =>
                    Point.fromCoordinates(GeoJsonUtils.normalize(it)))
                .toList())
            .toList())
        .toList());
  }

  MultiPolygon._(this.coordinates, [this.bbox]) : assert(coordinates != null);

  /// Returns a list of polygons which make up this [MultiPolygon] instance.
  List<Polygon> get polygons {
    return coordinates
        .map((List<List<Point>> it) => Polygon.fromLngLats(it))
        .toList();
  }

  /// This describes the TYPE of GeoJson geometry this object is, thus this will
  /// always return [GeoJsonType.multiPolygon]
  @override
  GeoJsonType get type => GeoJsonType.multiPolygon;

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

  /// Provides the list of list of list of [Point]s that make up the
  /// [MultiPolygon] geometry.
  @override
  final List<List<List<Point>>> coordinates;

  @override
  String get json => jsonEncode(jsonMap);

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      'coordinates': coordinates
          .map((List<List<Point>> it) => it
              .map((List<Point> it) => it //
                  .map((Point it) => it.coordinates)
                  .toList())
              .toList())
          .toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiPolygon && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<List<List<Point>>>()
              .equals(coordinates, other.coordinates);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<List<List<Point>>>().hash(coordinates);
}
