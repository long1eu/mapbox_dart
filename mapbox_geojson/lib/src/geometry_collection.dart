// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A GeoJson object with TYPE [GeoJsonType.geometryCollection] is a Geometry
/// object.
///
/// Unlike the other geometry types, a [GeometryCollection] can be a
/// heterogeneous composition of smaller [Geometry] objects. For example, a
/// [Geometry] object in the shape of a lowercase roman "i" can be composed of
/// one point and one [LineString].
///
/// [GeometryCollections] have a different syntax from single type Geometry
/// objects ([Point], [LineString], and [Polygon]) and homogeneously typed
/// multipart [Geometry] objects ([MultiPoint], [MultiLineString],
/// and [MultiPolygon]) but have no different semantics.
///
/// Although a [GeometryCollection] object has no [coordinates] member, it does
/// have coordinates: the coordinates of all its parts belong to the collection.
///
/// The [geometries] member of a [GeometryCollection] describes the parts of
/// this composition. Implementations SHOULD NOT apply any additional semantics
/// to the [geometries] array.
///
/// To maximize interoperability, implementations SHOULD avoid nested
/// [GeometryCollection]s. Furthermore, [GeometryCollection]s composed of a
/// single part or a number of parts of a single type SHOULD be avoided when
/// that single part or a single object of multipart TYPE ([MultiPoint],
/// [MultiLineString], or [MultiPolygon]) could be used instead.
///
/// An example of a serialized [GeometryCollection]s given below:
/// ```json
/// {
///   "type": "GeometryCollection",
///   "geometries": [{
///     "type": "Point",
///     "coordinates": [100.0, 0.0]
///   }, {
///     "type": "LineString",
///     "coordinates": [
///       [101.0, 0.0],
///       [102.0, 1.0]
///     ]
///   }]
/// }
/// ```
class GeometryCollection implements Geometry {
  factory GeometryCollection.fromJson(String json) {
    return GeometryCollection.fromJsonMap(
        Map<String, dynamic>.from(jsonDecode(json)));
  }

  factory GeometryCollection.fromJsonMap(Map<String, dynamic> data) {
    if (data['geometries'] == null) {
      throw ArgumentError.notNull('geometries');
    }

    final List<Geometry> geometries = data['geometries']
        .map((dynamic it) => Geometry.fromJson(it))
        .cast<Geometry>()
        .toList();

    BoundingBox bbox;
    if (data['bbox'] != null) {
      bbox = BoundingBox.fromCoordinates(GeoJsonUtils.normalize(data['bbox']));
    }

    return GeometryCollection._(geometries, bbox);
  }

  factory GeometryCollection.fromGeometry(Geometry geometry,
      [BoundingBox bbox]) {
    assert(geometry != null);
    return GeometryCollection._(<Geometry>[geometry], bbox);
  }

  factory GeometryCollection.fromGeometries(List<Geometry> geometries,
      [BoundingBox bbox]) {
    assert(geometries != null);

    return GeometryCollection._(geometries, bbox);
  }

  const GeometryCollection._(this.geometries, [this.bbox])
      : assert(geometries != null);

  /// This describes the type of GeoJson this object is, thus this will always
  /// return [GeoJsonType.geometryCollection]
  @override
  GeoJsonType get type => GeoJsonType.geometryCollection;

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

  /// This provides the list of geometry making up this Geometry Collection. Note that if the
  /// Geometry Collection was created through [GeometryCollection.fromJson] this list could be null.
  /// Otherwise, the list can't be null but the size of the list can equal 0.
  ///
  /// @return a list of {@link Geometry} which make up this Geometry Collection
  /// @since 1.0.0
  final List<Geometry> geometries;

  @override
  String get json => jsonEncode(jsonMap);

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      'geometries': geometries.map((Geometry it) => it.jsonMap).toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeometryCollection && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<Geometry>().equals(geometries, other.geometries);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<Geometry>().hash(geometries);
}
