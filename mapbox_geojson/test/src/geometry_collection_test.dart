import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

// ignore_for_file: avoid_as
void main() {
  test('sanity', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final List<Geometry> geometries = <Point>[];
    geometries.add(points[0]);
    geometries.add(lineString);

    final GeometryCollection geometryCollection =
        GeometryCollection.fromGeometries(geometries);
    expect(geometryCollection, isNotNull);
  });

  test('bbox_nullWhenNotSet', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final List<Geometry> geometries = <Point>[];
    geometries.add(points[0]);
    geometries.add(lineString);

    final GeometryCollection geometryCollection =
        GeometryCollection.fromGeometries(geometries);
    expect(geometryCollection.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final List<Geometry> geometries = <Point>[];
    geometries.add(points[0]);
    geometries.add(lineString);

    final GeometryCollection geometryCollection =
        GeometryCollection.fromGeometries(geometries);
    expect(geometryCollection.json,
        '{"type":"GeometryCollection","geometries":[{"type":"Point","coordinates":[1.0,2.0]},{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}]}');
  });

  test('bbox_returnsCorrectBbox', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final List<Geometry> geometries = <Point>[];
    geometries.add(points[0]);
    geometries.add(lineString);

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final GeometryCollection geometryCollection =
        GeometryCollection.fromGeometries(geometries, bbox);
    expect(geometryCollection.bbox, isNotNull);
    expect(geometryCollection.bbox.west, 1.0);
    expect(geometryCollection.bbox.south, 2.0);
    expect(geometryCollection.bbox.east, 3.0);
    expect(geometryCollection.bbox.north, 4.0);
  });

  test('passingInSingleGeometry_doesHandleCorrectly', () {
    final Point geometry = Point.fromLngLat(1.0, 2.0);
    final GeometryCollection collection =
        GeometryCollection.fromGeometry(geometry);
    expect(collection, isNotNull);
    expect(collection.geometries.length, 1);
    expect((collection.geometries[0] as Point).latitude, 2.0);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final List<Geometry> geometries = <Point>[];
    geometries.add(points[0]);
    geometries.add(lineString);

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final GeometryCollection geometryCollection =
        GeometryCollection.fromGeometries(geometries, bbox);
    expect(geometryCollection.json,
        '{"type":"GeometryCollection","bbox":[1.0,2.0,3.0,4.0],"geometries":[{"type":"Point","coordinates":[1.0,2.0]},{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}]}');
  });

  test('fromJson', () {
    const String json =
        '{"type":"GeometryCollection","bbox":[120.0,40.0,-120.0,-40.0],"geometries":[{"bbox":[110.0,30.0,-110.0,-30.0],"type":"Point","coordinates":[100.0,0.0]},{"type":"LineString","bbox":[110.0,30.0,-110.0,-30.0],"coordinates":[[101.0,0.0],[102.0,1.0]]}]}';
    final GeometryCollection geo = GeometryCollection.fromJson(json);
    expect(geo.type, GeoJsonType.geometryCollection);
    expect(geo.geometries[0].type, GeoJsonType.point);
    expect(geo.geometries[1].type, GeoJsonType.lineString);
  });

  test('toJson', () {
    const String jsonOriginal =
        '{"type":"GeometryCollection","bbox":[-120.0,-40.0,120.0,40.0],"geometries":[{"bbox":[-110.0,-30.0,110.0,30.0],"type":"Point","coordinates":[100.0,0.0]},{"type":"LineString","bbox":[-110.0,-30.0,110.0,30.0],"coordinates":[[101.0,0.0],[102.0,1.0]]}]}';

    final List<Geometry> geometries = <Geometry>[
      Point.fromLngLat(
        100,
        0,
        bbox: BoundingBox.fromLngLats(
            west: -110, south: -30, east: 110, north: 30),
      ),
      LineString.fromLngLats(
        <Point>[
          Point.fromLngLat(101, 0),
          Point.fromLngLat(102, 1),
        ],
        BoundingBox.fromLngLats(west: -110, south: -30, east: 110, north: 30),
      )
    ];

    final GeometryCollection geometryCollection =
        GeometryCollection.fromGeometries(
            geometries,
            BoundingBox.fromLngLats(
                west: -120, south: -40, east: 120, north: 40));

    expect(geometryCollection.json, jsonOriginal);
  });
}
