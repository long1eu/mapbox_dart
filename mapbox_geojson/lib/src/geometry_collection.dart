library geometry_collection;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/serializers.dart';

part 'geometry_collection.g.dart';

/// A GeoJson object with TYPE [GeoJsonType.GeometryCollection] is a Geometry object.
/// <p>
/// A [GeometryCollection] has a member with the name [geometries]. The value of [geometries] is a List
/// Each element of this list is a GeoJson [Geometry] object. It is possible for this list to be empty.
/// <p>
/// Unlike the other geometry types, a [GeometryCollection] can be a heterogeneous composition of
/// smaller [Geometry] objects. For example, a [Geometry] object in the shape of a lowercase roman "i"
/// can be composed of one point and one [LineString].
/// <p>
/// [GeometryCollections] have a different syntax from single TYPE Geometry objects ([Point],
/// [LineString], and [Polygon]) and homogeneously typed multipart [Geometry] objects ([MultiPoint],
/// [MultiLineString], and [MultiPolygon]) but have no different semantics.  Although a
/// [GeometryCollection] object has no [coordinates] member, it does have coordinates: the coordinates
/// of all its parts belong to the collection. The [geometries] member of a [GeometryCollection]
/// describes the parts of this composition. Implementations SHOULD NOT apply any additional
/// semantics to the [geometries] array.
/// <p>
/// To maximize interoperability, implementations SHOULD avoid nested [GeometryCollection]s.
/// Furthermore, [GeometryCollection]s composed of a single part or a number of parts of a single TYPE
/// SHOULD be avoided when that single part or a single object of multipart TYPE ([MultiPoint],
/// [MultiLineString], or [MultiPolygon]) could be used instead.
/// <p>
/// An example of a serialized [GeometryCollection]s given below:
/// ```json
/// {
///   "TYPE": "GeometryCollection",
///   "geometries": [{
///     "TYPE": "Point",
///     "coordinates": [100.0, 0.0]
///   }, {
///     "TYPE": "LineString",
///     "coordinates": [
///       [101.0, 0.0],
///       [102.0, 1.0]
///     ]
///   }]
/// }
/// ```
abstract class GeometryCollection extends Object
    implements Geometry, Built<GeometryCollection, GeometryCollectionBuilder> {
  factory GeometryCollection([void updates(GeometryCollectionBuilder b)]) = _$GeometryCollection;

  factory GeometryCollection.fromGeometry({List<Geometry> geometries, Geometry geometry, BoundingBox bbox}) {
    assert(geometries != null || geometry != null);

    return GeometryCollection((GeometryCollectionBuilder b) {
      b
        ..geometries = ListBuilder(geometries != null ? geometries : <Geometry>[geometry])
        ..bbox = bbox?.toBuilder();
    });
  }

  factory GeometryCollection.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  GeometryCollection._();

  /// This describes the TYPE of GeoJson this object is, thus this will always return [GeoJsonType.GeometryCollection]
  @memoized
  GeoJsonType get type => GeoJsonType.GeometryCollection;

  /// A Feature Collection might have a member named [bbox] to include information on the
  /// coordinate range for it's {@link Feature}s. The value of the bbox member MUST be a list of
  /// size 2*n where n is the number of dimensions represented in the contained feature geometries,
  /// with all axes of the most southwesterly point followed by all axes of the more northeasterly
  /// point. The axes order of a bbox follows the axes order of geometries.
  ///
  /// Return a list of double coordinate values describing a bounding box
  @override
  @nullable
  BoundingBox get bbox;

  /// This provides the list of geometry making up this Geometry Collection. Note that if the
  /// Geometry Collection was created through [GeometryCollection.fromJson] this list could be null.
  /// Otherwise, the list can't be null but the size of the list can equal 0.
  ///
  /// @return a list of {@link Geometry} which make up this Geometry Collection
  /// @since 1.0.0
  BuiltList<Geometry> get geometries;

  @memoized
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<GeometryCollection> get serializer => _$geometryCollectionSerializer;
}

abstract class GeometryCollectionBuilder implements Builder<GeometryCollection, GeometryCollectionBuilder> {
  BoundingBoxBuilder bbox;

  ListBuilder<Geometry> geometries;

  factory GeometryCollectionBuilder() = _$GeometryCollectionBuilder;

  GeometryCollectionBuilder._();
}
