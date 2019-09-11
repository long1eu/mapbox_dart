// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A multilinestring is an array of [LineString] coordinate arrays.
///
/// This adheres to the RFC 7946 internet standard when serialized into JSON.
///
/// When representing a [LineString] that crosses the antimeridian,
/// interoperability is improved by modifying their geometry. Any geometry that
/// crosses the antimeridian SHOULD be represented by cutting it in two such
/// that neither part's representation crosses the antimeridian.
///
/// For example, a line extending from 45 degrees N, 170 degrees E across the
/// antimeridian to 45 degrees N, 170 degrees W should be cut in two and
/// represented as a [MultiLineString].
///
/// A sample GeoJson [MultiLineString]'s provided below (in it's serialized
/// state).
/// ```json
/// {
///   "type": "MultiLineString",
///   "coordinates": [
///     [
///       [100.0, 0.0],
///       [101.0, 1.0]
///     ],
///     [
///       [102.0, 2.0],
///       [103.0, 3.0]
///     ]
///   ]
/// }
/// ```
/// Look over the [LineString] documentation to get more information about
/// formatting your list of linestring objects correctly.
class MultiLineString implements CoordinateContainer<List<List<Point>>> {
  factory MultiLineString.fromJson(String json) {
    return MultiLineString.fromJsonMap(
        Map<String, dynamic>.from(jsonDecode(json)));
  }

  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String. If you are creating a [MultiLineString] object from scratch it is
  /// better to use one of the other provided factory constructors such as
  /// [MultiLineString.fromLineStrings].
  factory MultiLineString.fromJsonMap(Map<String, dynamic> data) {
    if (data['coordinates'] == null) {
      throw ArgumentError.notNull('coordinates');
    }

    final List<List<Point>> coordinates = data['coordinates']
        .map((dynamic it) => it //
            .map((dynamic it) =>
                Point.fromCoordinates(GeoJsonUtils.normalize(it)))
            .cast<Point>()
            .toList())
        .cast<List<Point>>()
        .toList();

    BoundingBox bbox;
    if (data['bbox'] != null) {
      bbox = BoundingBox.fromCoordinates(GeoJsonUtils.normalize(data['bbox']));
    }

    return MultiLineString._(coordinates, bbox);
  }

  /// Create a new instance of this class by defining a list of [LineString]
  /// objects and passing that list in as a parameter in this method.
  ///
  /// The [LineStrings] should comply with the GeoJson specifications described
  /// in the documentation. Optionally, pass in an instance of a [BoundingBox]
  /// which better describes this [MultiLineString].
  factory MultiLineString.fromLineStrings(List<LineString> lineStrings,
      [BoundingBox bbox]) {
    return MultiLineString._(
        lineStrings.map((LineString it) => it.coordinates).toList(), bbox);
  }

  /// Create a new instance of this class by passing in a single [LineString]
  /// object.
  ///
  /// The LineStrings should comply with the GeoJson specifications described in
  /// the documentation.
  factory MultiLineString.fromLineString(LineString lineString,
      [BoundingBox bbox]) {
    return MultiLineString._(<List<Point>>[lineString.coordinates], bbox);
  }

  /// Create a new instance of this class by defining a list of a list of
  /// [Point]s which follow the correct specifications described in the [Point]
  /// documentation.
  ///
  /// Note that there should not be any duplicate points inside the list and the
  /// points combined should create a [LineString] with a distance greater
  /// than 0.
  factory MultiLineString.fromLngLats(List<List<Point>> points,
      [BoundingBox bbox]) {
    return MultiLineString._(points, bbox);
  }

  factory MultiLineString.fromCoordinates(
      List<List<List<double>>> coordinates) {
    assert(coordinates != null);

    return MultiLineString._(coordinates
        .map((List<List<double>> it) => it
            .map((List<double> it) =>
                Point.fromCoordinates(GeoJsonUtils.normalize(it)))
            .toList())
        .toList());
  }

  MultiLineString._(this.coordinates, [this.bbox])
      : assert(coordinates != null);

  /// This describes the TYPE of GeoJson geometry this object is, thus this will
  /// always return [GeoJsonType.multiLineString]
  @override
  GeoJsonType get type => GeoJsonType.multiLineString;

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

  /// Provides the list of list of [Point]s that make up the [MultiLineString]
  /// geometry.
  @override
  final List<List<Point>> coordinates;

  /// Returns a list of [LineStrings] which are currently making up this
  /// [MultiLineString].
  List<LineString> get lineStrings {
    return coordinates
        .map((List<Point> points) => LineString.fromLngLats(points))
        .toList();
  }

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      'coordinates': coordinates
          .map(
              (List<Point> it) => it.map((Point it) => it.coordinates).toList())
          .toList(),
    };
  }

  @override
  String get json => jsonEncode(jsonMap);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiLineString && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<List<Point>>()
              .equals(coordinates, other.coordinates);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<List<Point>>().hash(coordinates);
}
