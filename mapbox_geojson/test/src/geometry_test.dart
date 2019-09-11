// File created by
// Lung Razvan <long1eu>
// on 11/09/2019

import 'dart:convert';

import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

// ignore_for_file: avoid_as
void main() {
  test('fromJson', () {
    const String json =
        '{"type":"GeometryCollection","bbox":[120.0,40.0,-120.0,-40.0],"geometries":[{"bbox":[110.0,30.0,-110.0,-30.0],"type":"Point","coordinates":[100.0,0.0]},{"type":"LineString","bbox":[110.0,30.0,-110.0,-30.0],"coordinates":[[101.0,0.0],[102.0,1.0]]}]}';
    final Geometry geo = Geometry.fromJson(jsonDecode(json));
    expect(geo.type, GeoJsonType.geometryCollection);
  });

  test('pointFromJson', () {
    final Geometry geometry = Geometry.fromJson(jsonDecode(
        '{\"coordinates\": [2,3],\"type\":\"Point\",\"bbox\":[1.0,2.0,3.0,4.0]}'));

    expect(geometry, isNotNull);
    expect(geometry.bbox, isNotNull);
    expect(geometry.bbox.southwest.longitude, 1.0);
    expect(geometry.bbox.southwest.latitude, 2.0);
    expect(geometry.bbox.northeast.longitude, 3.0);
    expect(geometry.bbox.northeast.latitude, 4.0);
    expect((geometry as Point).coordinates, isNotNull);
    expect((geometry as Point).longitude, 2);
    expect((geometry as Point).latitude, 3);
  });

  test('pointToJson', () {
    final Geometry geometry = Point.fromLngLat(2, 3,
        bbox: BoundingBox.fromLngLats(west: 1, south: 2, east: 3, north: 4));
    final String pointStr = geometry.json;
    expect(pointStr,
        '{"bbox":[1.0,2.0,3.0,4.0],"type":"Point","coordinates":[2.0,3.0]}');
  });

  test('lineStringFromJson', () {
    final Geometry lineString = Geometry.fromJson(jsonDecode(
        '{"type":"LineString","bbox":[1.0,2.0,3.0,4.0],"coordinates":[[1.0,2.0],[2.0,3.0],[3.0,4.0]]}'));

    expect(lineString, isNotNull);
    expect(lineString.bbox, isNotNull);
    expect(lineString.bbox.southwest.longitude, 1.0);
    expect(lineString.bbox.southwest.latitude, 2.0);
    expect(lineString.bbox.northeast.longitude, 3.0);
    expect(lineString.bbox.northeast.latitude, 4.0);
    expect((lineString as LineString).coordinates, isNotNull);
    expect((lineString as LineString).coordinates[0].longitude, 1);
    expect((lineString as LineString).coordinates[0].latitude, 2);
    expect((lineString as LineString).coordinates[1].longitude, 2);
    expect((lineString as LineString).coordinates[1].latitude, 3);
    expect((lineString as LineString).coordinates[2].longitude, 3);
    expect((lineString as LineString).coordinates[2].latitude, 4);
  });

  test('lineStringToJson', () {
    final Geometry geometry = LineString.fromLngLats(
      <Point>[
        Point.fromLngLat(1, 2),
        Point.fromLngLat(2, 3),
        Point.fromLngLat(3, 4),
      ],
      BoundingBox.fromLngLats(west: 1, south: 2, east: 3, north: 4),
    );

    const String expectedJsonString =
        '{"type":"LineString","bbox":[1.0,2.0,3.0,4.0],"coordinates":[[1.0,2.0],[2.0,3.0],[3.0,4.0]]}';
    expect(geometry.json, expectedJsonString);
  });
}
