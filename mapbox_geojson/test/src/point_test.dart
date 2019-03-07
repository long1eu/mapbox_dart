import 'dart:convert';

import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:test/test.dart';

void main() {
  test('fromJson', () {
    final String json = "{ \"type\": \"Point\", \"coordinates\": [ 100, 0] }";
    Point geo = Point.fromJson(jsonDecode(json));

    expect(geo.type, GeoJsonType.Point);
    expect(geo.longitude, 100.0);
    expect(geo.latitude, 0.0);
    expect(geo.altitude, isNaN);
    expect(geo.coordinates[0], 100.0);
    expect(geo.coordinates[1], 0.0);
    expect(geo.coordinates.length, 2);
    expect(geo.hasAltitude, isFalse);
  });
}
