import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

// ignore_for_file: avoid_as
void main() {
  test('sanity', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final Feature feature = Feature.fromGeometry(lineString);
    expect(feature, isNotNull);
  });

  test('bbox_nullWhenNotSet', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final Feature feature = Feature.fromGeometry(lineString);
    expect(feature.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final Feature feature = Feature.fromGeometry(lineString);

    final String featureJsonString = feature.json;
    expect(featureJsonString,
        '{"type":"Feature","properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}}');
  });

  test('bbox_returnsCorrectBbox', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final Feature feature = Feature.fromGeometry(lineString, bbox: bbox);
    expect(feature.bbox, isNotNull);
    expect(feature.bbox.west, 1.0);
    expect(feature.bbox.south, 2.0);
    expect(feature.bbox.east, 3.0);
    expect(feature.bbox.north, 4.0);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);

    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final Feature feature = Feature.fromGeometry(lineString, bbox: bbox);
    expect(feature.json,
        '{"type":"Feature","bbox":[1.0,2.0,3.0,4.0],"properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}}');
  });

  test('point_feature_fromJson', () {
    const String json =
        '{"type":"Feature","geometry":{"type":"Point","coordinates":[125.6,10.1]},"properties":{"name":"Dinagat Islands"}}';
    final Feature geo = Feature.fromJson(json);
    expect(geo.type, GeoJsonType.feature);
    expect(geo.geometry.type, GeoJsonType.point);
    expect((geo.geometry as Point).longitude, 125.6);
    expect((geo.geometry as Point).latitude, 10.1);
    expect(geo.properties['name'], 'Dinagat Islands');
  });

  test('linestring_feature_fromJson', () {
    const String json =
        '{"type":"Feature","geometry":{"type":"LineString","coordinates":[[102.0,20.0],[103.0,3.0],[104.0,4.0],[105.0,5.0]]},"properties":{"name":"line name"}}';
    final Feature geo = Feature.fromJson(json);
    expect(geo.type, GeoJsonType.feature);
    expect(geo.geometry.type, GeoJsonType.lineString);
    expect(geo.geometry, isNotNull);
    final List<Point> coordinates = (geo.geometry as LineString).coordinates;
    expect(coordinates, isNotNull);
    expect(coordinates.length, 4);
    expect(coordinates[3].longitude, 105.0);
    expect(coordinates[3].latitude, 5.0);
    expect(geo.properties['name'], 'line name');
  });

  test('point_feature_toJson', () {
    final Map<String, dynamic> properties = <String, dynamic>{
      'name': 'Dinagat Islands'
    };

    final Feature geo = Feature.fromGeometry(Point.fromLngLat(125.6, 10.1),
        properties: properties);

    const String expectedJson =
        '{"type":"Feature","properties":{"name":"Dinagat Islands"},"geometry":{"type":"Point","coordinates":[125.6,10.1]}}';

    expect(geo.json, expectedJson);
  });

  test('linestring_feature_toJson', () {
    final Map<String, dynamic> properties = <String, dynamic>{
      'name': 'Dinagat Islands'
    };

    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 1.0));
    points.add(Point.fromLngLat(2.0, 2.0));
    points.add(Point.fromLngLat(3.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);

    final Feature geo =
        Feature.fromGeometry(lineString, properties: properties);

    const String expectedJson =
        '{"type":"Feature","properties":{"name":"Dinagat Islands"},"geometry":{"type":"LineString","coordinates":[[1.0,1.0],[2.0,2.0],[3.0,3.0]]}}';

    expect(geo.json, expectedJson);
  });

  test('testNullProperties', () {
    final List<Point> coordinates = <Point>[];
    coordinates.add(Point.fromLngLat(0.1, 2.3));
    coordinates.add(Point.fromLngLat(4.5, 6.7));
    final LineString line = LineString.fromLngLats(coordinates);
    final Feature feature = Feature.fromGeometry(line);
    final String jsonString = feature.json;
    expect(jsonString.contains('"properties":{}'), isTrue);

    final Feature featureFromJson = Feature.fromJson(jsonString);
    expect(feature, featureFromJson);
  });

  test('testNonNullProperties', () {
    final List<Point> coordinates = <Point>[];
    coordinates.add(Point.fromLngLat(0.1, 2.3));
    coordinates.add(Point.fromLngLat(4.5, 6.7));
    final LineString line = LineString.fromLngLats(coordinates);
    final Map<String, dynamic> properties = <String, dynamic>{'key': 'value'};
    final Feature feature = Feature.fromGeometry(line, properties: properties);
    final String jsonString = feature.json;
    expect(jsonString, contains('"properties":{"key":"value"}'));

    expect(Feature.fromJson(jsonString), feature);
  });

  test('testEmptyPropertiesJson', () {
    const String jsonString =
        '{"type":"Feature","bbox":[1.0,2.0,3.0,4.0],"properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}}';

    final Feature feature = Feature.fromJson(jsonString);
    expect(feature.json, jsonString);
  });

  test('pointFeature_fromJson_toJson', () {
    const String jsonString =
        '{"type":"Feature","bbox":[-120.0,-60.0,120.0,60.0],"id":"id0","properties":{"prop0":"value0","prop1":"value1"},"geometry":{"bbox":[-110.0,-50.0,110.0,50.0],"type":"Point","coordinates":[100.0,0.0]}}';

    final Feature featureFromJson = Feature.fromJson(jsonString);
    expect(featureFromJson.json, jsonString);
  });

  test('feature_getProperty_empty_property', () {
    const String jsonString =
        '{"type":"Feature","geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}}';

    final Feature feature = Feature.fromJson(jsonString);
    expect(feature['does_not_exist'], isNull);
  });

  test('feature_property_doesnotexist', () {
    const String jsonString =
        '{"type":"Feature","geometry":{"type":"LineString","coordinates":[[1.0,1.0],[2.0,2.0],[3.0,3.0]]},"properties":{"some_name":"some_value"}}';
    final Feature feature = Feature.fromJson(jsonString);
    expect(feature['does_not_exist'], isNull);
  });
}
