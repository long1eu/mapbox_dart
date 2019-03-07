library mapbox_staticmap;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_core/mapbox_core.dart';
import 'package:mapbox_geojson/mapbox_geojson.dart' hide serializers;
import 'package:mapbox_staticmap/src/models/serializers.dart';
import 'package:mapbox_staticmap/src/models/static_map_style.dart';
import 'package:mapbox_staticmap/src/models/static_marker_annotation.dart';
import 'package:mapbox_staticmap/src/models/static_polyline_annotation.dart';
import 'package:meta/meta.dart';

part 'mapbox_staticmap.g.dart';

/// Static maps are standalone images that can be displayed in your mobile app without the aid of a
/// mapping library like the Mapbox Dart SDK. They look like an embedded map without interactivity
/// or controls. the returned image can be a raster tile ans pulls from any map style in the Mapbox
/// Style Specification.
/// <p>
/// This class helps make a valid request and gets the information correctly formatted for libraries which help download
/// the image and place it into an image.
///
/// @see <a href=https://www.mapbox.com/api-documentation/maps/#static>API Documentation</a>
abstract class MapboxStaticMap implements Built<MapboxStaticMap, MapboxStaticMapBuilder> {
  @protected
  factory MapboxStaticMap([void updates(MapboxStaticMapBuilder b)]) {
    return _$MapboxStaticMap((MapboxStaticMapBuilder b) {
      b
        ..baseUrl = Constants.baseApiUrl
        ..user = Constants.mapboxUser
        ..styleId = StaticMapStyle.street
        ..logo = true
        ..attribution = true
        ..retina = true
        ..cameraPoint = Point.fromLngLat(longitude: 0.0, latitude: 0.0).toBuilder()
        ..cameraZoom = 0.0
        ..cameraBearing = 0.0
        ..cameraPitch = 0.0
        ..cameraAuto = false
        ..width = 250
        ..height = 250
        ..precision = 0
        ..update(updates);
    });
  }

  factory MapboxStaticMap.fromValues({
    String accessToken,
    String baseUrl,
    String user,
    String styleId,
    bool logo,
    bool attribution,
    bool retina,
    Point cameraPoint,
    double cameraZoom,
    double cameraBearing,
    double cameraPitch,
    bool cameraAuto,
    String beforeLayer,
    int width,
    int height,
    GeoJson geoJson,
    List<StaticMarkerAnnotation> staticMarkerAnnotations,
    List<StaticPolylineAnnotation> staticPolylineAnnotations,
    int precision,
  }) {
    return MapboxStaticMap((b) {
      b
        ..accessToken = accessToken
        ..baseUrl = baseUrl ??= Constants.baseApiUrl
        ..user = user ?? Constants.mapboxUser
        ..styleId = styleId ?? StaticMapStyle.street
        ..logo = logo ?? true
        ..attribution = attribution ?? true
        ..retina = retina ?? true
        ..cameraPoint = cameraPoint?.toBuilder() ?? Point.fromLngLat(longitude: 0.0, latitude: 0.0).toBuilder()
        ..cameraZoom = cameraZoom ?? 0.0
        ..cameraBearing = cameraBearing ?? 0.0
        ..cameraPitch = cameraPitch ?? 0.0
        ..cameraAuto = cameraAuto ?? false
        ..beforeLayer = beforeLayer
        ..width = width ?? 250
        ..height = height ?? 250
        ..geoJson = geoJson
        ..staticMarkerAnnotations =
            staticMarkerAnnotations == null ? null : ListBuilder<StaticMarkerAnnotation>(staticMarkerAnnotations)
        ..staticPolylineAnnotations =
            staticPolylineAnnotations == null ? null : ListBuilder<StaticPolylineAnnotation>(staticPolylineAnnotations)
        ..precision = precision ?? 0;
    });
  }

  factory MapboxStaticMap.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  MapboxStaticMap._();

  static const String _beforeLayer = "before_layer";
  static const String _cameraAuto = "auto";

  /// Required to call when this is being built. If no access token provided, [ServicesException] will be thrown.
  ///
  /// You must have a Mapbox account inorder to use the Optimization API
  String get accessToken;

  /// Optionally change the APIs base URL to something other then the default Mapbox one.
  String get baseUrl;

  /// The username for the account that the directions engine runs on. In most cases, this should
  /// always remain the default value of [Constants.mapboxUser].
  ///
  /// [user] a non-null string which will replace the default user used in the directions request
  String get user;

  /// The returning map images style, which can be one of the provided Mapbox Styles or a custom
  /// style made inside Mapbox Studio. Passing null will revert to using the
  /// default map [StaticMapStyle.street]
  ///
  /// [styleId] either one of the styles defined inside [StaticMapStyle] or a custom url pointing
  /// to a styled map made in Mapbox Studio
  String get styleId;

  /// Optionally, control whether there is a Mapbox logo on the image.
  ///
  /// Default is true.
  /// Check that the current Mapbox plan you are under allows for hiding the Mapbox Logo from the mao.
  @nullable
  bool get logo;

  /// Optionally, control whether there is attribution on the image.
  ///
  /// Default is true.
  /// Check that the current Mapbox plan you are under allows for hiding the Mapbox Logo from the mao.
  @nullable
  bool get attribution;

