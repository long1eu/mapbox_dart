/// A form of [Exception] that indicates conditions that a reasonable application might want to catch.
///
/// The detail [message] (which is saved for later.
class GeoJsonException implements Exception {
  const GeoJsonException(this.message);

  final String message;

  @override
  String toString() => 'GeoJsonException{message: $message}';
}