// GENERATED CODE - DO NOT MODIFY BY HAND

part of mapbox_staticmap;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MapboxStaticMap> _$mapboxStaticMapSerializer =
    new _$MapboxStaticMapSerializer();

class _$MapboxStaticMapSerializer
    implements StructuredSerializer<MapboxStaticMap> {
  @override
  final Iterable<Type> types = const [MapboxStaticMap, _$MapboxStaticMap];
  @override
  final String wireName = 'MapboxStaticMap';

  @override
  Iterable serialize(Serializers serializers, MapboxStaticMap object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'accessToken',
      serializers.serialize(object.accessToken,
          specifiedType: const FullType(String)),
      'baseUrl',
      serializers.serialize(object.baseUrl,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'styleId',
      serializers.serialize(object.styleId,
          specifiedType: const FullType(String)),
      'retina',
      serializers.serialize(object.retina, specifiedType: const FullType(bool)),
      'cameraPoint',
      serializers.serialize(object.cameraPoint,
          specifiedType: const FullType(Point)),
      'cameraZoom',
      serializers.serialize(object.cameraZoom,
          specifiedType: const FullType(double)),
      'cameraBearing',
      serializers.serialize(object.cameraBearing,
          specifiedType: const FullType(double)),
      'cameraPitch',
      serializers.serialize(object.cameraPitch,
          specifiedType: const FullType(double)),
      'cameraAuto',
      serializers.serialize(object.cameraAuto,
          specifiedType: const FullType(bool)),
      'width',
      serializers.serialize(object.width, specifiedType: const FullType(int)),
      'height',
      serializers.serialize(object.height, specifiedType: const FullType(int)),
      'precision',
      serializers.serialize(object.precision,
          specifiedType: const FullType(int)),
    ];
    if (object.logo != null) {
      result
        ..add('logo')
        ..add(serializers.serialize(object.logo,
            specifiedType: const FullType(bool)));
    }
    if (object.attribution != null) {
      result
        ..add('attribution')
        ..add(serializers.serialize(object.attribution,
            specifiedType: const FullType(bool)));
    }
    if (object.beforeLayer != null) {
      result
        ..add('beforeLayer')
        ..add(serializers.serialize(object.beforeLayer,
            specifiedType: const FullType(String)));
    }
    if (object.geoJson != null) {
      result
        ..add('geoJson')
        ..add(serializers.serialize(object.geoJson,
            specifiedType: const FullType(GeoJson)));
    }
    if (object.staticMarkerAnnotations != null) {
      result
        ..add('staticMarkerAnnotations')
        ..add(serializers.serialize(object.staticMarkerAnnotations,
            specifiedType: const FullType(
                BuiltList, const [const FullType(StaticMarkerAnnotation)])));
    }
    if (object.staticPolylineAnnotations != null) {
      result
        ..add('staticPolylineAnnotations')
        ..add(serializers.serialize(object.staticPolylineAnnotations,
            specifiedType: const FullType(
                BuiltList, const [const FullType(StaticPolylineAnnotation)])));
    }

    return result;
  }

  @override
  MapboxStaticMap deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MapboxStaticMapBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'accessToken':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'baseUrl':
          result.baseUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'styleId':
          result.styleId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'logo':
          result.logo = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'attribution':
          result.attribution = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'retina':
          result.retina = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'cameraPoint':
          result.cameraPoint.replace(serializers.deserialize(value,
              specifiedType: const FullType(Point)) as Point);
          break;
        case 'cameraZoom':
          result.cameraZoom = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cameraBearing':
          result.cameraBearing = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cameraPitch':
          result.cameraPitch = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cameraAuto':
          result.cameraAuto = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'beforeLayer':
          result.beforeLayer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'geoJson':
          result.geoJson = serializers.deserialize(value,
              specifiedType: const FullType(GeoJson)) as GeoJson;
          break;
        case 'staticMarkerAnnotations':
          result.staticMarkerAnnotations.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(StaticMarkerAnnotation)
              ])) as BuiltList);
          break;
        case 'staticPolylineAnnotations':
          result.staticPolylineAnnotations.replace(serializers.deserialize(
              value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(StaticPolylineAnnotation)
              ])) as BuiltList);
          break;
        case 'precision':
          result.precision = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$MapboxStaticMap extends MapboxStaticMap {
  @override
  final String accessToken;
  @override
  final String baseUrl;
  @override
  final String user;
  @override
  final String styleId;
  @override
  final bool logo;
  @override
  final bool attribution;
  @override
  final bool retina;
  @override
  final Point cameraPoint;
  @override
  final double cameraZoom;
  @override
  final double cameraBearing;
  @override
  final double cameraPitch;
  @override
  final bool cameraAuto;
  @override
  final String beforeLayer;
  @override
  final int width;
  @override
  final int height;
  @override
  final GeoJson geoJson;
  @override
  final BuiltList<StaticMarkerAnnotation> staticMarkerAnnotations;
  @override
  final BuiltList<StaticPolylineAnnotation> staticPolylineAnnotations;
  @override
  final int precision;
  Map<String, dynamic> __json;
  String ___generateLocationPathSegment;
  String ___generateSizePathSegment;

  factory _$MapboxStaticMap([void updates(MapboxStaticMapBuilder b)]) =>
      (new MapboxStaticMapBuilder()..update(updates)).build();

  _$MapboxStaticMap._(
      {this.accessToken,
      this.baseUrl,
      this.user,
      this.styleId,
      this.logo,
      this.attribution,
      this.retina,
      this.cameraPoint,
      this.cameraZoom,
      this.cameraBearing,
      this.cameraPitch,
      this.cameraAuto,
      this.beforeLayer,
      this.width,
      this.height,
      this.geoJson,
      this.staticMarkerAnnotations,
      this.staticPolylineAnnotations,
      this.precision})
      : super._() {
    if (accessToken == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'accessToken');
    }
    if (baseUrl == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'baseUrl');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'user');
    }
    if (styleId == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'styleId');
    }
    if (retina == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'retina');
    }
    if (cameraPoint == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'cameraPoint');
    }
    if (cameraZoom == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'cameraZoom');
    }
    if (cameraBearing == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'cameraBearing');
    }
    if (cameraPitch == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'cameraPitch');
    }
    if (cameraAuto == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'cameraAuto');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'width');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'height');
    }
    if (precision == null) {
      throw new BuiltValueNullFieldError('MapboxStaticMap', 'precision');
    }
  }

  @override
  Map<String, dynamic> get json => __json ??= super.json;

  @override
  String get _generateLocationPathSegment =>
      ___generateLocationPathSegment ??= super._generateLocationPathSegment;

  @override
  String get _generateSizePathSegment =>
      ___generateSizePathSegment ??= super._generateSizePathSegment;

  @override
  MapboxStaticMap rebuild(void updates(MapboxStaticMapBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MapboxStaticMapBuilder toBuilder() =>
      new MapboxStaticMapBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MapboxStaticMap &&
        accessToken == other.accessToken &&
        baseUrl == other.baseUrl &&
        user == other.user &&
        styleId == other.styleId &&
        logo == other.logo &&
        attribution == other.attribution &&
        retina == other.retina &&
        cameraPoint == other.cameraPoint &&
        cameraZoom == other.cameraZoom &&
        cameraBearing == other.cameraBearing &&
        cameraPitch == other.cameraPitch &&
        cameraAuto == other.cameraAuto &&
        beforeLayer == other.beforeLayer &&
        width == other.width &&
        height == other.height &&
        geoJson == other.geoJson &&
        staticMarkerAnnotations == other.staticMarkerAnnotations &&
        staticPolylineAnnotations == other.staticPolylineAnnotations &&
        precision == other.precision;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc(
                                                                                0,
                                                                                accessToken
                                                                                    .hashCode),
                                                                            baseUrl
                                                                                .hashCode),
                                                                        user
                                                                            .hashCode),
                                                                    styleId
                                                                        .hashCode),
                                                                logo.hashCode),
                                                            attribution
                                                                .hashCode),
                                                        retina.hashCode),
                                                    cameraPoint.hashCode),
                                                cameraZoom.hashCode),
                                            cameraBearing.hashCode),
                                        cameraPitch.hashCode),
                                    cameraAuto.hashCode),
                                beforeLayer.hashCode),
                            width.hashCode),
                        height.hashCode),
                    geoJson.hashCode),
                staticMarkerAnnotations.hashCode),
            staticPolylineAnnotations.hashCode),
        precision.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MapboxStaticMap')
          ..add('accessToken', accessToken)
          ..add('baseUrl', baseUrl)
          ..add('user', user)
          ..add('styleId', styleId)
          ..add('logo', logo)
          ..add('attribution', attribution)
          ..add('retina', retina)
          ..add('cameraPoint', cameraPoint)
          ..add('cameraZoom', cameraZoom)
          ..add('cameraBearing', cameraBearing)
          ..add('cameraPitch', cameraPitch)
          ..add('cameraAuto', cameraAuto)
          ..add('beforeLayer', beforeLayer)
          ..add('width', width)
          ..add('height', height)
          ..add('geoJson', geoJson)
          ..add('staticMarkerAnnotations', staticMarkerAnnotations)
          ..add('staticPolylineAnnotations', staticPolylineAnnotations)
          ..add('precision', precision))
        .toString();
  }
}

