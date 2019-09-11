import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

void main() {
  const int PRECISION_6 = 6;

  test('sanity', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 1.0));
    points.add(Point.fromLngLat(2.0, 2.0));
    points.add(Point.fromLngLat(3.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    expect(lineString, isNotNull);
  });

  test('fromLngLats_generatedFromMultipoint', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(4.0, 8.0));
    final MultiPoint multiPoint = MultiPoint.fromLngLats(points);
    final LineString lineString = LineString.fromMultipoint(multiPoint);
    expect('_gayB_c`|@_wemJ_kbvD', lineString.toPolyline(PRECISION_6));
  });

  test('bbox_nullWhenNotSet', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 1.0));
    points.add(Point.fromLngLat(2.0, 2.0));
    points.add(Point.fromLngLat(3.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    expect(lineString.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 1.0));
    points.add(Point.fromLngLat(2.0, 2.0));
    points.add(Point.fromLngLat(3.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    expect(lineString.json,
        '{"type":"LineString","coordinates":[[1.0,1.0],[2.0,2.0],[3.0,3.0]]}');
  });

  test('bbox_returnsCorrectBbox', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 1.0));
    points.add(Point.fromLngLat(2.0, 2.0));
    points.add(Point.fromLngLat(3.0, 3.0));
    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final LineString lineString = LineString.fromLngLats(points, bbox);
    expect(lineString.bbox, isNotNull);
    expect(1.0, lineString.bbox.west);
    expect(2.0, lineString.bbox.south);
    expect(3.0, lineString.bbox.east);
    expect(4.0, lineString.bbox.north);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 1.0));
    points.add(Point.fromLngLat(2.0, 2.0));
    points.add(Point.fromLngLat(3.0, 3.0));
    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final LineString lineString = LineString.fromLngLats(points, bbox);

    expect(lineString.json,
        '{"type":"LineString","bbox":[1.0,2.0,3.0,4.0],"coordinates":[[1.0,1.0],[2.0,2.0],[3.0,3.0]]}');
  });

  test('bbox_doesDeserializeWhenPresent', () {
    final LineString lineString = LineString.fromJson(
        '{"coordinates":[[1.0,2.0],[2.0,3.0],[3.0,4.0]],"type":"LineString","bbox":[1.0,2.0,3.0,4.0]}');

    expect(lineString, isNotNull);
    expect(lineString.bbox, isNotNull);
    expect(1.0, lineString.bbox.southwest.longitude);
    expect(2.0, lineString.bbox.southwest.latitude);
    expect(3.0, lineString.bbox.northeast.longitude);
    expect(4.0, lineString.bbox.northeast.latitude);
    expect(lineString.coordinates, isNotNull);
    expect(1, lineString.coordinates[0].longitude);
    expect(2, lineString.coordinates[0].latitude);
    expect(2, lineString.coordinates[1].longitude);
    expect(3, lineString.coordinates[1].latitude);
    expect(3, lineString.coordinates[2].longitude);
    expect(4, lineString.coordinates[2].latitude);
  });

  test('fromJson', () {
    const String json =
        '{"type":"LineString","coordinates":[[100.0,0.0],[101.0,1.0]]}';
    final LineString geo = LineString.fromJson(json);
    expect(geo.type, GeoJsonType.lineString);
    expect(geo.coordinates[0].longitude, 100.0);
    expect(geo.coordinates[0].latitude, 0.0);
    expect(geo.coordinates[0].hasAltitude, isFalse);
  });

  test('toJson', () {
    const String json =
        '{"type":"LineString","coordinates":[[100.0,0.0],[101.0,1.0]]}';
    final LineString geo = LineString.fromJson(json);
    expect(geo.json, json);
  });

  test('fromJson_coordinatesPresent', () {
    expect(
      () {
        return LineString.fromJson('{"type":"LineString","coordinates":null}');
      },
      throwsArgumentError,
    );
  });
}
