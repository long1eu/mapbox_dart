library static_marker_annotation;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/mapbox_geojson.dart' hide serializers;
import 'package:mapbox_staticmap/src/models/marker_scale.dart';
import 'package:mapbox_staticmap/src/models/serializers.dart';
import 'package:meta/meta.dart';

part 'static_marker_annotation.g.dart';

/// Mapbox Static Image API marker overlay. Building this object allows you to place a marker on top
/// or within your static image. The marker can either use the default marker (though you can change
/// it's color and size) or you have the option to also pass in a custom marker icon using it's url.
abstract class StaticMarkerAnnotation implements Built<StaticMarkerAnnotation, StaticMarkerAnnotationBuilder> {
  @protected
  factory StaticMarkerAnnotation([void updates(StaticMarkerAnnotationBuilder b)]) = _$StaticMarkerAnnotation;

  factory StaticMarkerAnnotation.fromValues({
    @required MarkerScale scale,
    String label,
    String color,
    @required Point lnglat,
    String iconUrl,
  }) {
    assert(scale != null);
    assert(lnglat != null);
    return StaticMarkerAnnotation((b) {
      b
        ..scale = scale
        ..label = label
        ..color = color
        ..lnglat = lnglat.toBuilder()
        ..iconUrl = iconUrl;
    });
  }

  factory StaticMarkerAnnotation.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  StaticMarkerAnnotation._();

  /// Modify the markers scale factor using one of the pre defined
  /// [MarkerScale.small], [MarkerScale.medium], or [MarkerScale.large].
  MarkerScale get scale;

  /// Marker symbol. Options are an alphanumeric label "a" through "z", "0" through  "99", or a
  /// valid Maki icon. If a letter is requested, it will be rendered uppercase only.
  @nullable
  String get label;

  /// A hex representation of the markers color.
  @nullable
  String get color;

  /// Represents where the marker should be shown on the map.
  ///
  /// GeoJSON Point which denotes where the marker will be placed on the static map image.
  /// Altitude value, if given, will be ignored
  Point get lnglat;

  /// A percent-encoded URL for the marker image. Can be of type PNG or JPG.
  @nullable
  String get iconUrl;

  String get url {
    String url;
    if (iconUrl != null) {
      return 'url-$iconUrl(${lnglat.longitude},${lnglat.latitude})';
    }

    if (color != null && label.isNotEmpty) {
      url = '$scale-$label+$color';
    } else if (label?.isNotEmpty ?? false) {
      url = '$scale-$label';
    } else if (color != null) {
      url = '$scale+$color';
    } else {
      url = scale.toString();
    }

    return '$url(${lnglat.longitude},${lnglat.latitude})';
  }

  @memoized
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<StaticMarkerAnnotation> get serializer => _$staticMarkerAnnotationSerializer;
}
