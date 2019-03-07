import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class MarkerScale {
  const MarkerScale._(this._value);

  final String _value;

  /// The Static Maps marker shape and size will be small.
  static const MarkerScale small = MarkerScale._('pin-s');

  /// The Static Maps marker shape and size will be medium.
  static const MarkerScale medium = MarkerScale._('pin-m');

  /// The Static Maps marker shape and size will be large.
  static const MarkerScale large = MarkerScale._('pin-l');

  static const List<MarkerScale> values = <MarkerScale>[
    small,
    medium,
    large,
  ];

  static const List<String> _names = <String>[
    'pin-s',
    'pin-m',
    'pin-l',
  ];

  static Serializer<MarkerScale> get serializer => _serializer;

  @override
  String toString() => _value;
}

Serializer<MarkerScale> _serializer = _MarkerScaleSerializer();

class _MarkerScaleSerializer implements PrimitiveSerializer<MarkerScale> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>([MarkerScale]);
  @override
  final String wireName = 'MarkerScale';

  @override
  Object serialize(Serializers serializers, MarkerScale scale, {FullType specifiedType = FullType.unspecified}) {
    return scale._value;
  }

  @override
  MarkerScale deserialize(Serializers serializers, Object serialized, {FullType specifiedType = FullType.unspecified}) {
    return MarkerScale.values[MarkerScale._names.indexOf(serialized)];
  }
}
