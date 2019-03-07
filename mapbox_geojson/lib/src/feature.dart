library feature;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/serializers.dart';

part 'feature.g.dart';

abstract class Feature extends Object with GeoJson implements Built<Feature, FeatureBuilder> {
  factory Feature([void updates(FeatureBuilder b)]) = _$Feature;

  factory Feature.fromGeometry({
    Map<String, dynamic> properties,
    Geometry geometry,
    String id,
    BoundingBox bbox,
  }) {
    return Feature((FeatureBuilder b) {
      b
        ..bbox = bbox?.toBuilder()
        ..id = id
        ..geometry = geometry
        ..properties = MapBuilder(properties ?? {});
    });
  }

  factory Feature.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  Feature._();

  /// This describes the TYPE of GeoJson geometry this object is, thus this will always return [GeoJsonType.Feature]
  @override
  GeoJsonType get type => GeoJsonType.Feature;

  /// A Feature Collection might have a member named [bbox] to include information on the
  /// coordinate range for it's [Feature]s. The value of the bbox member MUST be a list of
  /// size 2*n where n is the number of dimensions represented in the contained feature geometries,
  /// with all axes of the most southwesterly point followed by all axes of the more northeasterly
  /// point. The axes order of a bbox follows the axes order of geometries.
  ///
  /// Return a list of double coordinate values describing a bounding box
  @nullable
  @override
  BoundingBox get bbox;

  /// A feature may have a commonly used identifier which is either a unique String or number.
  ///
  /// Return a String containing this features unique identification or null if one wasn't given
  /// during creation.
  @nullable
  String get id;

  /// The geometry which makes up this feature. A Geometry object represents points, curves, and
  /// surfaces in coordinate space. One of the seven geometries provided inside this library can be
  /// passed in through one of the static factory methods.
  ///
  /// Return a single defined [Geometry] which makes this feature spatially aware
  /// @since 1.0.0
  @nullable
  Geometry get geometry;

  /// This contains the JSON object which holds the feature properties. The value of the properties
  /// member is a Map and might be empty if no properties are provided.
  ///
  /// Return a Map which holds this features current properties
  BuiltMap<String, Object> get properties;

  @memoized
  @override
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<Feature> get serializer => _$featureSerializer;
}

abstract class FeatureBuilder implements Builder<Feature, FeatureBuilder> {
  BoundingBoxBuilder bbox;

  String id;

  Geometry geometry;

  MapBuilder<String, Object> properties;

  factory FeatureBuilder() = _$FeatureBuilder;

  FeatureBuilder._();
}
