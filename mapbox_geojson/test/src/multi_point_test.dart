import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

void main() {
  test('sanity', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final MultiPoint multiPoint = MultiPoint.fromLngLats(points);
    expect(multiPoint, isNotNull);
  });

  test('bbox_nullWhenNotSet', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final MultiPoint multiPoint = MultiPoint.fromLngLats(points);
    expect(multiPoint.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final MultiPoint multiPoint = MultiPoint.fromLngLats(points);
    expect(multiPoint.json,
        '{"type":"MultiPoint","coordinates":[[1.0,2.0],[2.0,3.0]]}');
  });

  test('bbox_returnsCorrectBbox', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final MultiPoint multiPoint = MultiPoint.fromLngLats(points, bbox);
    expect(multiPoint.bbox, isNotNull);
    expect(multiPoint.bbox.west, 1.0);
    expect(multiPoint.bbox.south, 2.0);
    expect(multiPoint.bbox.east, 3.0);
    expect(multiPoint.bbox.north, 4.0);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final MultiPoint multiPoint = MultiPoint.fromLngLats(points, bbox);
    expect(multiPoint.json,
        '{"type":"MultiPoint","bbox":[1.0,2.0,3.0,4.0],"coordinates":[[1.0,2.0],[2.0,3.0]]}');
  });

  test('fromJson', () {
    const String json =
        '{"type":"MultiPoint","coordinates":[[100.0,0.0],[101.0,1.0]]}';
    final MultiPoint geo = MultiPoint.fromJson(json);
    expect(geo.type, GeoJsonType.multiPoint);
    expect(geo.coordinates[0].longitude, 100.0);
    expect(geo.coordinates[0].latitude, 0.0);
    expect(geo.coordinates[1].longitude, 101.0);
    expect(geo.coordinates[1].latitude, 1.0);
    expect(geo.coordinates[0].hasAltitude, isFalse);
    expect(geo.coordinates[0].altitude, isNaN);
  });

  test('toJson', () {
    const String json =
        '{"type":"MultiPoint","coordinates":[[100.0,0.0],[101.0,1.0]]}';
    final MultiPoint geo = MultiPoint.fromJson(json);
    expect(geo.json, json);
  });

  test('fromJson_coordinatesPresent', () {
    expect(
      () {
        return MultiPoint.fromJson('{"type":"MultiPoint","coordinates":null}');
      },
      throwsArgumentError,
    );
  });
}
