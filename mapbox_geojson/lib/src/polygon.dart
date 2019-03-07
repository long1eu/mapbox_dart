library polygon;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_exception.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/line_string.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/serializers.dart';
import 'package:meta/meta.dart';

part 'polygon.g.dart';

/// This class represents a GeoJson Polygon which may or may not include polygon holes.
/// <p>
/// To specify a constraint specific to Polygons, it is useful to introduce the concept of a linear
/// ring:
/// <ul>
/// <li>A linear ring is a closed LineString with four or more coordinates.</li>
/// <li>The first and last coordinates are equivalent, and they MUST contain identical values; their
/// representation SHOULD also be identical.</li>
/// <li>A linear ring is the boundary of a surface or the boundary of a hole in a surface.</li>
/// <li>A linear ring MUST follow the right-hand rule with respect to the area it bounds, i.e.,
/// exterior rings are counterclockwise, and holes are clockwise.</li>
/// </ul>
/// Note that most of the rules listed above are checked when a Polygon instance is created (the
/// exception being the last rule). If one of the rules is broken, a {@link RuntimeException} will
/// occur.
/// <p>
/// Though a linear ring is not explicitly represented as a GeoJson geometry TYPE, it leads to a
/// canonical formulation of the Polygon geometry TYPE. When initializing a new instance of this
/// class, a LineString for the outer and optionally an inner are checked to ensure a valid linear
/// ring.
/// <p>
/// An example of a serialized polygon with no holes is given below:
/// ```json
/// {
///   "TYPE": "Polygon",
///   "coordinates": [
///     [[100.0, 0.0],
///     [101.0, 0.0],
///     [101.0, 1.0],
///     [100.0, 1.0],
///     [100.0, 0.0]]
///   ]
/// }
/// ```
///
/// @since 1.0.0
abstract class Polygon implements Built<Polygon, PolygonBuilder>, CoordinateContainer<BuiltList<BuiltList<Point>>> {
  factory Polygon([void updates(PolygonBuilder b)]) = _$Polygon;

  /// Create a new instance of this class by defining a list of {@link Point}s which follow the
  /// correct specifications described in the Point documentation. Note that the first and last point
  /// in the list should be the same enclosing the linear ring.
  ///
  /// [coordinates] a list of a list of points which represent the polygon geometry
  /// [bbox] optionally include a bbox definition as a double array
  factory Polygon.fromLngLats({@required List<List<Point>> coordinates, BoundingBox bbox}) {
    return Polygon((PolygonBuilder b) {
      b
        ..coordinates = ListBuilder<BuiltList<Point>>(coordinates.map((it) => BuiltList<Point>(it)))
        ..bbox = bbox?.toBuilder();
    });
  }

  /// Create a new instance of this class by passing in an outer [LineString] and optionally
  /// one or more inner [LineStrings] contained within a list. Each of these [LineStrings] should follow
  /// the linear ring rules.
  /// <p>
  /// Note that if a [LineString] breaks one of the linear ring rules, a [GeoJsonException] will be thrown.
  ///
  /// [outer] a [LineString] which defines the outer perimeter of the polygon
  /// [inner] one or more [LineStrings] inside a list representing holes inside the outer
  /// [bbox] optionally include a bbox definition as a double array perimeter
  factory Polygon.fromOuterInner({@required LineString outer, List<LineString> inner, BoundingBox bbox}) {
    _isLinearRing(outer);
    List<BuiltList<Point>> coordinates = <BuiltList<Point>>[];
    coordinates.add(outer.coordinates);
    // If inner rings are set to null, return early.
    if (inner == null) {
      return Polygon((PolygonBuilder b) {
        b
          ..coordinates = ListBuilder<BuiltList<Point>>(coordinates)
          ..bbox = bbox?.toBuilder();
      });
    }
    for (LineString lineString in inner) {
      _isLinearRing(lineString);
      coordinates.add(lineString.coordinates);
    }
    return Polygon((PolygonBuilder b) {
      b
        ..coordinates = ListBuilder<BuiltList<Point>>(coordinates)
        ..bbox = bbox?.toBuilder();
    });
  }

  factory Polygon.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  Polygon._();

  /// This describes the TYPE of GeoJson geometry this object is, thus this will always return [GeoJsonType.Polygon]
  @override
  @memoized
  GeoJsonType get type => GeoJsonType.Polygon;

  /// A Feature Collection might have a member named [bbox] to include information on the
  /// coordinate range for it's [Feature]s. The value of the bbox member MUST be a list of
  /// size 2*n where n is the number of dimensions represented in the contained feature geometries,
  /// with all axes of the most southwesterly point followed by all axes of the more northeasterly
  /// point. The axes order of a bbox follows the axes order of geometries.
  ///
  /// Return a list of double coordinate values describing a bounding box
  @override
  @nullable
  BoundingBox get bbox;

  /// Provides the list of [Point]s that make up the [Polygon] geometry. The first list holds the
  /// different [LineStrings], first being the outer ring and the following entries being inner holes
  /// (if they exist).
  ///
  /// Return a list of points
  @override
  BuiltList<BuiltList<Point>> get coordinates;

  /// Convenience method to get the outer [LineString] which defines the outer perimeter of
  /// the polygon.
  ///
  /// Return a [LineString] defining the outer perimeter of this polygon
  LineString get outer => LineString.fromLngLats(points: coordinates[0].toList());

  /// Convenience method to get a list of inner [LineString]s defining holes inside the
  /// polygon. It is not guaranteed that this instance of [Polygon] contains holes and thus, might
  /// return a null or empty list.
  ///
  /// Return a List of [LineString]s defining holes inside the polygon
  List<LineString> get inner {
    if (coordinates.isEmpty) {
      return <LineString>[];
    }
    List<LineString> inner = <LineString>[];
    for (BuiltList<Point> points in coordinates.skip(1)) {
      inner.add(LineString.fromLngLats(points: points.toList()));
    }
    return inner;
  }

  @override
  @memoized
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<Polygon> get serializer => _$polygonSerializer;

  /// Checks to ensure that the [LineStrings] defining the polygon correctly and adhering to the linear
  /// ring rules.
  ///
  /// Return true if number of coordinates are 4 or more, and first and last coordinates are identical, else false
  /// Throws [GeoJsonException] if number of coordinates are less than 4, or first and last coordinates are not
  /// identical
  static bool _isLinearRing(LineString lineString) {
    if (lineString.coordinates.length < 4) {
      throw new GeoJsonException("LinearRings need to be made up of 4 or more coordinates.");
    }
    if ((lineString.coordinates[0] != lineString.coordinates[lineString.coordinates.length - 1])) {
      throw new GeoJsonException("LinearRings require first and last coordinate to be identical.");
    }
    return true;
  }
}

abstract class PolygonBuilder implements Builder<Polygon, PolygonBuilder> {
  BoundingBoxBuilder bbox;

  ListBuilder<BuiltList<Point>> coordinates;

  factory PolygonBuilder() = _$PolygonBuilder;

  PolygonBuilder._();
}
