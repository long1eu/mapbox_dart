// GENERATED CODE - DO NOT MODIFY BY HAND

part of multi_point;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MultiPoint> _$multiPointSerializer = new _$MultiPointSerializer();

class _$MultiPointSerializer implements StructuredSerializer<MultiPoint> {
  @override
  final Iterable<Type> types = const [MultiPoint, _$MultiPoint];
  @override
  final String wireName = 'MultiPoint';

  @override
  Iterable serialize(Serializers serializers, MultiPoint object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'coordinates',
      serializers.serialize(object.coordinates,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Point)])),
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
  MultiPoint deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MultiPointBuilder();

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
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Point)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$MultiPoint extends MultiPoint {
  @override
  final BoundingBox bbox;
  @override
  final BuiltList<Point> coordinates;
  GeoJsonType __type;
  Map<String, dynamic> __json;

  factory _$MultiPoint([void updates(MultiPointBuilder b)]) =>
      (new MultiPointBuilder()..update(updates)).build() as _$MultiPoint;

  _$MultiPoint._({this.bbox, this.coordinates}) : super._() {
    if (coordinates == null) {
      throw new BuiltValueNullFieldError('MultiPoint', 'coordinates');
    }
  }

  @override
  GeoJsonType get type => __type ??= super.type;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  MultiPoint rebuild(void updates(MultiPointBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$MultiPointBuilder toBuilder() => new _$MultiPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiPoint &&
        bbox == other.bbox &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, bbox.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MultiPoint')
          ..add('bbox', bbox)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class _$MultiPointBuilder extends MultiPointBuilder {
  _$MultiPoint _$v;

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
  ListBuilder<Point> get coordinates {
    _$this;
    return super.coordinates ??= new ListBuilder<Point>();
  }

  @override
  set coordinates(ListBuilder<Point> coordinates) {
    _$this;
    super.coordinates = coordinates;
  }

  _$MultiPointBuilder() : super._();

  MultiPointBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.coordinates = _$v.coordinates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MultiPoint other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MultiPoint;
  }

  @override
  void update(void updates(MultiPointBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MultiPoint build() {
    _$MultiPoint _$result;
    try {
      _$result = _$v ??
          new _$MultiPoint._(
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
            'MultiPoint', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
