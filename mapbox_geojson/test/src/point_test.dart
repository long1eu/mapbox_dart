import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

void main() {
  test('sanity', () {
    final Point point = Point.fromLngLat(1.0, 2.0);
    expect(point, isNotNull);
  });

  test('hasAltitude_returnsFalseWhenAltitudeNotPresent', () {
    final Point point = Point.fromLngLat(1.0, 2.0);
    expect(point.hasAltitude, isFalse);
  });

  test('hasAltitude_returnsTrueWhenAltitudeIsPresent', () {
    final Point point = Point.fromLngLat(1.0, 2.0, altitude: 5.0);
    expect(point.hasAltitude, isTrue);
  });

  test('altitude_doesReturnCorrectValueFromDoubleList', () {
    final List<double> coords = <double>[1.0, 2.0, 5.0];
    final Point point = Point.fromCoordinates(coords);
    expect(point.altitude, 5);
  });

  test('point_throwsWithWrongLengthDoubleList', () {
    final List<double> coords = <double>[1.0];
    expect(() => Point.fromCoordinates(coords), throwsA(isA<AssertionError>()));
  });

  test('longitude_doesReturnCorrectValue', () {
    final Point point = Point.fromLngLat(1.0, 2.0, altitude: 5.0);
    expect(point.longitude, 1);
  });

  test('latitude_doesReturnCorrectValue', () {
    final Point point = Point.fromLngLat(1.0, 2.0, altitude: 5.0);
    expect(point.latitude, 2);
  });

  test('bbox_nullWhenNotSet', () {
    final Point point = Point.fromLngLat(1.0, 2.0);
    expect(point.bbox, isNull);
  });

  test('bbox_doesSerializeWhenNotPresent', () {
    final Point point = Point.fromLngLat(1.0, 2.0);
    expect(point.json, '{"type":"Point","coordinates":[1.0,2.0]}');
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
    expect(lineString.bbox.west, 1.0);
    expect(lineString.bbox.south, 2.0);
    expect(lineString.bbox.east, 3.0);
    expect(lineString.bbox.north, 4.0);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, north: 3.0, east: 4.0);
    final Point point = Point.fromLngLat(2.0, 2.0, bbox: bbox);
    expect(point.json,
        '{"bbox":[1.0,2.0,4.0,3.0],"type":"Point","coordinates":[2.0,2.0]}');
  });

  test('bbox_doesDeserializeWhenPresent', () {
    final Point point = Point.fromJson(
        '{"bbox":[1.0,2.0,3.0,4.0],"type":"Point","coordinates":[2.0,3.0]}');
    expect(point, isNotNull);
    expect(point.bbox, isNotNull);
    expect(point.bbox.southwest.longitude, 1.0);
    expect(point.bbox.southwest.latitude, 2.0);
    expect(point.bbox.northeast.longitude, 3.0);
    expect(point.bbox.northeast.latitude, 4.0);
    expect(point.coordinates, isNotNull);
    expect(point.longitude, 2);
    expect(point.latitude, 3);
  });

  test('fromJson', () {
    const String json = '{"type":"Point","coordinates":[100.0,0.0]}';
    final Point geo = Point.fromJson(json);
    expect(geo.type, GeoJsonType.point);
    expect(geo.longitude, 100.0);
    expect(geo.latitude, 0.0);
    expect(geo.altitude, isNaN);
    expect(geo.coordinates[0], 100.0);
    expect(geo.coordinates[1], 0.0);
    expect(geo.coordinates.length, 2);
    expect(geo.hasAltitude, isFalse);
  });

  test('toJson', () {
    const String json = '{"type":"Point","coordinates":[100.0,0.0]}';
    final Point geo = Point.fromJson(json);
    expect(geo.json, json);
  });

  test('fromJson_coordinatesPresent', () {
    expect(() => Point.fromJson('{"type":"Point","coordinates":null}'),
        throwsArgumentError);
  });
}
