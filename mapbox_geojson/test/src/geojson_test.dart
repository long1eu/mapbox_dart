// File created by
// Lung Razvan <long1eu>
// on 11/09/2019

import 'package:mapbox_geojson/mapbox_geojson.dart';
import 'package:test/test.dart';

void main() {
  test('testSevenDigitRounding', () {
    final Point roundDown = Point.fromLngLat(1.12345678, 1.12345678);
    final Point noRound = Point.fromLngLat(1.1234, 1.12345);
    final Point matchRound = Point.fromLngLat(1.1234567, 1.1234567);
    final Point roundLat = Point.fromLngLat(1.1234567, 1.12345678);
    final Point roundLon = Point.fromLngLat(1.12345678, 1.1234567);
    final Point largeRound = Point.fromLngLat(105.12345678, 89.1234567);
    final Point negRound = Point.fromLngLat(-105.12345678, -89.1234567);

    final List<Feature> features = <Feature>[
      Feature.fromGeometry(roundDown),
      Feature.fromGeometry(noRound),
      Feature.fromGeometry(matchRound),
      Feature.fromGeometry(roundLat),
      Feature.fromGeometry(roundLon),
      Feature.fromGeometry(largeRound),
      Feature.fromGeometry(negRound),
    ];

    final FeatureCollection featureCollection =
        FeatureCollection.fromFeatures(features);

    final List<Feature> featureCollectionRounded =
        FeatureCollection.fromJson(featureCollection.json).features;

    final Point roundDown2 = featureCollectionRounded[0].geometry;
    final Point noRound2 = featureCollectionRounded[1].geometry;
    final Point matchRound2 = featureCollectionRounded[2].geometry;
    final Point roundLat2 = featureCollectionRounded[3].geometry;
    final Point roundLon2 = featureCollectionRounded[4].geometry;
    final Point largeRound2 = featureCollectionRounded[5].geometry;
    final Point negRound2 = featureCollectionRounded[6].geometry;

    expect(roundDown2.longitude, 1.1234568);
    expect(roundDown2.latitude, 1.1234568);
    expect(noRound2, noRound);
    expect(matchRound2, matchRound);
    expect(roundLat2.longitude, roundLat.longitude);
    expect(roundLat2.latitude, 1.1234568);
    expect(roundLon2.longitude, 1.1234568);
    expect(roundLon2.latitude, roundLon.latitude);
    expect(largeRound2.longitude, 105.1234568);
    expect(largeRound2.latitude, largeRound.latitude);
    expect(negRound2.longitude, -105.1234568);
    expect(negRound2.latitude, negRound.latitude);
  });
}
