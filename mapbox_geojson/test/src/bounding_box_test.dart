// File created by
// Lung Razvan <long1eu>
// on 11/09/2019

import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

void main() {
  test('sanity', () {
    final Point southwest = Point.fromLngLat(2.0, 2.0);
    final Point northeast = Point.fromLngLat(4.0, 4.0);
    final BoundingBox boundingBox =
        BoundingBox.fromPoints(southwest: southwest, northeast: northeast);
    expect(boundingBox, isNotNull);
  });

  test('southWest_doesReturnMostSouthwestCoordinate', () {
    final Point southwest = Point.fromLngLat(1.0, 2.0);
    final Point northeast = Point.fromLngLat(3.0, 4.0);
    final BoundingBox boundingBox =
        BoundingBox.fromPoints(southwest: southwest, northeast: northeast);
    expect(boundingBox.southwest, southwest);
  });

  test('northEast_doesReturnMostNortheastCoordinate', () {
    final Point southwest = Point.fromLngLat(1.0, 2.0);
    final Point northeast = Point.fromLngLat(3.0, 4.0);
    final BoundingBox boundingBox =
        BoundingBox.fromPoints(southwest: southwest, northeast: northeast);
    expect(boundingBox.northeast, northeast);
  });

  test('west_doesReturnMostWestCoordinate', () {
    final Point southwest = Point.fromLngLat(1.0, 2.0);
    final Point northeast = Point.fromLngLat(3.0, 4.0);
    final BoundingBox boundingBox =
        BoundingBox.fromPoints(southwest: southwest, northeast: northeast);
    expect(boundingBox.west, 1.0);
  });

  test('south_doesReturnMostSouthCoordinate', () {
    final Point southwest = Point.fromLngLat(1.0, 2.0);
    final Point northeast = Point.fromLngLat(3.0, 4.0);
    final BoundingBox boundingBox =
        BoundingBox.fromPoints(southwest: southwest, northeast: northeast);
    expect(boundingBox.south, 2.0);
  });

  test('east_doesReturnMostEastCoordinate', () {
    final Point southwest = Point.fromLngLat(1.0, 2.0);
    final Point northeast = Point.fromLngLat(3.0, 4.0);
    final BoundingBox boundingBox =
        BoundingBox.fromPoints(southwest: southwest, northeast: northeast);
    expect(boundingBox.east, 3.0);
  });

  test('north_doesReturnMostNorthCoordinate', () {
    final Point southwest = Point.fromLngLat(1.0, 2.0);
    final Point northeast = Point.fromLngLat(3.0, 4.0);
    final BoundingBox boundingBox =
        BoundingBox.fromPoints(southwest: southwest, northeast: northeast);
    expect(boundingBox.north, 4.0);
  });
}
