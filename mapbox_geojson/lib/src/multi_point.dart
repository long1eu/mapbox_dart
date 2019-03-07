library multi_point;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/line_string.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/serializers.dart';
import 'package:meta/meta.dart';

part 'multi_point.g.dart';

abstract class MultiPoint implements Built<MultiPoint, MultiPointBuilder>, CoordinateContainer<BuiltList<Point>> {
  factory MultiPoint([void updates(MultiPointBuilder b)]) = _$MultiPoint;

  /// Create a new instance of this class by defining a list of [Point]s which follow the
  /// correct specifications described in the Point documentation. Note that there should not be any
  /// duplicate points inside the list. <p> Note that if less than 2 points are passed in, a runtime
  /// exception will occur. </p>
  ///
  /// [points] a list of [Point]s which make up the [LineString] geometry
  /// [bbox]   optionally include a bbox definition as a double array
  factory MultiPoint.fromLngLats({@required List<Point> points, BoundingBox bbox}) {
    return MultiPoint((b) {
      b
        ..coordinates = ListBuilder<Point>(points)
        ..bbox = bbox?.toBuilder();
    });
  }

  factory MultiPoint.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  MultiPoint._();

  /// This describes the TYPE of GeoJson this object is, thus this will always return [GeoJsonType.MultiPoint]
  @memoized
  @override
  GeoJsonType get type => GeoJsonType.MultiPoint;

  /// A Feature Collection might have a member named {@code bbox} to include information on the
  /// coordinate range for it's {@link Feature}s. The value of the bbox member MUST be a list of size
  /// 2*n where n is the number of dimensions represented in the contained feature geometries, with
  /// all axes of the most southwesterly point followed by all axes of the more northeasterly point.
  /// The axes order of a bbox follows the axes order of geometries.
  ///
  /// Return a list of double coordinate values describing a bounding box
  @nullable
  @override
  BoundingBox get bbox;

  /// Provides the list of [Point]s that make up the MultiPoint geometry.
  @override
  BuiltList<Point> get coordinates;

  @memoized
  @override
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<MultiPoint> get serializer => _$multiPointSerializer;
}

abstract class MultiPointBuilder implements Builder<MultiPoint, MultiPointBuilder> {
  BoundingBoxBuilder bbox;

  ListBuilder<Point> coordinates;

  factory MultiPointBuilder() = _$MultiPointBuilder;

  MultiPointBuilder._();
}
