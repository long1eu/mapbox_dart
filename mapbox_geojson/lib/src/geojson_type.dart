// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

class GeoJsonType {
  const GeoJsonType._(this.name);

  final String name;

  static const GeoJsonType geometryCollection =
      GeoJsonType._('GeometryCollection');
  static const GeoJsonType point = GeoJsonType._('Point');
  static const GeoJsonType multiPoint = GeoJsonType._('MultiPoint');
  static const GeoJsonType lineString = GeoJsonType._('LineString');
  static const GeoJsonType multiLineString = GeoJsonType._('MultiLineString');
  static const GeoJsonType polygon = GeoJsonType._('Polygon');
  static const GeoJsonType multiPolygon = GeoJsonType._('MultiPolygon');
  static const GeoJsonType feature = GeoJsonType._('Feature');
  static const GeoJsonType featureCollection =
      GeoJsonType._('FeatureCollection');

  static const List<GeoJsonType> values = <GeoJsonType>[
    geometryCollection,
    point,
    multiPoint,
    lineString,
    multiLineString,
    polygon,
    multiPolygon,
    feature,
    featureCollection,
  ];

  static GeoJsonType valueOf(String name) {
    return values.firstWhere((GeoJsonType it) => it.name == name);
  }
}
