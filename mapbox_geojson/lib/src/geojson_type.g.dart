// GENERATED CODE - DO NOT MODIFY BY HAND

part of geojson_type;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GeoJsonType _$GeometryCollection =
    const GeoJsonType._('GeometryCollection');
const GeoJsonType _$Point = const GeoJsonType._('Point');
const GeoJsonType _$MultiPoint = const GeoJsonType._('MultiPoint');
const GeoJsonType _$LineString = const GeoJsonType._('LineString');
const GeoJsonType _$MultiLineString = const GeoJsonType._('MultiLineString');
const GeoJsonType _$Polygon = const GeoJsonType._('Polygon');
const GeoJsonType _$MultiPolygon = const GeoJsonType._('MultiPolygon');
const GeoJsonType _$Feature = const GeoJsonType._('Feature');
const GeoJsonType _$FeatureCollection =
    const GeoJsonType._('FeatureCollection');

GeoJsonType _$GeoJsonTypeValueOf(String name) {
  switch (name) {
    case 'GeometryCollection':
      return _$GeometryCollection;
    case 'Point':
      return _$Point;
    case 'MultiPoint':
      return _$MultiPoint;
    case 'LineString':
      return _$LineString;
    case 'MultiLineString':
      return _$MultiLineString;
    case 'Polygon':
      return _$Polygon;
    case 'MultiPolygon':
      return _$MultiPolygon;
    case 'Feature':
      return _$Feature;
    case 'FeatureCollection':
      return _$FeatureCollection;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GeoJsonType> _$GeoJsonTypeValues =
    new BuiltSet<GeoJsonType>(const <GeoJsonType>[
  _$GeometryCollection,
  _$Point,
  _$MultiPoint,
  _$LineString,
  _$MultiLineString,
  _$Polygon,
  _$MultiPolygon,
  _$Feature,
  _$FeatureCollection,
]);

Serializer<GeoJsonType> _$geoJsonTypeSerializer = new _$GeoJsonTypeSerializer();

class _$GeoJsonTypeSerializer implements PrimitiveSerializer<GeoJsonType> {
  @override
  final Iterable<Type> types = const <Type>[GeoJsonType];
  @override
  final String wireName = 'GeoJsonType';

  @override
  Object serialize(Serializers serializers, GeoJsonType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GeoJsonType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GeoJsonType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
