// GENERATED CODE - DO NOT MODIFY BY HAND

part of polygon;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Polygon> _$polygonSerializer = new _$PolygonSerializer();

class _$PolygonSerializer implements StructuredSerializer<Polygon> {
  @override
  final Iterable<Type> types = const [Polygon, _$Polygon];
  @override
  final String wireName = 'Polygon';

  @override
  Iterable serialize(Serializers serializers, Polygon object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'coordinates',
      serializers.serialize(object.coordinates,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(Point)])
          ])),
    ];
    if (object.bbox != null) {
      result
        ..add('bbox')
        ..add(serializers.serialize(object.bbox,
            specifiedType: const FullType(BoundingBox)));
    }

    return result;
  }

  @override
  Polygon deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PolygonBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'bbox':
          result.bbox.replace(serializers.deserialize(value,
              specifiedType: const FullType(BoundingBox)) as BoundingBox);
          break;
        case 'coordinates':
          result.coordinates.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(Point)])
              ])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$Polygon extends Polygon {
  @override
  final BoundingBox bbox;
  @override
  final BuiltList<BuiltList<Point>> coordinates;
  GeoJsonType __type;
  Map<String, dynamic> __json;

  factory _$Polygon([void updates(PolygonBuilder b)]) =>
      (new PolygonBuilder()..update(updates)).build() as _$Polygon;

  _$Polygon._({this.bbox, this.coordinates}) : super._() {
    if (coordinates == null) {
      throw new BuiltValueNullFieldError('Polygon', 'coordinates');
    }
  }

  @override
  GeoJsonType get type => __type ??= super.type;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  Polygon rebuild(void updates(PolygonBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$PolygonBuilder toBuilder() => new _$PolygonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Polygon &&
        bbox == other.bbox &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, bbox.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Polygon')
          ..add('bbox', bbox)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class _$PolygonBuilder extends PolygonBuilder {
  _$Polygon _$v;

  @override
  BoundingBoxBuilder get bbox {
    _$this;
    return super.bbox ??= new BoundingBoxBuilder();
  }

  @override
  set bbox(BoundingBoxBuilder bbox) {
    _$this;
    super.bbox = bbox;
  }

  @override
  ListBuilder<BuiltList<Point>> get coordinates {
    _$this;
    return super.coordinates ??= new ListBuilder<BuiltList<Point>>();
  }

  @override
  set coordinates(ListBuilder<BuiltList<Point>> coordinates) {
    _$this;
    super.coordinates = coordinates;
  }

  _$PolygonBuilder() : super._();

  PolygonBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.coordinates = _$v.coordinates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Polygon other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Polygon;
  }

  @override
  void update(void updates(PolygonBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Polygon build() {
    _$Polygon _$result;
    try {
      _$result = _$v ??
          new _$Polygon._(
              bbox: super.bbox?.build(), coordinates: coordinates.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bbox';
        super.bbox?.build();
        _$failedField = 'coordinates';
        coordinates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Polygon', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
