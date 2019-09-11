// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// This defines a GeoJson [Feature] object which represents a spatially bound
/// thing. Every [Feature] object is a GeoJson object no matter where it occurs
/// in a GeoJson text.
///
/// The value of the [Feature.geometry] member SHALL be either a [Geometry] object
/// or, in the case that the Feature is unlocated, a JSON null value.
///
/// If a [Feature] has a commonly used identifier, that identifier SHOULD be
/// included as a member of the Feature object through the [Feature.id]] field,
/// and the value of this member is either a JSON string or number.
///
/// An example of a serialized feature is given below:
/// ```json
/// {
///   "type": "Feature",
///   "geometry": {
///     "type": "Point",
///     "coordinates": [102.0, 0.5]
///   },
///   "properties": {
///     "prop0": "value0"
///   }
/// ```
class Feature implements GeoJson {
  factory Feature.fromJson(String json) {
    return Feature.fromJsonMap(Map<String, dynamic>.from(jsonDecode(json)));
  }

  factory Feature.fromJsonMap(Map<String, dynamic> data) {
    if (data['geometry'] == null) {
      throw ArgumentError.notNull('geometry');
    }

    final Geometry geometry = Geometry.fromJson(data['geometry']);

    final Map<String, dynamic> properties = <String, dynamic>{
      if (data['properties'] != null) ...data['properties']
    };

    BoundingBox bbox;
    if (data['bbox'] != null) {
      bbox = BoundingBox.fromCoordinates(GeoJsonUtils.normalize(data['bbox']));
    }

    return Feature._(geometry, properties, bbox, data['id']);
  }

  /// Create a new instance of this class by giving the feature a [Geometry],
  /// optionally a set of properties, and a String which represents the objects
  /// id.
  factory Feature.fromGeometry(
    Geometry geometry, {
    Map<String, dynamic> properties = const <String, dynamic>{},
    BoundingBox bbox,
    String id,
  }) {
    return Feature._(geometry, properties, bbox, id);
  }

  const Feature._(this.geometry, this.properties, [this.bbox, this.id])
      : assert(properties != null);

  /// This describes the TYPE of GeoJson geometry this object is, thus this will
  /// always return [GeoJsonType.feature]
  @override
  GeoJsonType get type => GeoJsonType.feature;

  /// Return a list of double coordinate values describing a bounding box
  ///
  /// A Feature Collection might have a member named [bbox] to include
  /// information on the coordinate range for it's [Feature]s. The value of the
  /// bbox member MUST be a list of size 2*n where n is the number of dimensions
  /// represented in the contained feature geometries, with all axes of the most
  /// southwesterly point followed by all axes of the more northeasterly point.
  /// The axes order of a bbox follows the axes order of geometries.
  @override
  final BoundingBox bbox;

  /// unique identification or null if one wasn't given during creation.
  final String id;

  /// The geometry which makes up this feature.
  ///
  /// A Geometry object represents points, curves, and surfaces in coordinate
  /// space. One of the seven geometries provided inside this library can be
  /// passed in through one of the static factory methods.
  final Geometry geometry;

  /// This contains the JSON object which holds the feature properties. This
  /// value might be empty if no properties are provided.
  final Map<String, dynamic> properties;

  dynamic operator [](String key) => properties[key];

  void operator []=(String key, dynamic value) {
    assert(value is String || value is num || value is bool);
    properties[key] = value;
  }

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      if (id != null) 'id': id,
      'properties': properties,
      'geometry': geometry?.jsonMap,
    };
  }

  @override
  String get json => jsonEncode(jsonMap);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feature && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          id == other.id &&
          geometry == other.geometry &&
          const MapEquality<String, dynamic>()
              .equals(properties, other.properties);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      id.hashCode ^
      geometry.hashCode ^
      const MapEquality<String, dynamic>().hash(properties);
}
