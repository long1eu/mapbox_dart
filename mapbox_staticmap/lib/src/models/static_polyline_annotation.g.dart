// GENERATED CODE - DO NOT MODIFY BY HAND

part of static_polyline_annotation;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<StaticPolylineAnnotation> _$staticPolylineAnnotationSerializer =
    new _$StaticPolylineAnnotationSerializer();

class _$StaticPolylineAnnotationSerializer
    implements StructuredSerializer<StaticPolylineAnnotation> {
  @override
  final Iterable<Type> types = const [
    StaticPolylineAnnotation,
    _$StaticPolylineAnnotation
  ];
  @override
  final String wireName = 'StaticPolylineAnnotation';

  @override
  Iterable serialize(Serializers serializers, StaticPolylineAnnotation object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'strokeWidth',
      serializers.serialize(object.strokeWidth,
          specifiedType: const FullType(double)),
      'strokeColor',
      serializers.serialize(object.strokeColor,
          specifiedType: const FullType(String)),
      'strokeOpacity',
      serializers.serialize(object.strokeOpacity,
          specifiedType: const FullType(double)),
      'fillColor',
      serializers.serialize(object.fillColor,
          specifiedType: const FullType(String)),
      'fillOpacity',
      serializers.serialize(object.fillOpacity,
          specifiedType: const FullType(double)),
      'polyline',
      serializers.serialize(object.polyline,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  StaticPolylineAnnotation deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticPolylineAnnotationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'strokeWidth':
          result.strokeWidth = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'strokeColor':
          result.strokeColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'strokeOpacity':
          result.strokeOpacity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'fillColor':
          result.fillColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fillOpacity':
          result.fillOpacity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'polyline':
          result.polyline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$StaticPolylineAnnotation extends StaticPolylineAnnotation {
  @override
  final double strokeWidth;
  @override
  final String strokeColor;
  @override
  final double strokeOpacity;
  @override
  final String fillColor;
  @override
  final double fillOpacity;
  @override
  final String polyline;
  Map<String, dynamic> __json;

  factory _$StaticPolylineAnnotation(
          [void updates(StaticPolylineAnnotationBuilder b)]) =>
      (new StaticPolylineAnnotationBuilder()..update(updates)).build();

  _$StaticPolylineAnnotation._(
      {this.strokeWidth,
      this.strokeColor,
      this.strokeOpacity,
      this.fillColor,
      this.fillOpacity,
      this.polyline})
      : super._() {
    if (strokeWidth == null) {
      throw new BuiltValueNullFieldError(
          'StaticPolylineAnnotation', 'strokeWidth');
    }
    if (strokeColor == null) {
      throw new BuiltValueNullFieldError(
          'StaticPolylineAnnotation', 'strokeColor');
    }
    if (strokeOpacity == null) {
      throw new BuiltValueNullFieldError(
          'StaticPolylineAnnotation', 'strokeOpacity');
    }
    if (fillColor == null) {
      throw new BuiltValueNullFieldError(
          'StaticPolylineAnnotation', 'fillColor');
    }
    if (fillOpacity == null) {
      throw new BuiltValueNullFieldError(
          'StaticPolylineAnnotation', 'fillOpacity');
    }
    if (polyline == null) {
      throw new BuiltValueNullFieldError(
          'StaticPolylineAnnotation', 'polyline');
    }
  }

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  StaticPolylineAnnotation rebuild(
          void updates(StaticPolylineAnnotationBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticPolylineAnnotationBuilder toBuilder() =>
      new StaticPolylineAnnotationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticPolylineAnnotation &&
        strokeWidth == other.strokeWidth &&
        strokeColor == other.strokeColor &&
        strokeOpacity == other.strokeOpacity &&
        fillColor == other.fillColor &&
        fillOpacity == other.fillOpacity &&
        polyline == other.polyline;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, strokeWidth.hashCode), strokeColor.hashCode),
                    strokeOpacity.hashCode),
                fillColor.hashCode),
            fillOpacity.hashCode),
        polyline.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticPolylineAnnotation')
          ..add('strokeWidth', strokeWidth)
          ..add('strokeColor', strokeColor)
          ..add('strokeOpacity', strokeOpacity)
          ..add('fillColor', fillColor)
          ..add('fillOpacity', fillOpacity)
          ..add('polyline', polyline))
        .toString();
  }
}

class StaticPolylineAnnotationBuilder
    implements
        Builder<StaticPolylineAnnotation, StaticPolylineAnnotationBuilder> {
  _$StaticPolylineAnnotation _$v;

  double _strokeWidth;
  double get strokeWidth => _$this._strokeWidth;
  set strokeWidth(double strokeWidth) => _$this._strokeWidth = strokeWidth;

  String _strokeColor;
  String get strokeColor => _$this._strokeColor;
  set strokeColor(String strokeColor) => _$this._strokeColor = strokeColor;

  double _strokeOpacity;
  double get strokeOpacity => _$this._strokeOpacity;
  set strokeOpacity(double strokeOpacity) =>
      _$this._strokeOpacity = strokeOpacity;

  String _fillColor;
  String get fillColor => _$this._fillColor;
  set fillColor(String fillColor) => _$this._fillColor = fillColor;

  double _fillOpacity;
  double get fillOpacity => _$this._fillOpacity;
  set fillOpacity(double fillOpacity) => _$this._fillOpacity = fillOpacity;

  String _polyline;
  String get polyline => _$this._polyline;
  set polyline(String polyline) => _$this._polyline = polyline;

  StaticPolylineAnnotationBuilder();

  StaticPolylineAnnotationBuilder get _$this {
    if (_$v != null) {
      _strokeWidth = _$v.strokeWidth;
      _strokeColor = _$v.strokeColor;
      _strokeOpacity = _$v.strokeOpacity;
      _fillColor = _$v.fillColor;
      _fillOpacity = _$v.fillOpacity;
      _polyline = _$v.polyline;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticPolylineAnnotation other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StaticPolylineAnnotation;
  }

  @override
  void update(void updates(StaticPolylineAnnotationBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticPolylineAnnotation build() {
    final _$result = _$v ??
        new _$StaticPolylineAnnotation._(
            strokeWidth: strokeWidth,
            strokeColor: strokeColor,
            strokeOpacity: strokeOpacity,
            fillColor: fillColor,
            fillOpacity: fillOpacity,
            polyline: polyline);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
