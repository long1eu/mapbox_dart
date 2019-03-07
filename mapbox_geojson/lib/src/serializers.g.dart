// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(BoundingBox.serializer)
      ..add(Feature.serializer)
      ..add(GeoJsonType.serializer)
      ..add(GeometryCollection.serializer)
      ..add(LineString.serializer)
      ..add(MultiLineString.serializer)
      ..add(MultiPoint.serializer)
      ..add(MultiPolygon.serializer)
      ..add(Point.serializer)
      ..add(Polygon.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(Point)])
            ])
          ]),
          () => new ListBuilder<BuiltList<BuiltList<Point>>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(Point)])
          ]),
          () => new ListBuilder<BuiltList<Point>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(Point)])
          ]),
          () => new ListBuilder<BuiltList<Point>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Geometry)]),
          () => new ListBuilder<Geometry>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Point)]),
          () => new ListBuilder<Point>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Point)]),
          () => new ListBuilder<Point>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(double)]),
          () => new ListBuilder<double>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(Object)]),
          () => new MapBuilder<String, Object>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
