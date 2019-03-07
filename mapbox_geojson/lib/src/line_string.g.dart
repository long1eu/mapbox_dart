// GENERATED CODE - DO NOT MODIFY BY HAND

part of line_string;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LineString> _$lineStringSerializer = new _$LineStringSerializer();

class _$LineStringSerializer implements StructuredSerializer<LineString> {
  @override
  final Iterable<Type> types = const [LineString, _$LineString];
  @override
  final String wireName = 'LineString';

  @override
  Iterable serialize(Serializers serializers, LineString object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'bbox',
      serializers.serialize(object.bbox,
          specifiedType: const FullType(BoundingBox)),
      'coordinates',
      serializers.serialize(object.coordinates,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Point)])),
    ];

    return result;
  }

  @override
  LineString deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LineStringBuilder();

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

class _$LineString extends LineString {
  @override
  final BoundingBox bbox;
  @override
  final BuiltList<Point> coordinates;
  GeoJsonType __type;
  Map<String, dynamic> __json;

  factory _$LineString([void updates(LineStringBuilder b)]) =>
      (new LineStringBuilder()..update(updates)).build() as _$LineString;

  _$LineString._({this.bbox, this.coordinates}) : super._() {
    if (bbox == null) {
      throw new BuiltValueNullFieldError('LineString', 'bbox');
    }
    if (coordinates == null) {
      throw new BuiltValueNullFieldError('LineString', 'coordinates');
    }
  }

  @override
  GeoJsonType get type => __type ??= super.type;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  LineString rebuild(void updates(LineStringBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$LineStringBuilder toBuilder() => new _$LineStringBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LineString &&
        bbox == other.bbox &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, bbox.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LineString')
          ..add('bbox', bbox)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class _$LineStringBuilder extends LineStringBuilder {
  _$LineString _$v;

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

  _$LineStringBuilder() : super._();

  LineStringBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.coordinates = _$v.coordinates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LineString other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LineString;
  }

  @override
  void update(void updates(LineStringBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$LineString build() {
    _$LineString _$result;
    try {
      _$result = _$v ??
          new _$LineString._(
              bbox: bbox.build(), coordinates: coordinates.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bbox';
        bbox.build();
        _$failedField = 'coordinates';
        coordinates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LineString', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
