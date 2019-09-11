// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// This class represents a GeoJson [Polygon] which may or may not include
/// polygon holes.
///
/// To specify a constraint specific to [Polygon]s, it is useful to introduce
/// the concept of a linear ring:
///   * A linear ring is a closed [LineString] with four or more coordinates.
///   * The first and last coordinates are equivalent, and they MUST contain
///   identical values; their representation SHOULD also be identical.
///   * A linear ring is the boundary of a surface or the boundary of a hole in
///   a surface.
///   * A linear ring MUST follow the right-hand rule with respect to the area
///   it bounds, i.e., exterior rings are counterclockwise, and holes are
///   clockwise.
///
/// Note that most of the rules listed above are checked when a [Polygon]
/// instance is created (the exception being the last rule). If one of the rules
/// is broken, a [ArgumentError] will occur.
///
/// Though a linear ring is not explicitly represented as a GeoJson geometry
/// [GeoJsonType], it leads to a canonical formulation of the [Polygon] geometry
/// [Polygon.type]. When initializing a new instance of this class, a
/// [LineString] for the outer and optionally an inner are checked to ensure a
/// valid linear ring.
///
/// An example of a serialized polygon with no holes is given below:
/// ```json
/// {
///   "type": "Polygon",
///   "coordinates": [
///     [[100.0, 0.0],
///     [101.0, 0.0],
///     [101.0, 1.0],
///     [100.0, 1.0],
///     [100.0, 0.0]]
///   ]
/// }
/// ```
class Polygon implements CoordinateContainer<List<List<Point>>> {
  factory Polygon.fromJson(String json) {
    return Polygon.fromJsonMap(Map<String, dynamic>.from(jsonDecode(json)));
  }

  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String. If you are creating a Polygon object from scratch it is better to
  /// use one of the other provided factory constructors such as
  /// [Polygon.fromOuterInner].
  ///
  /// For a valid Polygon to exist, it must follow the linear ring rules and the
  /// first list of coordinates are considered the outer ring by default.
  factory Polygon.fromJsonMap(Map<String, dynamic> data) {
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

    return Polygon._(coordinates, bbox);
  }

  /// Create a new instance of this class by defining a list of [Point]s which
  /// follow the correct specifications described in the [Point] documentation.
  ///
  /// Note that the first and last point in the list should be the same
  /// enclosing the linear ring.
  factory Polygon.fromLngLats(List<List<Point>> coordinates,
      [BoundingBox bbox]) {
    return Polygon._(coordinates, bbox);
  }

  /// Create a new instance of this class by passing in an outer [LineString]
  /// and optionally one or more inner [LineStrings] contained within a list.
  /// Each of these [LineStrings] should follow the linear ring rules.
  ///
  /// Note that if a [LineString] breaks one of the linear ring rules, a
  /// [GeoJsonError] will be thrown.
  factory Polygon.fromOuterInner(LineString outer,
      [List<LineString> inner, BoundingBox bbox]) {
    _isLinearRing(outer);
    final List<List<Point>> coordinates = <List<Point>>[outer.coordinates];

    // If inner rings are set to null, return early.
    if (inner == null) {
      return Polygon._(coordinates, bbox);
    } else {
      inner.forEach(_isLinearRing);
      coordinates.addAll(inner.map((LineString it) => it.coordinates));

      return Polygon._(coordinates, bbox);
    }
  }

  factory Polygon.fromCoordinates(List<List<List<double>>> coordinates) {
    assert(coordinates != null);

    return Polygon._(coordinates
        .map((List<List<double>> it) => it
            .map((List<double> it) =>
                Point.fromCoordinates(GeoJsonUtils.normalize(it)))
            .toList())
        .toList());
  }

  Polygon._(this.coordinates, [this.bbox]) : assert(coordinates != null);

  /// Return a [LineString] defining the outer perimeter of this polygon
  LineString get outer => LineString.fromLngLats(coordinates[0]);

  /// Return a List of [LineString]s defining holes inside the polygon
  ///
  /// It is not guaranteed that this instance of [Polygon] contains holes and
  /// thus, might return a null or empty list.
  List<LineString> get inner {
    return coordinates.length <= 1
        ? <LineString>[]
        : coordinates
            .skip(1)
            .map((List<Point> points) => LineString.fromLngLats(points))
            .toList();
  }

  /// This describes the TYPE of GeoJson geometry this object is, thus this will
  /// always return [GeoJsonType.polygon]
  @override
  GeoJsonType get type => GeoJsonType.polygon;

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

  /// Provides the list of [Point]s that make up the [Polygon] geometry. The
  /// first list holds the different [LineStrings], first being the outer ring
  /// and the following entries being inner holes (if they exist).
  @override
  final List<List<Point>> coordinates;

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      'coordinates': coordinates
          .map((List<Point> it) => it //
              .map((Point it) => it.coordinates)
              .toList())
          .toList(),
    };
  }

  @override
  String get json => jsonEncode(jsonMap);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Polygon && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<List<Point>>()
              .equals(coordinates, other.coordinates);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<List<Point>>().hash(coordinates);

  /// Checks to ensure that the [LineStrings] defining the polygon correctly and
  /// adhering to the linear ring rules.
  ///
  /// Throws [GeoJsonError] if number of coordinates are less than 4, or
  /// first and last coordinates are not identical.
  static void _isLinearRing(LineString lineString) {
    if (lineString.coordinates.length < 4) {
      throw GeoJsonError(
          'LinearRings need to be made up of 4 or more coordinates.');
    }
    if (lineString.coordinates.first != lineString.coordinates.last) {
      throw GeoJsonError(
          'LinearRings require first and last coordinate to be identical.');
    }
  }
}
