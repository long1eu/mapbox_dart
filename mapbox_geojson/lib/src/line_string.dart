library line_string;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/serializers.dart';
import 'package:mapbox_geojson/src/utils/polyline_utils.dart';
import 'package:meta/meta.dart';

part 'line_string.g.dart';

/// A linestring represents two or more geographic points that share a relationship and is one of the
/// seven geometries found in the GeoJson spec.
/// <p>
/// This adheres to the RFC 7946 internet standard when serialized into JSON. When deserialized, this
/// class becomes an immutable object which should be initiated using its static factory methods.
/// </p><p>
/// The list of points must be equal to or greater than 2. A LineString has non-zero length and
/// zero area. It may approximate a curve and need not be straight. Unlike a LinearRing, a LineString
/// is not closed.
/// </p><p>
/// When representing a LineString that crosses the antimeridian, interoperability is improved by
/// modifying their geometry. Any geometry that crosses the antimeridian SHOULD be represented by
/// cutting it in two such that neither part's representation crosses the antimeridian.
/// </p><p>
/// For example, a line extending from 45 degrees N, 170 degrees E across the antimeridian to 45
/// degrees N, 170 degrees W should be cut in two and represented as a MultiLineString.
/// </p><p>
/// A sample GeoJson LineString's provided below (in it's serialized state).
/// ```json
/// {
///   "TYPE": "LineString",
///   "coordinates": [
///     [100.0, 0.0],
///     [101.0, 1.0]
///   ]
/// }
/// ```
/// Look over the [Point] documentation to get more
/// information about formatting your list of point objects correctly.
abstract class LineString implements Built<LineString, LineStringBuilder>, CoordinateContainer<BuiltList<Point>> {
  factory LineString([void updates(LineStringBuilder b)]) = _$LineString;

  /// Create a new instance of this class by defining a [LineString] object and passing. The
  /// multipoint object should comply with the GeoJson specifications described in the documentation.
  ///
  /// [multiPoint] which will make up the LineString geometry
  /// [bbox]       optionally include a bbox definition as a double array
  factory LineString.fromMultipoint({@required LineString multiPoint, BoundingBox bbox}) {
    return LineString.fromLngLats(points: multiPoint.coordinates.toList(), bbox: bbox);
  }

  /// Create a new instance of this class by defining a list of [Point]s which follow the
  /// correct specifications described in the Point documentation. Note that there should not be any
  /// duplicate points inside the list and the points combined should create a LineString with a
  /// distance greater than 0.
  /// <p>
  /// Note that if less than 2 points are passed in, a runtime exception will occur.
  /// </p>
  ///
  /// [points] a list of [Point]s which make up the [LineString] geometry
  /// [bbox] optionally include a bbox definition as a double array
  factory LineString.fromLngLats({@required List<Point> points, BoundingBox bbox}) {
    return LineString((LineStringBuilder b) {
      b
        ..coordinates = ListBuilder<Point>(points)
        ..bbox = bbox?.toBuilder();
    });
  }

  /// Create a new instance of this class by convert a polyline string into a lineString. This is
  /// handy when an API provides you with an encoded string representing the line geometry and you'd
  /// like to convert it to a useful [LineString] object. Note that the precision that the string
  /// geometry was encoded with needs to be known and passed into this method using the precision
  /// parameter.
  ///
  /// [polyline] encoded string geometry to decode into a new [LineString] instance
  /// [precision] The encoded precision which must match the same precision used when the string
  /// was first encoded
  factory LineString.fromPolyline(String polyline, int precision) {
    return LineString.fromLngLats(points: PolylineUtils.decode(polyline, precision));
  }

  factory LineString.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  LineString._();

  /// This describes the TYPE of GeoJson geometry this object is, thus this will always return [GeoJsonType.LineString]
  @memoized
  @override
  GeoJsonType get type => GeoJsonType.LineString;

  /// A Feature Collection might have a member named [bbox] to include information on the
  /// coordinate range for it's [Feature]s. The value of the bbox member MUST be a list of
  /// size 2*n where n is the number of dimensions represented in the contained feature geometries,
  /// with all axes of the most southwesterly point followed by all axes of the more northeasterly
  /// point. The axes order of a bbox follows the axes order of geometries.
  ///
  /// Return a list of double coordinate values describing a bounding box
  @override
  BoundingBox get bbox;

  /// Provides the list of [Point]s that make up the LineString geometry.
  @override
  BuiltList<Point> get coordinates;

  /// Encode this LineString into a Polyline string for easier serializing. When passing geometry
  /// information over a mobile network connection, encoding the geometry first will generally result
  /// in less bandwidth usage.
  ///
  /// [precision] the encoded precision which fits your best use-case
  /// Return a string describing the geometry of this LineString
  String toPolyline(int precision) => PolylineUtils.encode(coordinates.toList(), precision);

  @memoized
  @override
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<LineString> get serializer => _$lineStringSerializer;
}

abstract class LineStringBuilder implements Builder<LineString, LineStringBuilder> {
  BoundingBoxBuilder bbox;

  ListBuilder<Point> coordinates;

  factory LineStringBuilder() = _$LineStringBuilder;

  LineStringBuilder._();
}
