// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// Generic implementation for all GeoJson objects defining common traits that
/// each GeoJson object has. This logic is carried over to [Geometry] which is
/// an interface which all seven GeoJson geometries implement.
abstract class GeoJson {
  /// This describes the type of [GeoJson] geometry, [Feature], or
  /// [FeatureCollection] this object is. Every GeoJson Object will have this
  /// defined once an instance is created and will never return null.
  GeoJsonType get type;

  /// This takes the currently defined values found inside the GeoJson instance
  /// and converts it to a GeoJson map.
  Map<String, dynamic> get jsonMap;

  /// This takes the currently defined values found inside the GeoJson instance
  /// and converts it to a GeoJson map.
  String get json;

  /// Return a list of double coordinate values describing a bounding box
  ///
  /// A Feature Collection might have a member named [bbox] to include
  /// information on the coordinate range for it's [Feature]s. The value of the
  /// bbox member MUST be a list of size 2*n where n is the number of dimensions
  /// represented in the contained feature geometries, with all axes of the most
  /// southwesterly point followed by all axes of the more northeasterly point.
  /// The axes order of a bbox follows the axes order of geometries.
  BoundingBox get bbox;
}

/// Each of the six geometries and [GeometryCollection] which make up GeoJson
/// implement this interface.
abstract class Geometry implements GeoJson {
  factory Geometry.fromJson(Map<String, dynamic> data) {
    if (data['type'] == null) {
      throw ArgumentError.notNull('type');
    }

    switch (GeoJsonType.valueOf(data['type'])) {
      case GeoJsonType.geometryCollection:
        return GeometryCollection.fromJsonMap(data);
      case GeoJsonType.point:
        return Point.fromJsonMap(data);
      case GeoJsonType.multiPoint:
        return MultiPoint.fromJsonMap(data);
      case GeoJsonType.lineString:
        return LineString.fromJsonMap(data);
      case GeoJsonType.multiLineString:
        return MultiLineString.fromJsonMap(data);
      case GeoJsonType.polygon:
        return Polygon.fromJsonMap(data);
      case GeoJsonType.multiPolygon:
        return MultiPolygon.fromJsonMap(data);
    }

    throw ArgumentError('Unknown geojson type $data');
  }
}

/// Each of the geometries which make up [GeoJson] implement this interface and
/// consume a varying dimension of [Point] list. Since this is varying, each
/// geometry object fulfills the contract by replacing the generic with a well
/// defined list of Points.
abstract class CoordinateContainer<T> implements Geometry {
  /// Return the [Point]s which make up the coordinates defining the geometry
  T get coordinates;
}
