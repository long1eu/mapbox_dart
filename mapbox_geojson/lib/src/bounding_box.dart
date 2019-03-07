library bounding_box;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/serializers.dart';
import 'package:meta/meta.dart';

part 'bounding_box.g.dart';

/// A [GeoJson] object MAY have a member named "bbox" to include information on the coordinate range
/// for its [Geometry]ies, [Feature]s, or [FeatureCollection]s.
/// <p>
/// This class simplifies the build process for creating a bounding box and working with them when
/// deserialized. specific parameter naming helps define which coordinates belong where when a
/// bounding box instance is being created. Note that since [GeoJson] objects only have the option of
/// including a bounding box JSON element, the [bbox] value returned by a GeoJson object might
/// be null.
/// <p>
/// At a minimum, a bounding box will have two [Point]s or four coordinates which define the
/// box. A 3rd dimensional bounding box can be produced if elevation or altitude is defined.
abstract class BoundingBox implements Built<BoundingBox, BoundingBoxBuilder> {
  factory BoundingBox([void updates(BoundingBoxBuilder b)]) = _$BoundingBox;

  factory BoundingBox.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  /// Define a new instance of this class by passing in two [Point]s, representing both the
  /// southwest and northwest corners of the bounding box.
  ///
  /// [southwest] represents the bottom left corner of the bounding box when the camera is
  /// pointing due north
  /// [northeast] represents the top right corner of the bounding box when the camera is
  /// pointing due north
  factory BoundingBox.fromPoints({@required Point southwest, @required Point northeast}) {
    assert(southwest != null);
    assert(northeast != null);
    return BoundingBox((BoundingBoxBuilder b) {
      b
        ..southwest = southwest.toBuilder()
        ..northeast = northeast.toBuilder();
    });
  }

  /// Define a new instance of this class by passing in four coordinates in the same order they would
  /// appear in the serialized GeoJson form. Limits are placed on the minimum and maximum coordinate
  /// values which can exist and comply with the GeoJson spec.
  ///
  /// [west] the left side of the bounding box when the map is facing due north
  /// [south] the bottom side of the bounding box when the map is facing due north
  /// [east] the right side of the bounding box when the map is facing due north
  /// [north] the top side of the bounding box when the map is facing due north
  factory BoundingBox.fromLngLats({
    double west,
    double south,
    double east,
    double north,
  }) {
    return BoundingBox((BoundingBoxBuilder b) {
      b
        ..southwest = Point.fromLngLat(longitude: west, latitude: south).toBuilder()
        ..northeast = Point.fromLngLat(longitude: east, latitude: north).toBuilder();
    });
  }

  /// Define a new instance of this class by passing in four coordinates in the same order they would
  /// appear in the serialized GeoJson form. Limits are placed on the minimum and maximum coordinate
  /// values which can exist and comply with the GeoJson spec.
  ///
  /// [west] the left side of the bounding box when the map is facing due north
  /// [south] the bottom side of the bounding box when the map is facing due north
  /// [southwestAltitude] the southwest corner altitude or elevation when the map is facing due north
  /// [east] the right side of the bounding box when the map is facing due north
  /// [north] the top side of the bounding box when the map is facing due north
  /// [northEastAltitude] the northeast corner altitude or elevation when the map is facing due north
  factory BoundingBox.fromLngLatAlts({
    double west,
    double south,
    double southwestAltitude,
    double east,
    double north,
    double northEastAltitude,
  }) {
    return BoundingBox((BoundingBoxBuilder b) {
      b
        ..southwest = Point.fromLngLatAlt(longitude: west, latitude: south, altitude: southwestAltitude).toBuilder()
        ..northeast = Point.fromLngLatAlt(longitude: east, latitude: north, altitude: northEastAltitude).toBuilder();
    });
  }

  BoundingBox._();

  /// Provides the [Point] which represents the southwest corner of this bounding box when the
  /// map is facing due north.
  ///
  /// Return a [Point] which defines this bounding boxes southwest corner
  Point get southwest;

  /// Provides the [Point] which represents the northeast corner of this bounding box when the
  /// map is facing due north.
  ///
  /// Return a [Point] which defines this bounding boxes northeast corner
  Point get northeast;

  /// Convenience method for getting the bounding box most westerly point (longitude) as a double
  /// coordinate.
  ///
  /// Return the most westerly coordinate inside this bounding box
  @memoized
  double get west => southwest.longitude;

  /// Convenience method for getting the bounding box most southerly point (latitude) as a double
  /// coordinate.
  ///
  /// Return the most southerly coordinate inside this bounding box
  @memoized
  double get south => southwest.latitude;

  /// Convenience method for getting the bounding box most easterly point (longitude) as a double
  /// coordinate.
  ///
  /// Return the most easterly coordinate inside this bounding box
  @memoized
  double get east => northeast.longitude;

  /// Convenience method for getting the bounding box most westerly point (longitude) as a double
  /// coordinate.
  ///
  /// Return the most westerly coordinate inside this bounding box
  @memoized
  double get north => northeast.latitude;

  @memoized
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<BoundingBox> get serializer => _$boundingBoxSerializer;
}
