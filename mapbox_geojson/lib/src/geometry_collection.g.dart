// GENERATED CODE - DO NOT MODIFY BY HAND

part of geometry_collection;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GeometryCollection> _$geometryCollectionSerializer =
    new _$GeometryCollectionSerializer();

class _$GeometryCollectionSerializer
    implements StructuredSerializer<GeometryCollection> {
  @override
  final Iterable<Type> types = const [GeometryCollection, _$GeometryCollection];
  @override
  final String wireName = 'GeometryCollection';

  @override
  Iterable serialize(Serializers serializers, GeometryCollection object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'geometries',
      serializers.serialize(object.geometries,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Geometry)])),
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
  GeometryCollection deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeometryCollectionBuilder();

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
        case 'geometries':
          result.geometries.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Geometry)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$GeometryCollection extends GeometryCollection {
  @override
  final BoundingBox bbox;
  @override
  final BuiltList<Geometry> geometries;
  GeoJsonType __type;
  Map<String, dynamic> __json;

  factory _$GeometryCollection([void updates(GeometryCollectionBuilder b)]) =>
      (new GeometryCollectionBuilder()..update(updates)).build()
          as _$GeometryCollection;

  _$GeometryCollection._({this.bbox, this.geometries}) : super._() {
    if (geometries == null) {
      throw new BuiltValueNullFieldError('GeometryCollection', 'geometries');
    }
  }

  @override
  GeoJsonType get type => __type ??= super.type;

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  GeometryCollection rebuild(void updates(GeometryCollectionBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$GeometryCollectionBuilder toBuilder() =>
      new _$GeometryCollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeometryCollection &&
        bbox == other.bbox &&
        geometries == other.geometries;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, bbox.hashCode), geometries.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GeometryCollection')
          ..add('bbox', bbox)
          ..add('geometries', geometries))
        .toString();
  }
}

class _$GeometryCollectionBuilder extends GeometryCollectionBuilder {
  _$GeometryCollection _$v;

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
  ListBuilder<Geometry> get geometries {
    _$this;
    return super.geometries ??= new ListBuilder<Geometry>();
  }

  @override
  set geometries(ListBuilder<Geometry> geometries) {
    _$this;
    super.geometries = geometries;
  }

  _$GeometryCollectionBuilder() : super._();

  GeometryCollectionBuilder get _$this {
    if (_$v != null) {
      super.bbox = _$v.bbox?.toBuilder();
      super.geometries = _$v.geometries?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeometryCollection other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GeometryCollection;
  }

  @override
  void update(void updates(GeometryCollectionBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$GeometryCollection build() {
    _$GeometryCollection _$result;
    try {
      _$result = _$v ??
          new _$GeometryCollection._(
              bbox: super.bbox?.build(), geometries: geometries.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bbox';
        super.bbox?.build();
        _$failedField = 'geometries';
        geometries.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GeometryCollection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
