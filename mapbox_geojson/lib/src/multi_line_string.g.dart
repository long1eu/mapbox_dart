// GENERATED CODE - DO NOT MODIFY BY HAND

part of multi_line_string;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MultiLineString> _$multiLineStringSerializer =
    new _$MultiLineStringSerializer();

class _$MultiLineStringSerializer
    implements StructuredSerializer<MultiLineString> {
  @override
  final Iterable<Type> types = const [MultiLineString, _$MultiLineString];
  @override
  final String wireName = 'MultiLineString';

  @override
  Iterable serialize(Serializers serializers, MultiLineString object,
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
  MultiLineString deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MultiLineStringBuilder();

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

class _$MultiLineString extends MultiLineString {
  @override
  final BoundingBox bbox;
  @override
  final BuiltList<BuiltList<Point>> coordinates;
  GeoJsonType __type;
  Map<String, dynamic> __json;

  factory _$MultiLineString([void updates(MultiLineStringBuilder b)]) =>
      (new MultiLineStringBuilder()..update(updates)).build()
          as _$MultiLineString;

  _$MultiLineString._({this.bbox, this.coordinates}) : super._() {
    if (coordinates == null) {
      throw new BuiltValueNullFieldError('MultiLineString', 'coordinates');
    }
  }

  @override
  GeoJsonType get type => __type ??= super.type;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  MultiLineString rebuild(void updates(MultiLineStringBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$MultiLineStringBuilder toBuilder() =>
      new _$MultiLineStringBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiLineString &&
        bbox == other.bbox &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, bbox.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MultiLineString')
          ..add('bbox', bbox)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class _$MultiLineStringBuilder extends MultiLineStringBuilder {
  _$MultiLineString _$v;

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

  _$MultiLineStringBuilder() : super._();

  MultiLineStringBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.coordinates = _$v.coordinates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MultiLineString other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MultiLineString;
  }

  @override
  void update(void updates(MultiLineStringBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MultiLineString build() {
    _$MultiLineString _$result;
    try {
      _$result = _$v ??
          new _$MultiLineString._(
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
            'MultiLineString', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
