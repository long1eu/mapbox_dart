library geojson_type;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'geojson_type.g.dart';

class GeoJsonType extends EnumClass {
  const GeoJsonType._(String name) : super(name);

  static const GeoJsonType GeometryCollection = _$GeometryCollection;
  static const GeoJsonType Point = _$Point;
  static const GeoJsonType MultiPoint = _$MultiPoint;
  static const GeoJsonType LineString = _$LineString;
  static const GeoJsonType MultiLineString = _$MultiLineString;
  static const GeoJsonType Polygon = _$Polygon;
  static const GeoJsonType MultiPolygon = _$MultiPolygon;
  static const GeoJsonType Feature = _$Feature;
  static const GeoJsonType FeatureCollection = _$FeatureCollection;

  static BuiltSet<GeoJsonType> get values => _$GeoJsonTypeValues;

  static GeoJsonType valueOf(String name) => _$GeoJsonTypeValueOf(name);

  static Serializer<GeoJsonType> get serializer => _$geoJsonTypeSerializer;
}
