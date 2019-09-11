import 'dart:convert';
import 'dart:io';

import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

// ignore_for_file: avoid_as
void main() {
  test('sanity', () {
    final List<Feature> features = <Feature>[
      Feature.fromGeometry(null),
      Feature.fromGeometry(null),
    ];

    final FeatureCollection featureCollection =
        FeatureCollection.fromFeatures(features);
    expect(featureCollection, isNotNull);
  });

  test('bbox_nullWhenNotSet', () {
    final List<Feature> features = <Feature>[
      Feature.fromGeometry(null),
      Feature.fromGeometry(null),
    ];

    final FeatureCollection featureCollection =
        FeatureCollection.fromFeatures(features);
    expect(featureCollection.bbox, isNull);
  });

  test('bbox_doesNotSerializeWhenNotPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final Feature feature = Feature.fromGeometry(lineString);

    final FeatureCollection featureCollection =
        FeatureCollection.fromFeatures(<Feature>[feature, feature]);
    expect(featureCollection.json,
        '{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}},{"type":"Feature","properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}}]}');
  });

  test('bbox_returnsCorrectBbox', () {
    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final FeatureCollection featureCollection = FeatureCollection.fromFeatures(
      <Feature>[
        Feature.fromGeometry(null),
        Feature.fromGeometry(null),
      ],
      bbox,
    );
    expect(featureCollection.bbox, isNotNull);
    expect(featureCollection.bbox.west, 1.0);
    expect(featureCollection.bbox.south, 2.0);
    expect(featureCollection.bbox.east, 3.0);
    expect(featureCollection.bbox.north, 4.0);
  });

  test('bbox_doesSerializeWhenPresent', () {
    final List<Point> points = <Point>[];
    points.add(Point.fromLngLat(1.0, 2.0));
    points.add(Point.fromLngLat(2.0, 3.0));
    final LineString lineString = LineString.fromLngLats(points);
    final Feature feature = Feature.fromGeometry(lineString);

    final List<Feature> features = <Feature>[];
    features.add(feature);
    features.add(feature);
    final BoundingBox bbox =
        BoundingBox.fromLngLats(west: 1.0, south: 2.0, east: 3.0, north: 4.0);
    final FeatureCollection featureCollection =
        FeatureCollection.fromFeatures(features, bbox);
    expect(featureCollection.json,
        '{"type":"FeatureCollection","bbox":[1.0,2.0,3.0,4.0],"features":[{"type":"Feature","properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}},{"type":"Feature","properties":{},"geometry":{"type":"LineString","coordinates":[[1.0,2.0],[2.0,3.0]]}}]}');
  });

  test('passingInSingleFeature_doesHandleCorrectly', () {
    final Point geometry = Point.fromLngLat(1.0, 2.0);
    final Feature feature = Feature.fromGeometry(geometry);
    final FeatureCollection geo = FeatureCollection.fromFeature(feature);
    expect(geo.features, isNotNull);
    expect(geo.features.length, 1);

    expect((geo.features[0].geometry as Point).coordinates[1], 2.0);
  });

  test('fromJson', () {
    final String json =
        File('test/res/sample-featurecollection.json').readAsStringSync();

    final FeatureCollection geo = FeatureCollection.fromJson(json);
    expect(geo.type, GeoJsonType.featureCollection);
    expect(geo.features.length, 3);
    expect(geo.features[0].type, GeoJsonType.feature);
    expect(geo.features[0].geometry.type, GeoJsonType.point);
    expect(geo.features[1].type, GeoJsonType.feature);
    expect(geo.features[1].geometry.type, GeoJsonType.lineString);
    expect(geo.features[2].type, GeoJsonType.feature);
    expect(geo.features[2].geometry.type, GeoJsonType.polygon);
  });

  test('toJson', () {
    final String json =
        File('test/res/sample-feature-collection-with-bbox.json')
            .readAsStringSync();

    final FeatureCollection geo = FeatureCollection.fromJson(json);
    expect(geo.jsonMap, jsonDecode(json));
  });
}
