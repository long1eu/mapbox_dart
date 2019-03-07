library multi_polygon;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/polygon.dart';
import 'package:mapbox_geojson/src/serializers.dart';
import 'package:meta/meta.dart';

part 'multi_polygon.g.dart';

abstract class MultiPolygon
    implements Built<MultiPolygon, MultiPolygonBuilder>, CoordinateContainer<BuiltList<BuiltList<BuiltList<Point>>>> {
  factory MultiPolygon([void updates(MultiPolygonBuilder b)]) = _$MultiPolygon;

  factory MultiPolygon.fromPolygons({@required List<Polygon> polygons, BoundingBox bbox}) {
    List<BuiltList<BuiltList<Point>>> coordinates = <BuiltList<BuiltList<Point>>>[];
    for (Polygon polygon in polygons) {
      coordinates.add(polygon.coordinates);
    }

    return MultiPolygon((MultiPolygonBuilder b) {
      b
        ..coordinates = ListBuilder<BuiltList<BuiltList<Point>>>(coordinates)
        ..bbox = bbox?.toBuilder();
    });
  }

  factory MultiPolygon.fromPolygon({@required Polygon polygon, BoundingBox bbox}) {
    return MultiPolygon.fromPolygons(polygons: [polygon], bbox: bbox);
  }

  factory MultiPolygon.fromLngLats({@required List<List<List<Point>>> points, BoundingBox bbox}) {
    return MultiPolygon((MultiPolygonBuilder b) {
      b
        ..coordinates = ListBuilder<BuiltList<BuiltList<Point>>>(points.map(
            (List<List<Point>> it) => BuiltList<BuiltList<Point>>(it.map((List<Point> it) => BuiltList<Point>(it)))))
        ..bbox = bbox?.toBuilder();
    });
  }

  factory MultiPolygon.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  MultiPolygon._();

  /// This describes the TYPE of GeoJson geometry this object is, thus this will always return
  /// [GeoJsonType.MultiPolygon]
  @override
  GeoJsonType get type => GeoJsonType.MultiPolygon;

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

  /// Provides the list of list of list of [Point]s that make up the [MultiPolygon] geometry.
  @override
  BuiltList<BuiltList<BuiltList<Point>>> get coordinates;

  /// Returns a list of polygons which make up this [MultiPolygon] instance.
  @memoized
  List<Polygon> get polygons {
    List<Polygon> polygons = <Polygon>[];
    for (BuiltList<BuiltList<Point>> points in coordinates) {
      polygons.add(Polygon.fromLngLats(coordinates: points.map((it) => it.toList()).toList()));
    }
    return polygons;
  }

  @override
  @memoized
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<MultiPolygon> get serializer => _$multiPolygonSerializer;
}

abstract class MultiPolygonBuilder implements Builder<MultiPolygon, MultiPolygonBuilder> {
  BoundingBoxBuilder bbox;

  ListBuilder<BuiltList<BuiltList<Point>>> coordinates;

  factory MultiPolygonBuilder() = _$MultiPolygonBuilder;

  MultiPolygonBuilder._();
}
