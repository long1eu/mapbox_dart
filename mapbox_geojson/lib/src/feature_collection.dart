// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// This represents a GeoJson Feature Collection which holds a list of [Feature]
/// objects (when serialized the feature list becomes a JSON array).
///
/// Note that the feature list could potentially be empty. Features within the
/// list must follow the specifications defined inside the [Feature] class.
///
/// An example of a Feature Collections given below:
/// ```json
/// {
///   "type": "FeatureCollection",
///   "bbox": [100.0, 0.0, -100.0, 105.0, 1.0, 0.0],
///   "features": [
///     //...
///   ]
/// }
/// ```
class FeatureCollection implements GeoJson {
  factory FeatureCollection.fromJson(String json) {
    return FeatureCollection.fromJsonMap(
        Map<String, dynamic>.from(jsonDecode(json)));
  }

  /// Create a new instance of this class by passing in a formatted valid JSON
  /// String. If you are creating a [FeatureCollection] object from scratch it
  /// is better to use one of the other provided factory constructor such as
  /// [FeatureCollection.fromFeatures].
  factory FeatureCollection.fromJsonMap(Map<String, dynamic> data) {
    if (data['features'] == null) {
      throw ArgumentError.notNull('features');
    }

    final List<Feature> features = data['features']
        .map((dynamic it) => Feature.fromJsonMap(it))
        .cast<Feature>()
        .toList();

    BoundingBox bbox;
    if (data['bbox'] != null) {
      bbox = BoundingBox.fromCoordinates(GeoJsonUtils.normalize(data['bbox']));
    }

    return FeatureCollection._(features, bbox);
  }

  /// Create a new instance of this class by giving the feature collection a
  /// list of [Feature]s. The list of features itself isn't null but it can be
  /// empty and have a size of 0.
  factory FeatureCollection.fromFeatures(List<Feature> features,
      [BoundingBox bbox]) {
    return FeatureCollection._(features, bbox);
  }

  /// Create a new instance of this class by giving the feature collection a
  /// single [Feature].
  factory FeatureCollection.fromFeature(Feature feature, [BoundingBox bbox]) {
    return FeatureCollection._(<Feature>[feature], bbox);
  }

  const FeatureCollection._(this.features, [this.bbox])
      : assert(features != null);

  /// This describes the TYPE of GeoJson geometry this object is, thus this will
  /// always return [GeoJsonType.featureCollection]
  @override
  GeoJsonType get type => GeoJsonType.featureCollection;

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

  /// This provides the list of feature making up this Feature Collection.
  ///
  /// Note that if the [FeatureCollection] was created through
  /// [FeatureCollection.fromJson] this list could be null. Otherwise, the list
  /// can't be null but the size of the list can equal 0.
  final List<Feature> features;

  @override
  Map<String, dynamic> get jsonMap {
    return <String, dynamic>{
      'type': type.name,
      if (bbox != null) 'bbox': bbox.json,
      'features': features.map((Feature it) => it.jsonMap).toList(),
    };
  }

  @override
  String get json => jsonEncode(jsonMap);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeatureCollection && //
          runtimeType == other.runtimeType &&
          bbox == other.bbox &&
          const ListEquality<Feature>().equals(features, other.features);

  @override
  int get hashCode =>
      bbox.hashCode ^ //
      const ListEquality<Feature>().hash(features);
}
