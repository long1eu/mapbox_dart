// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A [MultiPoint] represents two or more geographic points that share a
/// relationship and is one of the seven geometries found in the GeoJson spec.
///
/// This adheres to the RFC 7946 internet standard when serialized into JSON.
///
/// The list of points must be equal to or greater than 2.
///
/// A sample GeoJson MultiPoint's provided below (in it's serialized state).
/// ```json
/// {
///   "TYPE": "MultiPoint",
///   "coordinates": [
///     [100.0, 0.0],
///     [101.0, 1.0]
///   ]
/// }
/// ```
/// Look over the [Point] documentation to get more information about formatting
/// your list of point objects correctly.
class MultiPoint implements CoordinateContainer<List<Point>> {
  factory MultiPoint.fromJson(String json) {
    return MultiPoint.fromJsonMap(Map<String, dynamic>.from(jsonDecode(json)));
  }

  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String. If you are creating a MultiPoint object from scratch it is better
  /// to use one of the other provided factory constructors such as
  /// [MultiPoint.fromLngLats].
  ///
  /// For a valid [MultiPoint] to exist, it must have at least 2 coordinate
  /// entries.
  factory MultiPoint.fromJsonMap(Map<String, dynamic> data) {
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

    return MultiPoint._(coordinates, bbox);
  }

  /// Create a new instance of this class by defining a list of [Point]s which
  /// follow the correct specifications described in the [Point] documentation.
  ///
  /// Note that there should not be any duplicate points inside the list.
  ///
  /// Note that if less than 2 points are passed in, a runtime exception will
  /// occur.
  factory MultiPoint.fromLngLats(List<Point> points, [BoundingBox bbox]) {
    return MultiPoint._(points, bbox);
  }

  factory MultiPoint.fromCoordinates(List<List<double>> coordinates) {
    assert(coordinates != null);

    return MultiPoint._(coordinates
        .map((List<double> it) =>
            Point.fromCoordinates(GeoJsonUtils.normalize(it)))
        .toList());
  }

  const MultiPoint._(this.coordinates, [this.bbox])
      : assert(coordinates != null);

  /// This describes the TYPE of GeoJson this object is, thus this will always
  /// return [GeoJsonType.MultiPoint]

  @override
  GeoJsonType get type => GeoJsonType.multiPoint;

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

  /// Provides the list of [Point]s that make up the [MultiPoint] geometry.
  @override
  final List<Point> coordinates;

  @override
  String get json => jsonEncode(jsonMap);

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      'coordinates': coordinates.map((Point it) => it.coordinates).toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiPoint && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<Point>().equals(coordinates, other.coordinates);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<Point>().hash(coordinates);
}
