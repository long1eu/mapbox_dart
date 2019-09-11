import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

void main() {
  test('sanity', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final List<LineString> lineStrings = <LineString>[];
    lineStrings.add(LineString.fromLngLats(points));
    lineStrings.add(LineString.fromLngLats(points));
    final MultiLineString multiLineString =
        MultiLineString.fromLineStrings(lineStrings);
    expect(multiLineString, isNotNull);
  });

  test('bbox_nullWhenNotSet', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final List<LineString> lineStrings = <LineString>[];
    lineStrings.add(LineString.fromLngLats(points));
    lineStrings.add(LineString.fromLngLats(points));
    final MultiLineString multiLineString =
        MultiLineString.fromLineStrings(lineStrings);
    expect(multiLineString.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final List<LineString> lineStrings = <LineString>[];
    lineStrings.add(LineString.fromLngLats(points));
    lineStrings.add(LineString.fromLngLats(points));
    final MultiLineString multiLineString =
        MultiLineString.fromLineStrings(lineStrings);
    expect(multiLineString.json,
        '{"type":"MultiLineString","coordinates":[[[1.0,2.0],[2.0,3.0]],[[1.0,2.0],[2.0,3.0]]]}');
  });

  test('bbox_returnsCorrectBbox', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final List<LineString> lineStrings = <LineString>[];
    lineStrings.add(LineString.fromLngLats(points));
    lineStrings.add(LineString.fromLngLats(points));
    final MultiLineString multiLineString =
        MultiLineString.fromLineStrings(lineStrings, bbox);
    expect(multiLineString.bbox, isNotNull);
    expect(multiLineString.bbox.west, 1.0);
    expect(multiLineString.bbox.south, 2.0);
    expect(multiLineString.bbox.east, 3.0);
    expect(multiLineString.bbox.north, 4.0);
  });

  test('passingInSingleLineString_doesHandleCorrectly', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    final LineString geometry = LineString.fromLngLats(points);
    final MultiLineString multiLineString =
        MultiLineString.fromLineString(geometry);
    expect(multiLineString, isNotNull);
    expect(multiLineString.lineStrings.length, 1);
    expect(multiLineString.lineStrings[0].coordinates[0].latitude, 2.0);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final List<LineString> lineStrings = <LineString>[];
    lineStrings.add(LineString.fromLngLats(points));
    lineStrings.add(LineString.fromLngLats(points));
    final MultiLineString multiLineString =
        MultiLineString.fromLineStrings(lineStrings, bbox);
    expect(multiLineString.json,
        '{"type":"MultiLineString","bbox":[1.0,2.0,3.0,4.0],"coordinates":[[[1.0,2.0],[2.0,3.0]],[[1.0,2.0],[2.0,3.0]]]}');
  });

  test('fromJson', () {
    const String json =
        '{"type":"MultiLineString","coordinates":[[[100.0,0.0],[101.0,1.0]],[[102.0,2.0],[103.0,3.0]]]}';

    final MultiLineString geo = MultiLineString.fromJson(json);
    expect(geo.type, GeoJsonType.multiLineString);
    expect(geo.coordinates[0][0].longitude, 100.0);
    expect(geo.coordinates[0][0].latitude, 0.0);
    expect(geo.coordinates[0][0].hasAltitude, isFalse);
  });

  test('toJson', () {
    const String json =
        '{"type":"MultiLineString","coordinates":[[[100.0,0.0],[101.0,1.0]],[[102.0,2.0],[103.0,3.0]]]}';
    final MultiLineString geo = MultiLineString.fromJson(json);
    expect(json, geo.json);
  });

  test('fromJson_coordinatesPresent', () {
    expect(
      () {
        return MultiLineString.fromJson(
            '{"type":"MultiLineString","coordinates":null}');
      },
      throwsArgumentError,
    );
  });
}
