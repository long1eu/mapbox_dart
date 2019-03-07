import 'package:mapbox_geojson/src/feature.dart';
import 'package:mapbox_geojson/src/line_string.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:test/test.dart';

void main() {
  final String SAMPLE_FEATURE_POINT = "sample-feature-point-all.json";

  test('sanity', () {
    List<Point> points = <Point>[];
    points.add(Point.fromLngLat(longitude: 1.0, latitude: 2.0));
    points.add(Point.fromLngLat(longitude: 2.0, latitude: 3.0));
    LineString lineString = LineString.fromLngLats(points: points);
    Feature feature = Feature.fromGeometry(geometry: lineString);

    print(feature);

    expect(feature, isNotNull);
  });
}
