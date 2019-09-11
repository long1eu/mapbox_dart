import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

void main() {
  test('sanity', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    points.add(Point.fromLngLat(1.0, 2.0));
    final LineString outer = LineString.fromLngLats(points);
    final List<Polygon> polygons = <Polygon>[];
    polygons.add(Polygon.fromOuterInner(outer));
    polygons.add(Polygon.fromOuterInner(outer));
    final MultiPolygon multiPolygon = MultiPolygon.fromPolygons(polygons);
    expect(multiPolygon, isNotNull);
  });

  test('bbox_nullWhenNotSet', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    points.add(Point.fromLngLat(1.0, 2.0));
    final LineString outer = LineString.fromLngLats(points);
    final List<Polygon> polygons = <Polygon>[];
    polygons.add(Polygon.fromOuterInner(outer));
    polygons.add(Polygon.fromOuterInner(outer));
    final MultiPolygon multiPolygon = MultiPolygon.fromPolygons(polygons);
    expect(multiPolygon.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    points.add(Point.fromLngLat(1.0, 2.0));
    final LineString outer = LineString.fromLngLats(points);
    final List<Polygon> polygons = <Polygon>[];
    polygons.add(Polygon.fromOuterInner(outer));
    polygons.add(Polygon.fromOuterInner(outer));
    final MultiPolygon multiPolygon = MultiPolygon.fromPolygons(polygons);
    expect(multiPolygon.json,
        '{"type":"MultiPolygon","coordinates":[[[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]]],[[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]]]]}');
  });

  test('bbox_returnsCorrectBbox', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    points.add(Point.fromLngLat(1.0, 2.0));
    final LineString outer = LineString.fromLngLats(points);

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final List<Polygon> polygons = <Polygon>[];
    polygons.add(Polygon.fromOuterInner(outer));
    polygons.add(Polygon.fromOuterInner(outer));
    final MultiPolygon multiPolygon = MultiPolygon.fromPolygons(polygons, bbox);
    expect(multiPolygon.bbox, isNotNull);
    expect(multiPolygon.bbox.west, 1.0);
    expect(multiPolygon.bbox.south, 2.0);
    expect(multiPolygon.bbox.east, 3.0);
    expect(multiPolygon.bbox.north, 4.0);
  });

  test('passingInSinglePolygon_doesHandleCorrectly', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    final List<List<Point>> pointsList = <List<Point>>[points];
    final Polygon geometry = Polygon.fromLngLats(pointsList);
    final MultiPolygon multiPolygon = MultiPolygon.fromPolygon(geometry);
    expect(multiPolygon, isNotNull);
    expect(multiPolygon.polygons.length, 1);
    expect(multiPolygon.polygons[0].coordinates[0][0].latitude, 2.0);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    points.add(Point.fromLngLat(1.0, 2.0));
    final LineString outer = LineString.fromLngLats(points);

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final List<Polygon> polygons = <Polygon>[];
    polygons.add(Polygon.fromOuterInner(outer));
    polygons.add(Polygon.fromOuterInner(outer));
    final MultiPolygon multiPolygon = MultiPolygon.fromPolygons(polygons, bbox);
    expect(multiPolygon.json,
        '{"type":"MultiPolygon","bbox":[1.0,2.0,3.0,4.0],"coordinates":[[[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]]],[[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]]]]}');
  });

  test('fromJson', () {
    const String json =
        '{"type":"MultiPolygon","coordinates":[[[[102.0,2.0],[103.0,2.0],[103.0,3.0],[102.0,3.0],[102.0,2.0]]],[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]],[[100.2,0.2],[100.2,0.8],[100.8,0.8],[100.8,0.2],[100.2,0.2]]]]}';

    final MultiPolygon geo = MultiPolygon.fromJson(json);
    print(geo.json);
    expect(geo.type, GeoJsonType.multiPolygon);
    expect(geo.coordinates[0][0][0].longitude, 102.0);
    expect(geo.coordinates[0][0][0].latitude, 2.0);
    expect(geo.coordinates[0][0][0].hasAltitude, isFalse);
  });

  test('toJson', () {
    const String json =
        '{"type":"MultiPolygon","coordinates":[[[[102.0,2.0],[103.0,2.0],[103.0,3.0],[102.0,3.0],[102.0,2.0]]],[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]],[[100.2,0.2],[100.2,0.8],[100.8,0.8],[100.8,0.2],[100.2,0.2]]]]}';

    final MultiPolygon geo = MultiPolygon.fromJson(json);
    expect(geo.json, json);
  });

  test('fromJson_coordinatesPresent', () {
    expect(
      () {
        return MultiPolygon.fromJson(
            '{"type":"MultiPolygon","coordinates":null}');
      },
      throwsArgumentError,
    );
  });
}
