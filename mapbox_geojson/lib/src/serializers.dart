// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/feature.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/geometry_collection.dart';
import 'package:mapbox_geojson/src/line_string.dart';
import 'package:mapbox_geojson/src/multi_line_string.dart';
import 'package:mapbox_geojson/src/multi_point.dart';
import 'package:mapbox_geojson/src/multi_polygon.dart';
import 'package:mapbox_geojson/src/point.dart';
import 'package:mapbox_geojson/src/polygon.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  BoundingBox,
  BoundingBox,
  Feature,
  GeoJsonType,
  LineString,
  MultiLineString,
  GeometryCollection,
  MultiPoint,
  MultiPolygon,
  Point,
  Point,
  Polygon,
])
final Serializers serializers = (_$serializers.toBuilder() //
      ..addPlugin(StandardJsonPlugin()) //
    )
    .build();

/// Generic implementation for all GeoJson objects defining common traits that each GeoJson object
/// has. This logic is carried over to [Geometry] which is an interface which all seven GeoJson
/// geometries implement.
abstract class GeoJson {
  /// This describes the type of [GeoJson] geometry, [Feature], or [FeatureCollection] this object is.
  /// Every GeoJson Object will have this defined once an instance is created and will never return
  /// null.
  ///
  /// Return a value which describes the type of geometry, for this object it will always return [Feature]
  /// @since 1.0.0
  GeoJsonType get type;

  /// This takes the currently defined values found inside the GeoJson instance and converts it to a
  /// GeoJson map.
  Map<String, dynamic> get json;

  /// A [GeoJson] object MAY have a member named "bbox" to include information on the coordinate range
  /// for its [Geometry](ies), [Feature]s, or [FeatureCollection]s.  The value of the bbox member MUST be an
  /// array of length 2*n where n is the number of dimensions represented in the contained
  /// geometries, with all axes of the most southwesterly point followed by all axes of the more
  /// northeasterly point. The axes order of a bbox follows the axes order of geometries.
  ///
  /// Return a double array with the length 2*n where n is the number of dimensions represented in
  /// the contained geometries
  BoundingBox get bbox;
}

/// Each of the six geometries and [GeometryCollection] which make up GeoJson implement this interface.
abstract class Geometry extends GeoJson {}

/// Each of the s geometries which make up [GeoJson] implement this interface and consume a varying
/// dimension of [Point] list. Since this is varying, each geometry object fulfills the
/// contract by replacing the generic with a well defined list of Points.
///
/// <T> a generic allowing varying dimensions for each [GeoJson] geometry
abstract class CoordinateContainer<T> extends Geometry {
  /// The coordinates which define the geometry. Typically a list of points but for some geometry
  /// such as polygon this can be a list of a list of points, thus the return is generic here.
  ///
  /// Return the [Point]s which make up the coordinates defining the geometry
  T get coordinates;
}
