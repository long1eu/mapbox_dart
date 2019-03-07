// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:mapbox_geojson/mapbox_geojson.dart' hide serializers;
import 'package:mapbox_geojson/mapbox_geojson.dart' as geojson show serializers;
import 'package:mapbox_staticmap/src/models/marker_scale.dart';
import 'package:mapbox_staticmap/src/models/static_map_style.dart';
import 'package:mapbox_staticmap/src/models/static_marker_annotation.dart';
import 'package:mapbox_staticmap/src/models/static_polyline_annotation.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  StaticMarkerAnnotation,
  BoundingBox,
  GeoJsonType,
  Point,
  StaticPolylineAnnotation,
])
final Serializers serializers = (_$serializers.toBuilder() //
      ..add(MarkerScale.serializer)
      ..add(StaticMapStyle.serializer)
      ..addAll(geojson.serializers.serializers)
      ..addPlugin(StandardJsonPlugin()) //
    )
    .build();