  /// Enhance your image by toggling retina to true. This will double the amount of pixels the
  /// returning image will have.
  ///
  /// [retina] true if the desired image being returned should contain double pixels
  bool get retina;

  /// Center point where the camera will be focused on.
  ///
  /// [cameraPoint] a GeoJSON [Point] object which defines the cameras center position
  Point get cameraPoint;

  /// Static maps camera zoom level. This can be though of as how far away the camera is from the
  /// subject (earth) thus a zoom of 0 will display the entire world vs zoom 16 which is street\
  /// level zoom level. Fractional zoom levels will be rounded to two decimal places.
  ///
  /// [cameraZoom] double number between 0 and 22
  double get cameraZoom;

  /// Optionally, bearing rotates the map around its center defined point given in
  /// [cameraPoint]. A value of 90 rotates the map 90 to the left. 180 flips the map.
  /// Defaults is 0.
  ///
  /// [cameraBearing] double number between 0 and 360, interpreted as decimal degrees
  double get cameraBearing;

  /// Optionally, pitch tilts the map, producing a perspective effect.
  /// Defaults is 0.
  ///
  /// [cameraPitch ] double number between 0 and 60
  double get cameraPitch;

  /// If auto is set to true, the viewport will fit the bounds of the overlay. Using this will
  /// replace any latitude or longitude you provide.
  ///
  /// [auto] true if you'd like the viewport to be centered to display all map annotations,
  /// defaults false
  bool get cameraAuto;

  /// String value for controlling where the overlay is inserted in the style. All overlays will be
  /// inserted before this specified layer.
  ///
  /// [beforeLayer] s string representing the map layer you'd like to place your overlays
  /// below.
  @nullable
  String get beforeLayer;

  /// Width of the image.
  ///
  /// [width] int number between 1 and 1280.
  int get width;

  /// Height of the image.
  ///
  /// [height] int number between 1 and 1280.
  int get height;

  /// GeoJSON object which represents a specific annotation which will be placed on the static map.
  /// The GeoJSON must be value.
  ///
  /// [geoJson] a formatted string ready to be added to the static map image URL
  @nullable
  GeoJson get geoJson;

  /// Optionally provide a list of marker annotations which can be placed on the static map image
  /// during the rendering process.
  @nullable
  BuiltList<StaticMarkerAnnotation> get staticMarkerAnnotations;

  /// Optionally provide a list of polyline annotations which can be placed on the static map image
  /// during the rendering process.
  @nullable
  BuiltList<StaticPolylineAnnotation> get staticPolylineAnnotations;

  /// In order to make the returned image better cache-able on the client, you can set the
  /// precision in decimals instead of manually round the parameters.
  ///
  /// [precision] integer value greater than zero which represents the decimal precision
  /// of coordinate values
  int get precision;

  @memoized
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<MapboxStaticMap> get serializer => _$mapboxStaticMapSerializer;

  Uri get url {
    Uri uri = Uri.parse(baseUrl);
    uri = uri.replace(
        pathSegments: uri.pathSegments + ['styles', 'v1', user, styleId, 'static'],
        queryParameters: <String, String>{'access_token': accessToken});

    List<String> annotations = <String>[];
    if (staticMarkerAnnotations != null) {
      annotations.addAll(staticMarkerAnnotations.map((it) => it.url));
    }

    if (staticPolylineAnnotations != null) {
      annotations.addAll(staticPolylineAnnotations.map((it) => it.url));
    }

    if (geoJson != null) {
      annotations.add('geojson(${jsonEncode(geoJson.json)})');
    }

    if (annotations.isNotEmpty) {
      uri = uri.replace(pathSegments: uri.pathSegments + annotations);
    }

    uri = uri.replace(pathSegments: uri.pathSegments + [cameraAuto ? _cameraAuto : _generateLocationPathSegment]);

    if (beforeLayer != null) {
      uri = uri.replace(
          queryParameters: Map<String, String>.from(uri.queryParameters)..addAll({_beforeLayer: beforeLayer}));
    }
    if (!attribution) {
      uri =
          uri.replace(queryParameters: Map<String, String>.from(uri.queryParameters)..addAll({'attribution': 'false'}));
    }
    if (!logo) {
      uri = uri.replace(queryParameters: Map<String, String>.from(uri.queryParameters)..addAll({'logo': 'false'}));
    }

    // Has to be last segment in URL
    return uri.replace(pathSegments: uri.pathSegments + [_generateSizePathSegment]);
  }

  @memoized
  String get _generateLocationPathSegment {
    if (precision > 0) {
      List<String> geoInfo = <String>[];
      geoInfo.add(cameraPoint.longitude.toStringAsPrecision(precision));
      geoInfo.add(cameraPoint.latitude.toStringAsPrecision(precision));
      geoInfo.add(cameraZoom.toStringAsPrecision(precision));
      geoInfo.add(cameraBearing.toStringAsPrecision(precision));
      geoInfo.add(cameraPitch.toStringAsPrecision(precision));
      return geoInfo.join(',');
    } else {
      return '${cameraPoint.longitude},${cameraPoint.latitude},$cameraZoom,$cameraBearing,$cameraPitch';
    }
  }

  @memoized
  String get _generateSizePathSegment => '${width}x$height${retina ? '@2x' : ''}';
}
