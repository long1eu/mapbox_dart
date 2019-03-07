// GENERATED CODE - DO NOT MODIFY BY HAND

part of static_marker_annotation;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<StaticMarkerAnnotation> _$staticMarkerAnnotationSerializer =
    new _$StaticMarkerAnnotationSerializer();

class _$StaticMarkerAnnotationSerializer
    implements StructuredSerializer<StaticMarkerAnnotation> {
  @override
  final Iterable<Type> types = const [
    StaticMarkerAnnotation,
    _$StaticMarkerAnnotation
  ];
  @override
  final String wireName = 'StaticMarkerAnnotation';

  @override
  Iterable serialize(Serializers serializers, StaticMarkerAnnotation object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'scale',
      serializers.serialize(object.scale,
          specifiedType: const FullType(MarkerScale)),
      'lnglat',
      serializers.serialize(object.lnglat,
          specifiedType: const FullType(Point)),
    ];
    if (object.label != null) {
      result
        ..add('label')
        ..add(serializers.serialize(object.label,
            specifiedType: const FullType(String)));
    }
    if (object.color != null) {
      result
        ..add('color')
        ..add(serializers.serialize(object.color,
            specifiedType: const FullType(String)));
    }
    if (object.iconUrl != null) {
      result
        ..add('iconUrl')
        ..add(serializers.serialize(object.iconUrl,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  StaticMarkerAnnotation deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticMarkerAnnotationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'scale':
          result.scale = serializers.deserialize(value,
              specifiedType: const FullType(MarkerScale)) as MarkerScale;
          break;
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lnglat':
          result.lnglat.replace(serializers.deserialize(value,
              specifiedType: const FullType(Point)) as Point);
          break;
        case 'iconUrl':
          result.iconUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$StaticMarkerAnnotation extends StaticMarkerAnnotation {
  @override
  final MarkerScale scale;
  @override
  final String label;
  @override
  final String color;
  @override
  final Point lnglat;
  @override
  final String iconUrl;
  Map<String, dynamic> __json;

  factory _$StaticMarkerAnnotation(
          [void updates(StaticMarkerAnnotationBuilder b)]) =>
      (new StaticMarkerAnnotationBuilder()..update(updates)).build();

  _$StaticMarkerAnnotation._(
      {this.scale, this.label, this.color, this.lnglat, this.iconUrl})
      : super._() {
    if (scale == null) {
      throw new BuiltValueNullFieldError('StaticMarkerAnnotation', 'scale');
    }
    if (lnglat == null) {
      throw new BuiltValueNullFieldError('StaticMarkerAnnotation', 'lnglat');
    }
  }

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  StaticMarkerAnnotation rebuild(
          void updates(StaticMarkerAnnotationBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticMarkerAnnotationBuilder toBuilder() =>
      new StaticMarkerAnnotationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticMarkerAnnotation &&
        scale == other.scale &&
        label == other.label &&
        color == other.color &&
        lnglat == other.lnglat &&
        iconUrl == other.iconUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, scale.hashCode), label.hashCode), color.hashCode),
            lnglat.hashCode),
        iconUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticMarkerAnnotation')
          ..add('scale', scale)
          ..add('label', label)
          ..add('color', color)
          ..add('lnglat', lnglat)
          ..add('iconUrl', iconUrl))
        .toString();
  }
}

class StaticMarkerAnnotationBuilder
    implements Builder<StaticMarkerAnnotation, StaticMarkerAnnotationBuilder> {
  _$StaticMarkerAnnotation _$v;

  MarkerScale _scale;
  MarkerScale get scale => _$this._scale;
  set scale(MarkerScale scale) => _$this._scale = scale;

  String _label;
  String get label => _$this._label;
  set label(String label) => _$this._label = label;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  PointBuilder _lnglat;
  PointBuilder get lnglat => _$this._lnglat ??= new PointBuilder();
  set lnglat(PointBuilder lnglat) => _$this._lnglat = lnglat;

  String _iconUrl;
  String get iconUrl => _$this._iconUrl;
  set iconUrl(String iconUrl) => _$this._iconUrl = iconUrl;

  StaticMarkerAnnotationBuilder();

  StaticMarkerAnnotationBuilder get _$this {
    if (_$v != null) {
      _scale = _$v.scale;
      _label = _$v.label;
      _color = _$v.color;
      _lnglat = _$v.lnglat?.toBuilder();
      _iconUrl = _$v.iconUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticMarkerAnnotation other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StaticMarkerAnnotation;
  }

  @override
  void update(void updates(StaticMarkerAnnotationBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticMarkerAnnotation build() {
    _$StaticMarkerAnnotation _$result;
    try {
      _$result = _$v ??
          new _$StaticMarkerAnnotation._(
              scale: scale,
              label: label,
              color: color,
              lnglat: lnglat.build(),
              iconUrl: iconUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'lnglat';
        lnglat.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StaticMarkerAnnotation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
