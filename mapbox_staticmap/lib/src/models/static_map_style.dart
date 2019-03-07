import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

/// Constant values related to the Static Map API can be found in this class.
class StaticMapStyle {
  const StaticMapStyle._(this._value);

  final String _value;

  /// Mapbox Streets is a comprehensive, general-purpose map that emphasizes accurate, legible
  /// styling of road and transit networks.
  static const String street = 'streets-v10';

  /// Mapbox Outdoors is a general-purpose map with curated tilesets and specialized styling tailored
  /// to hiking, biking, and the most adventurous use cases.
  static const String outdoors = 'outdoors-v10';

  /// Mapbox Light style's a subtle, full-featured map designed to provide geographic context while
  /// highlighting the data on your analytics dashboard, data visualization, or data overlay.
  static const String light = 'light-v9';

  /// Mapbox Dark style's a subtle, full-featured map designed to provide geographic context while
  /// highlighting the data on your analytics dashboard, data visualization, or data overlay.
  static const String dark = 'dark-v9';

  /// Mapbox Satellite is our full global base map that is perfect as a blank canvas or an overlay
  /// for your own data.
  static const String satellite = 'satellite-v9';

  /// Mapbox Satellite Streets combines our Mapbox Satellite with vector data from Mapbox Streets.
  /// The comprehensive set of road, label, and POI information brings clarity and context to the
  /// crisp detail in our high-resolution satellite imagery.
  static const String satelliteStreets = 'satellite-streets-v10';

  /// Navigation specific style that shows only the necessary information while a user is driving.
  static const String navigationPreviewDay = 'navigation-preview-day-v2';

  /// Navigation specific style that shows only the necessary information while a user is driving.
  static const String navigationPreviewNight = 'navigation-preview-night-v2';

  /// Navigation specific style that shows only the necessary information while a user is driving.
  static const String navigationGuidanceDay = 'navigation-guidance-day-v2';

  /// Navigation specific style that shows only the necessary information while a user is driving.
  static const String navigationGuidanceNight = 'navigation-guidance-night-v2';

  static const List<String> values = <String>[
    street,
    outdoors,
    light,
    dark,
    satellite,
    satelliteStreets,
    navigationPreviewDay,
    navigationPreviewNight,
    navigationGuidanceDay,
    navigationGuidanceNight,
  ];

  static const List<String> _names = <String>[
    'streets-v10',
    'outdoors-v10',
    'light-v9',
    'dark-v9',
    'satellite-v9',
    'satellite-streets-v10',
    'navigation-preview-day-v2',
    'navigation-preview-night-v2',
    'navigation-guidance-day-v2',
    'navigation-guidance-night-v2',
  ];

  static Serializer<String> get serializer => _serializer;

  @override
  String toString() => _value;
}

Serializer<String> _serializer = _StaticMapStyleSerializer();

class _StaticMapStyleSerializer implements PrimitiveSerializer<String> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>([String]);
  @override
  final String wireName = 'String';

  @override
  Object serialize(Serializers serializers, String scale, {FullType specifiedType = FullType.unspecified}) {
    return scale;
  }

  @override
  String deserialize(Serializers serializers, Object serialized, {FullType specifiedType = FullType.unspecified}) {
    return StaticMapStyle.values[StaticMapStyle._names.indexOf(serialized)];
  }
}