class MapboxStaticMapBuilder
    implements Builder<MapboxStaticMap, MapboxStaticMapBuilder> {
  _$MapboxStaticMap _$v;

  String _accessToken;
  String get accessToken => _$this._accessToken;
  set accessToken(String accessToken) => _$this._accessToken = accessToken;

  String _baseUrl;
  String get baseUrl => _$this._baseUrl;
  set baseUrl(String baseUrl) => _$this._baseUrl = baseUrl;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  String _styleId;
  String get styleId => _$this._styleId;
  set styleId(String styleId) => _$this._styleId = styleId;

  bool _logo;
  bool get logo => _$this._logo;
  set logo(bool logo) => _$this._logo = logo;

  bool _attribution;
  bool get attribution => _$this._attribution;
  set attribution(bool attribution) => _$this._attribution = attribution;

  bool _retina;
  bool get retina => _$this._retina;
  set retina(bool retina) => _$this._retina = retina;

  PointBuilder _cameraPoint;
  PointBuilder get cameraPoint => _$this._cameraPoint ??= new PointBuilder();
  set cameraPoint(PointBuilder cameraPoint) =>
      _$this._cameraPoint = cameraPoint;

  double _cameraZoom;
  double get cameraZoom => _$this._cameraZoom;
  set cameraZoom(double cameraZoom) => _$this._cameraZoom = cameraZoom;

  double _cameraBearing;
  double get cameraBearing => _$this._cameraBearing;
  set cameraBearing(double cameraBearing) =>
      _$this._cameraBearing = cameraBearing;

  double _cameraPitch;
  double get cameraPitch => _$this._cameraPitch;
  set cameraPitch(double cameraPitch) => _$this._cameraPitch = cameraPitch;

  bool _cameraAuto;
  bool get cameraAuto => _$this._cameraAuto;
  set cameraAuto(bool cameraAuto) => _$this._cameraAuto = cameraAuto;

  String _beforeLayer;
  String get beforeLayer => _$this._beforeLayer;
  set beforeLayer(String beforeLayer) => _$this._beforeLayer = beforeLayer;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  GeoJson _geoJson;
  GeoJson get geoJson => _$this._geoJson;
  set geoJson(GeoJson geoJson) => _$this._geoJson = geoJson;

  ListBuilder<StaticMarkerAnnotation> _staticMarkerAnnotations;
  ListBuilder<StaticMarkerAnnotation> get staticMarkerAnnotations =>
      _$this._staticMarkerAnnotations ??=
          new ListBuilder<StaticMarkerAnnotation>();
  set staticMarkerAnnotations(
          ListBuilder<StaticMarkerAnnotation> staticMarkerAnnotations) =>
      _$this._staticMarkerAnnotations = staticMarkerAnnotations;

  ListBuilder<StaticPolylineAnnotation> _staticPolylineAnnotations;
  ListBuilder<StaticPolylineAnnotation> get staticPolylineAnnotations =>
      _$this._staticPolylineAnnotations ??=
          new ListBuilder<StaticPolylineAnnotation>();
  set staticPolylineAnnotations(
          ListBuilder<StaticPolylineAnnotation> staticPolylineAnnotations) =>
      _$this._staticPolylineAnnotations = staticPolylineAnnotations;

  int _precision;
  int get precision => _$this._precision;
  set precision(int precision) => _$this._precision = precision;

  MapboxStaticMapBuilder();

  MapboxStaticMapBuilder get _$this {
    if (_$v != null) {
      _accessToken = _$v.accessToken;
      _baseUrl = _$v.baseUrl;
      _user = _$v.user;
      _styleId = _$v.styleId;
      _logo = _$v.logo;
      _attribution = _$v.attribution;
      _retina = _$v.retina;
      _cameraPoint = _$v.cameraPoint?.toBuilder();
      _cameraZoom = _$v.cameraZoom;
      _cameraBearing = _$v.cameraBearing;
      _cameraPitch = _$v.cameraPitch;
      _cameraAuto = _$v.cameraAuto;
      _beforeLayer = _$v.beforeLayer;
      _width = _$v.width;
      _height = _$v.height;
      _geoJson = _$v.geoJson;
      _staticMarkerAnnotations = _$v.staticMarkerAnnotations?.toBuilder();
      _staticPolylineAnnotations = _$v.staticPolylineAnnotations?.toBuilder();
      _precision = _$v.precision;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MapboxStaticMap other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MapboxStaticMap;
  }

  @override
  void update(void updates(MapboxStaticMapBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MapboxStaticMap build() {
    _$MapboxStaticMap _$result;
    try {
      _$result = _$v ??
          new _$MapboxStaticMap._(
              accessToken: accessToken,
              baseUrl: baseUrl,
              user: user,
              styleId: styleId,
              logo: logo,
              attribution: attribution,
              retina: retina,
              cameraPoint: cameraPoint.build(),
              cameraZoom: cameraZoom,
              cameraBearing: cameraBearing,
              cameraPitch: cameraPitch,
              cameraAuto: cameraAuto,
              beforeLayer: beforeLayer,
              width: width,
              height: height,
              geoJson: geoJson,
              staticMarkerAnnotations: _staticMarkerAnnotations?.build(),
              staticPolylineAnnotations: _staticPolylineAnnotations?.build(),
              precision: precision);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cameraPoint';
        cameraPoint.build();

        _$failedField = 'staticMarkerAnnotations';
        _staticMarkerAnnotations?.build();
        _$failedField = 'staticPolylineAnnotations';
        _staticPolylineAnnotations?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MapboxStaticMap', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
