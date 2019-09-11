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
    final Polygon polygon = Polygon.fromOuterInner(outer);
    expect(polygon, isNotNull);
  });

  test('fromLngLats_tripleDoubleArray', () {
    final List<List<List<double>>> coordinates = <List<List<double>>>[
      <List<double>>[
        <double>[100.0, 0.0],
        <double>[101.0, 0.0],
        <double>[101.0, 1.0],
        <double>[100.0, 1.0],
        <double>[100.0, 0.0],
      ]
    ];
    final Polygon polygon = Polygon.fromCoordinates(coordinates);
    expect(polygon.inner, isEmpty);
    expect(polygon.coordinates[0][0], Point.fromLngLat(100.0, 0.0));
  });

  test('fromOuterInner_throwsNotLinearRingException', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(10.0, 2.0));
    points.add(Point.fromLngLat(5.0, 2.0));
    points.add(Point.fromLngLat(3.0, 2.0));
    final LineString lineString = LineString.fromLngLats(points);

    expect(
        () => Polygon.fromOuterInner(lineString),
        throwsA(GeoJsonError(
            'LinearRings need to be made up of 4 or more coordinates.')));
  });

  test('fromOuterInner_throwsNotConnectedLinearRingException', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(10.0, 2.0));
    points.add(Point.fromLngLat(5.0, 2.0));
    points.add(Point.fromLngLat(3.0, 2.0));
    points.add(Point.fromLngLat(5.0, 2.0));
    final LineString lineString = LineString.fromLngLats(points);

    expect(
        () => Polygon.fromOuterInner(lineString),
        throwsA(GeoJsonError(
            'LinearRings require first and last coordinate to be identical.')));
  });

  test('fromOuterInner_handlesSingleLineStringCorrectly', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(10.0, 2.0));
    points.add(Point.fromLngLat(5.0, 2.0));
    points.add(Point.fromLngLat(3.0, 2.0));
    points.add(Point.fromLngLat(10.0, 2.0));
    final LineString lineString = LineString.fromLngLats(points);

    final Polygon polygon = Polygon.fromOuterInner(lineString);
    expect(polygon.coordinates[0][0], Point.fromLngLat(10.0, 2.0));
  });

  test('fromOuterInner_handlesOuterAndInnerLineStringCorrectly', () {
    final List<Point> outer = <Point>[];
    outer.add(Point.fromLngLat(10.0, 2.0));
    outer.add(Point.fromLngLat(5.0, 2.0));
    outer.add(Point.fromLngLat(3.0, 2.0));
    outer.add(Point.fromLngLat(10.0, 2.0));
    final LineString outerLineString = LineString.fromLngLats(outer);

    final List<Point> inner = <Point>[];
    inner.add(Point.fromLngLat(5.0, 2.0));
    inner.add(Point.fromLngLat(2.5, 2.0));
    inner.add(Point.fromLngLat(1.5, 2.0));
    inner.add(Point.fromLngLat(5.0, 2.0));
    final LineString innerLineString = LineString.fromLngLats(inner);

    final Polygon polygon =
        Polygon.fromOuterInner(outerLineString, <LineString>[innerLineString]);
    expect(polygon.coordinates[0][0], Point.fromLngLat(10.0, 2.0));
    expect(polygon.outer, outerLineString);
    expect(polygon.inner.length, 1);
    expect(polygon.inner[0], innerLineString);
  });

  test('fromOuterInner_withABoundingBox', () {
    final List<Point> outer = <Point>[];
    outer.add(Point.fromLngLat(10.0, 2.0));
    outer.add(Point.fromLngLat(5.0, 2.0));
    outer.add(Point.fromLngLat(3.0, 2.0));
    outer.add(Point.fromLngLat(10.0, 2.0));
    final LineString outerLineString = LineString.fromLngLats(outer);

    final List<Point> inner = <Point>[];
    inner.add(Point.fromLngLat(5.0, 2.0));
    inner.add(Point.fromLngLat(2.5, 2.0));
    inner.add(Point.fromLngLat(1.5, 2.0));
    inner.add(Point.fromLngLat(5.0, 2.0));
    final LineString innerLineString = LineString.fromLngLats(inner);

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final Polygon polygon = Polygon.fromOuterInner(
        outerLineString, <LineString>[innerLineString], bbox);

    expect(polygon.bbox, bbox);
    expect(polygon.outer, outerLineString);
    expect(polygon.inner.length, 1);
    expect(polygon.inner[0], innerLineString);
  });

  test('bbox_nullWhenNotSet', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    points.add(Point.fromLngLat(1.0, 2.0));
    final LineString outer = LineString.fromLngLats(points);

    final List<LineString> inner = <LineString>[];
    inner.add(LineString.fromLngLats(points));
    inner.add(LineString.fromLngLats(points));
    final Polygon polygon = Polygon.fromOuterInner(outer, inner);
    expect(polygon.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    points.add(Point.fromLngLat(3.0, 4.0));
    points.add(Point.fromLngLat(1.0, 2.0));
    final LineString outer = LineString.fromLngLats(points);

    final List<LineString> inner = <LineString>[];
    inner.add(LineString.fromLngLats(points));
    inner.add(LineString.fromLngLats(points));
    final Polygon polygon = Polygon.fromOuterInner(outer, inner);
    expect(polygon.json,
        '{"type":"Polygon","coordinates":[[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]],[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]],[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]]]}');
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
    final List<LineString> inner = <LineString>[];
    inner.add(LineString.fromLngLats(points));
    inner.add(LineString.fromLngLats(points));
    final Polygon polygon = Polygon.fromOuterInner(outer, inner, bbox);
    expect(polygon.bbox, isNotNull);
    expect(polygon.bbox.west, 1.0);
    expect(polygon.bbox.south, 2.0);
    expect(polygon.bbox.east, 3.0);
    expect(polygon.bbox.north, 4.0);
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
    final List<LineString> inner = <LineString>[];
    inner.add(LineString.fromLngLats(points));
    inner.add(LineString.fromLngLats(points));
    final Polygon polygon = Polygon.fromOuterInner(outer, inner, bbox);
    expect(polygon.json,
        '{"type":"Polygon","bbox":[1.0,2.0,3.0,4.0],"coordinates":[[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]],[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]],[[1.0,2.0],[2.0,3.0],[3.0,4.0],[1.0,2.0]]]}');
  });

  test('fromJson', () {
    const String json =
        '{"type":"Polygon","coordinates":[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]]]}';
    final Polygon geo = Polygon.fromJson(json);
    expect(geo.type, GeoJsonType.polygon);
    expect(geo.coordinates[0][0].longitude, 100.0);
    expect(geo.coordinates[0][0].latitude, 0.0);
    expect(geo.coordinates[0][0].hasAltitude, isFalse);
  });

  test('fromJsonHoles', () {
    const String json =
        '{"type":"Polygon","coordinates":[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]],[[100.8,0.8],[100.8,0.2],[100.2,0.2],[100.2,0.8],[100.8,0.8]]]}';
    final Polygon geo = Polygon.fromJson(json);
    expect(geo.type, GeoJsonType.polygon);
    expect(geo.coordinates[0][0].longitude, 100.0);
    expect(geo.coordinates[0][0].latitude, 0.0);
    expect(geo.coordinates.length, 2);
    expect(geo.coordinates[1][0].longitude, 100.8);
    expect(geo.coordinates[1][0].latitude, 0.8);
    expect(geo.coordinates[0][0].hasAltitude, isFalse);
  });

  test('toJson', () {
    const String json =
        '{"type":"Polygon","coordinates":[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]]]}';
    final Polygon geo = Polygon.fromJson(json);
    expect(geo.json, json);
  });

  test('toJsonHoles', () {
    const String json =
        '{"type":"Polygon","coordinates":[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]],[[100.8,0.8],[100.8,0.2],[100.2,0.2],[100.2,0.8],[100.8,0.8]]]}';
    final Polygon geo = Polygon.fromJson(json);
    expect(geo.json, json);
  });

  test('fromJson_coordinatesPresent', () {
    expect(() => Polygon.fromJson('{"type":"Polygon","coordinates":null}'),
        throwsArgumentError);
  });
}
