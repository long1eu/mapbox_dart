// GENERATED CODE - DO NOT MODIFY BY HAND

part of bounding_box;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BoundingBox> _$boundingBoxSerializer = new _$BoundingBoxSerializer();

class _$BoundingBoxSerializer implements StructuredSerializer<BoundingBox> {
  @override
  final Iterable<Type> types = const [BoundingBox, _$BoundingBox];
  @override
  final String wireName = 'BoundingBox';

  @override
  Iterable serialize(Serializers serializers, BoundingBox object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'southwest',
      serializers.serialize(object.southwest,
          specifiedType: const FullType(Point)),
      'northeast',
      serializers.serialize(object.northeast,
          specifiedType: const FullType(Point)),
    ];

    return result;
  }

  @override
  BoundingBox deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BoundingBoxBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'southwest':
          result.southwest.replace(serializers.deserialize(value,
              specifiedType: const FullType(Point)) as Point);
          break;
        case 'northeast':
          result.northeast.replace(serializers.deserialize(value,
              specifiedType: const FullType(Point)) as Point);
          break;
      }
    }

    return result.build();
  }
}

class _$BoundingBox extends BoundingBox {
  @override
  final Point southwest;
  @override
  final Point northeast;
  double __west;
  double __south;
  double __east;
  double __north;
  Map<String, dynamic> __json;

  factory _$BoundingBox([void updates(BoundingBoxBuilder b)]) =>
      (new BoundingBoxBuilder()..update(updates)).build();

  _$BoundingBox._({this.southwest, this.northeast}) : super._() {
    if (southwest == null) {
      throw new BuiltValueNullFieldError('BoundingBox', 'southwest');
    }
    if (northeast == null) {
      throw new BuiltValueNullFieldError('BoundingBox', 'northeast');
    }
  }

  @override
  double get west => __west ??= super.west;

  @override
  double get south => __south ??= super.south;

  @override
  double get east => __east ??= super.east;

  @override
  double get north => __north ??= super.north;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  BoundingBox rebuild(void updates(BoundingBoxBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BoundingBoxBuilder toBuilder() => new BoundingBoxBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BoundingBox &&
        southwest == other.southwest &&
        northeast == other.northeast;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, southwest.hashCode), northeast.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BoundingBox')
          ..add('southwest', southwest)
          ..add('northeast', northeast))
        .toString();
  }
}

class BoundingBoxBuilder implements Builder<BoundingBox, BoundingBoxBuilder> {
  _$BoundingBox _$v;

  PointBuilder _southwest;
  PointBuilder get southwest => _$this._southwest ??= new PointBuilder();
  set southwest(PointBuilder southwest) => _$this._southwest = southwest;

  PointBuilder _northeast;
  PointBuilder get northeast => _$this._northeast ??= new PointBuilder();
  set northeast(PointBuilder northeast) => _$this._northeast = northeast;

  BoundingBoxBuilder();

  BoundingBoxBuilder get _$this {
    if (_$v != null) {
      _southwest = _$v.southwest?.toBuilder();
      _northeast = _$v.northeast?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BoundingBox other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BoundingBox;
  }

  @override
  void update(void updates(BoundingBoxBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BoundingBox build() {
    _$BoundingBox _$result;
    try {
      _$result = _$v ??
          new _$BoundingBox._(
              southwest: southwest.build(), northeast: northeast.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'southwest';
        southwest.build();
        _$failedField = 'northeast';
        northeast.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BoundingBox', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
