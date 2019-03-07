// GENERATED CODE - DO NOT MODIFY BY HAND

part of point;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Point> _$pointSerializer = new _$PointSerializer();

class _$PointSerializer implements StructuredSerializer<Point> {
  @override
  final Iterable<Type> types = const [Point, _$Point];
  @override
  final String wireName = 'Point';

  @override
  Iterable serialize(Serializers serializers, Point object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'coordinates',
      serializers.serialize(object.coordinates,
          specifiedType:
              const FullType(BuiltList, const [const FullType(double)])),
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
  Point deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PointBuilder();

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
                      const FullType(BuiltList, const [const FullType(double)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$Point extends Point {
  @override
  final BoundingBox bbox;
  @override
  final BuiltList<double> coordinates;
  GeoJsonType __type;
  double __longitude;
  double __latitude;
  Map<String, dynamic> __json;

  factory _$Point([void updates(PointBuilder b)]) =>
      (new PointBuilder()..update(updates)).build() as _$Point;

  _$Point._({this.bbox, this.coordinates}) : super._() {
    if (coordinates == null) {
      throw new BuiltValueNullFieldError('Point', 'coordinates');
    }
  }

  @override
  GeoJsonType get type => __type ??= super.type;

  @override
  double get longitude => __longitude ??= super.longitude;

  @override
  double get latitude => __latitude ??= super.latitude;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  Point rebuild(void updates(PointBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$PointBuilder toBuilder() => new _$PointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Point &&
        bbox == other.bbox &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, bbox.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Point')
          ..add('bbox', bbox)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class _$PointBuilder extends PointBuilder {
  _$Point _$v;

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
  ListBuilder<double> get coordinates {
    _$this;
    return super.coordinates ??= new ListBuilder<double>();
  }

  @override
  set coordinates(ListBuilder<double> coordinates) {
    _$this;
    super.coordinates = coordinates;
  }

  _$PointBuilder() : super._();

  PointBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.coordinates = _$v.coordinates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Point other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Point;
  }

  @override
  void update(void updates(PointBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Point build() {
    _$Point _$result;
    try {
      _$result = _$v ??
          new _$Point._(
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
            'Point', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
