// GENERATED CODE - DO NOT MODIFY BY HAND

part of feature;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Feature> _$featureSerializer = new _$FeatureSerializer();

class _$FeatureSerializer implements StructuredSerializer<Feature> {
  @override
  final Iterable<Type> types = const [Feature, _$Feature];
  @override
  final String wireName = 'Feature';

  @override
  Iterable serialize(Serializers serializers, Feature object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'properties',
      serializers.serialize(object.properties,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(Object)])),
    ];
    if (object.bbox != null) {
      result
        ..add('bbox')
        ..add(serializers.serialize(object.bbox,
            specifiedType: const FullType(BoundingBox)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.geometry != null) {
      result
        ..add('geometry')
        ..add(serializers.serialize(object.geometry,
            specifiedType: const FullType(Geometry)));
    }

    return result;
  }

  @override
  Feature deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeatureBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'geometry':
          result.geometry = serializers.deserialize(value,
              specifiedType: const FullType(Geometry)) as Geometry;
          break;
        case 'properties':
          result.properties.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(Object)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$Feature extends Feature {
  @override
  final BoundingBox bbox;
  @override
  final String id;
  @override
  final Geometry geometry;
  @override
  final BuiltMap<String, Object> properties;
  Map<String, dynamic> __json;

  factory _$Feature([void updates(FeatureBuilder b)]) =>
      (new FeatureBuilder()..update(updates)).build() as _$Feature;

  _$Feature._({this.bbox, this.id, this.geometry, this.properties})
      : super._() {
    if (properties == null) {
      throw new BuiltValueNullFieldError('Feature', 'properties');
    }
  }

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  Feature rebuild(void updates(FeatureBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$FeatureBuilder toBuilder() => new _$FeatureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Feature &&
        bbox == other.bbox &&
        id == other.id &&
        geometry == other.geometry &&
        properties == other.properties;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, bbox.hashCode), id.hashCode), geometry.hashCode),
        properties.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Feature')
          ..add('bbox', bbox)
          ..add('id', id)
          ..add('geometry', geometry)
          ..add('properties', properties))
        .toString();
  }
}

class _$FeatureBuilder extends FeatureBuilder {
  _$Feature _$v;

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
  String get id {
    _$this;
    return super.id;
  }

  @override
  set id(String id) {
    _$this;
    super.id = id;
  }

  @override
  Geometry get geometry {
    _$this;
    return super.geometry;
  }

  @override
  set geometry(Geometry geometry) {
    _$this;
    super.geometry = geometry;
  }

  @override
  MapBuilder<String, Object> get properties {
    _$this;
    return super.properties ??= new MapBuilder<String, Object>();
  }

  @override
  set properties(MapBuilder<String, Object> properties) {
    _$this;
    super.properties = properties;
  }

  _$FeatureBuilder() : super._();

  FeatureBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.id = _$v.id;
      super.geometry = _$v.geometry;
      super.properties = _$v.properties?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Feature other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Feature;
  }

  @override
  void update(void updates(FeatureBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Feature build() {
    _$Feature _$result;
    try {
      _$result = _$v ??
          new _$Feature._(
              bbox: super.bbox?.build(),
              id: id,
              geometry: geometry,
              properties: properties.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bbox';
        super.bbox?.build();

        _$failedField = 'properties';
        properties.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Feature', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
