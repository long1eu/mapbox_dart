library point;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mapbox_geojson/src/bounding_box.dart';
import 'package:mapbox_geojson/src/geojson_constants.dart';
import 'package:mapbox_geojson/src/geojson_type.dart';
import 'package:mapbox_geojson/src/serializers.dart';
import 'package:mapbox_geojson/src/shifter/coordinate_shifter_manager.dart';
import 'package:meta/meta.dart';

part 'point.g.dart';

/// A point represents a single geographic position and is one of the seven Geometries found in the
/// GeoJson spec.
/// <p>
/// This adheres to the RFC 7946 internet standard when serialized into JSON. When deserialized, this
/// class becomes an immutable object which should be initiated using its static factory methods.
/// </p><p>
/// Coordinates are in x, y order (easting, northing for projected coordinates), longitude, and
/// latitude for geographic coordinates), precisely in that order and using double values. Altitude
/// or elevation MAY be included as an optional third parameter while creating this object.
/// <p>
/// The size of a GeoJson text in bytes is a major interoperability consideration, and precision of
/// coordinate values has a large impact on the size of texts when serialized. For geographic
/// coordinates with units of degrees, 6 decimal places (a default common in, e.g., sprintf) amounts
/// to about 10 centimeters, a precision well within that of current GPS systems. Implementations
/// should consider the cost of using a greater precision than necessary.
/// <p>
/// Furthermore, pertaining to altitude, the WGS 84 datum is a relatively coarse approximation of the
/// geoid, with the height varying by up to 5 m (but generally between 2 and 3 meters) higher or
/// lower relative to a surface parallel to Earth's mean sea level.
/// <p>
/// A sample GeoJson Point's provided below (in its serialized state).
/// ```json
/// {
///   "type": "Point",
///   "coordinates": [100, 0]
/// }
/// ```
///
/// @since 1.0.0
abstract class Point implements Built<Point, PointBuilder>, CoordinateContainer<BuiltList<double>> {
  factory Point([void updates(PointBuilder b)]) = _$Point;

  /// Create a new instance of this class defining a longitude and latitude value in that respective
  /// order. Longitude values are limited to a -180 to 180 range and latitude's limited to -90 to 90
  /// as the spec defines. While no limit is placed on decimal precision, for performance reasons
  /// when serializing and deserializing it is suggested to limit decimal precision to within 6
  /// decimal places. An optional altitude value can be passed in and can vary between negative
  /// infinity and positive infinity.
  factory Point.fromLngLat({@required double longitude, @required double latitude, BoundingBox bbox}) {
    assert(longitude >= GeoJsonConstants.MIN_LONGITUDE && longitude <= GeoJsonConstants.MAX_LONGITUDE);
    assert(latitude >= GeoJsonConstants.MIN_LATITUDE && latitude <= GeoJsonConstants.MAX_LATITUDE);

    List<double> coordinates = CoordinateShifterManager.getCoordinateShifter().shiftLonLat(longitude, latitude);
    return Point((PointBuilder b) {
      b
        ..bbox = bbox?.toBuilder()
        ..coordinates = ListBuilder<double>(coordinates);
    });
  }

  factory Point.fromLngLatAlt({
    @required double longitude,
    @required double latitude,
    @required double altitude,
    BoundingBox bbox,
  }) {
    assert(longitude >= GeoJsonConstants.MIN_LONGITUDE && longitude <= GeoJsonConstants.MAX_LONGITUDE);
    assert(latitude >= GeoJsonConstants.MIN_LATITUDE && latitude <= GeoJsonConstants.MAX_LATITUDE);

    List<double> coordinates =
        CoordinateShifterManager.getCoordinateShifter().shiftLonLatAlt(longitude, latitude, altitude);
    return Point((PointBuilder b) {
      b
        ..bbox = bbox?.toBuilder()
        ..coordinates = ListBuilder<double>(coordinates);
    });
  }

  static Point fromCoordinates(List<double> coords) {
    if (coords.length == 2) {
      return Point.fromLngLat(longitude: coords[0], latitude: coords[1]);
    } else if (coords.length > 2) {
      return Point.fromLngLatAlt(longitude: coords[0], latitude: coords[1], altitude: coords[2]);
    }
    return null;
  }

  factory Point.fromJson(Map<String, dynamic> json) => serializers.deserializeWith(serializer, json);

  Point._();

  /// This describes the TYPE of GeoJson geometry this object is, thus this will always return [GeoJsonType.Point].
  @memoized
  @override
  GeoJsonType get type => GeoJsonType.Point;

  /// A Feature Collection might have a member named [bbox] to include information on the
  /// coordinate range for it's [Feature]s. The value of the bbox member MUST be a list of
  /// size 2*n where n is the number of dimensions represented in the contained feature geometries,
  /// with all axes of the most southwesterly point followed by all axes of the more northeasterly
  /// point. The axes order of a bbox follows the axes order of geometries.
  ///
  /// Return a list of double coordinate values describing a bounding box
  @nullable
  @override
  BoundingBox get bbox;

  /// Provide a single double array containing the longitude, latitude, and optionally an
  /// altitude/elevation. [longitude], [latitude], and [altitude] are all
  /// avaliable which make getting specific coordinates more direct.
  ///
  /// Return a double array which holds this points coordinates
  @override
  BuiltList<double> get coordinates;

  /// This returns a double value ranging from -180 to 180 representing the x or easting position of
  /// this point. ideally, this value would be restricted to 6 decimal places to correctly follow the
  /// GeoJson spec.
  ///
  /// Return a double value ranging from -180 to 180 representing the x or easting position of this
  /// point
  @memoized
  double get longitude => coordinates[0];

  /// This returns a double value ranging from -90 to 90 representing the y or northing position of
  /// this point. ideally, this value would be restricted to 6 decimal places to correctly follow the
  /// GeoJson spec.
  ///
  /// Return a double value ranging from -90 to 90 representing the y or northing position of this
  /// point
  @memoized
  double get latitude => coordinates[1];

  /// Optionally, the coordinate spec in GeoJson allows for altitude values to be placed inside the
  /// coordinate array. [hasAltitude] can be used to determine if this value was set during
  /// initialization of this Point instance. This double value should only be used to represent
  /// either the elevation or altitude value at this particular point.
  ///
  /// Return a double value ranging from negative to positive infinity
  double get altitude {
    if (coordinates.length < 3) {
      return double.nan;
    }
    return coordinates[2];
  }

  /// Optionally, the coordinate spec in GeoJson allows for altitude values to be placed inside the
  /// coordinate array. If an altitude value was provided while initializing this instance, this will
  /// return true.
  ///
  /// Return true if this instance of point contains an altitude value
  bool get hasAltitude => !altitude.isNaN;

  @memoized
  @override
  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<Point> get serializer => _$pointSerializer;
}

abstract class PointBuilder implements Builder<Point, PointBuilder> {
  BoundingBoxBuilder bbox;

  ListBuilder<double> coordinates;

  factory PointBuilder() = _$PointBuilder;

  PointBuilder._();
}
