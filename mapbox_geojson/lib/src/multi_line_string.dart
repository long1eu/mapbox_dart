library multi_line_string;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/line_string.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/serializers.dart';

part 'multi_line_string.g.dart';

abstract class MultiLineString
    implements Built<MultiLineString, MultiLineStringBuilder>, CoordinateContainer<BuiltList<BuiltList<Point>>> {
  factory MultiLineString([void updates(MultiLineStringBuilder b)]) = _$MultiLineString;

  /// Create a new instance of this class by defining a list of [LineString] objects and
  /// passing that list in as a parameter in this method. The [LineStrings] should comply with the
  /// GeoJson specifications described in the documentation. Optionally, pass in an instance of a
  /// [BoundingBox] which better describes this [MultiLineString].
  ///
  /// [lineStrings] a list of LineStrings which make up this MultiLineString
  /// [bbox]        optionally include a bbox definition
  /// Return a new instance of this class defined by the values passed inside this static factory
  /// method
  factory MultiLineString.fromLineStrings({List<LineString> lineStrings, LineString lineString, BoundingBox bbox}) {
    assert(lineStrings != null || lineString != null);

    return MultiLineString((MultiLineStringBuilder b) {
      b
        ..coordinates =
            ListBuilder<BuiltList<Point>>((lineStrings ?? [lineString]).map((it) => it.coordinates).toList())
        ..bbox = bbox?.toBuilder();
    });
  }

  factory MultiLineString.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  MultiLineString._();

  /// This describes the TYPE of GeoJson geometry this object is, thus this will always return
  /// [GeoJsonType.MultiLineString]
  @override
  @memoized
  GeoJsonType get type => GeoJsonType.MultiLineString;

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

  /// Provides the list of list of [Point]s that make up the [MultiLineString] geometry.
  BuiltList<BuiltList<Point>> get coordinates;

  /// Returns a list of [LineStrings] which are currently making up this [MultiLineString].
  List<LineString> lineStrings() {
    List<LineString> lineStrings = <LineString>[];
    for (BuiltList<Point> points in coordinates) {
      lineStrings.add(LineString.fromLngLats(points: points.toList()));
    }
    return lineStrings;
  }

  @memoized
  @override
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<MultiLineString> get serializer => _$multiLineStringSerializer;
}

abstract class MultiLineStringBuilder implements Builder<MultiLineString, MultiLineStringBuilder> {
  BoundingBoxBuilder bbox;

  ListBuilder<BuiltList<Point>> coordinates;

  factory MultiLineStringBuilder() = _$MultiLineStringBuilder;

  MultiLineStringBuilder._();
}
