// GENERATED CODE - DO NOT MODIFY BY HAND

part of multi_polygon;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MultiPolygon> _$multiPolygonSerializer =
    new _$MultiPolygonSerializer();

class _$MultiPolygonSerializer implements StructuredSerializer<MultiPolygon> {
  @override
  final Iterable<Type> types = const [MultiPolygon, _$MultiPolygon];
  @override
  final String wireName = 'MultiPolygon';

  @override
  Iterable serialize(Serializers serializers, MultiPolygon object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'coordinates',
      serializers.serialize(object.coordinates,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(Point)])
            ])
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
  MultiPolygon deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MultiPolygonBuilder();

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
                const FullType(BuiltList, const [
                  const FullType(BuiltList, const [const FullType(Point)])
                ])
              ])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$MultiPolygon extends MultiPolygon {
  @override
  final BoundingBox bbox;
  @override
  final BuiltList<BuiltList<BuiltList<Point>>> coordinates;
  List<Polygon> __polygons;
  Map<String, dynamic> __json;

  factory _$MultiPolygon([void updates(MultiPolygonBuilder b)]) =>
      (new MultiPolygonBuilder()..update(updates)).build() as _$MultiPolygon;

  _$MultiPolygon._({this.bbox, this.coordinates}) : super._() {
    if (coordinates == null) {
      throw new BuiltValueNullFieldError('MultiPolygon', 'coordinates');
    }
  }

  @override
  List<Polygon> get polygons => __polygons ??= super.polygons;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  MultiPolygon rebuild(void updates(MultiPolygonBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$MultiPolygonBuilder toBuilder() =>
      new _$MultiPolygonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiPolygon &&
        bbox == other.bbox &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, bbox.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MultiPolygon')
          ..add('bbox', bbox)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class _$MultiPolygonBuilder extends MultiPolygonBuilder {
  _$MultiPolygon _$v;

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
  ListBuilder<BuiltList<BuiltList<Point>>> get coordinates {
    _$this;
    return super.coordinates ??= new ListBuilder<BuiltList<BuiltList<Point>>>();
  }

  @override
  set coordinates(ListBuilder<BuiltList<BuiltList<Point>>> coordinates) {
    _$this;
    super.coordinates = coordinates;
  }

  _$MultiPolygonBuilder() : super._();

  MultiPolygonBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.coordinates = _$v.coordinates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MultiPolygon other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MultiPolygon;
  }

  @override
  void update(void updates(MultiPolygonBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MultiPolygon build() {
    _$MultiPolygon _$result;
    try {
      _$result = _$v ??
          new _$MultiPolygon._(
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
            'MultiPolygon', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
