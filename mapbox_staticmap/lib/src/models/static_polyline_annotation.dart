library static_polyline_annotation;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/mapbox_geojson.dart' hide serializers;
import 'package:mapbox_staticmap/src/models/serializers.dart';

part 'static_polyline_annotation.g.dart';

/// Mapbox Static Image API polyline overlay. Building this object allows you to place a line or
/// object on top or within your static map image. The polyline must be encoded with a precision of 5
/// decimal places and can be created using the [PolylineUtils.encode].
abstract class StaticPolylineAnnotation implements Built<StaticPolylineAnnotation, StaticPolylineAnnotationBuilder> {
  factory StaticPolylineAnnotation([void updates(StaticPolylineAnnotationBuilder b)]) = _$StaticPolylineAnnotation;

  factory StaticPolylineAnnotation.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  StaticPolylineAnnotation._();

  ///  Defines the line stroke width for the path.
  double get strokeWidth;

  /// Set the line outer stroke color.
  ///
  /// [strokeColor] string representing hex color for the stroke color
  String get strokeColor;

  /// Value between 0, completely transparent, and 1, opaque for the line stroke.
  double get strokeOpacity;

  /// Set the inner line fill color.
  ///
  /// [color] string representing hex color for the fill color
  String get fillColor;

  /// Value between 0, completely transparent, and 1, opaque for the line fill.
  double get fillOpacity;

  /// The current polyline string being used for the paths geometry. You can use
  /// [PolylineUtils.decode] to decode the string using precision 5.
  ///
  /// [polyline] a string containing the paths geometry information
  String get polyline;

  String get url {
    StringBuffer sb = StringBuffer();

    sb.write('path');
    if (strokeWidth != null) {
      sb..write('-')..write(strokeWidth);
    }
    if (strokeColor != null) {
      sb..write('+')..write(strokeColor);
    }
    if (strokeOpacity != null) {
      sb..write('-')..write(strokeOpacity);
    }
    if (fillColor != null) {
      sb..write('+')..write(fillColor);
    }
    if (fillOpacity != null) {
      sb..write('-')..write(fillOpacity);
    }
    sb..write('(')..write(polyline)..write(')');
    return sb.toString();
  }

  @memoized
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<StaticPolylineAnnotation> get serializer => _$staticPolylineAnnotationSerializer;
}
