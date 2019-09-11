// File created by
// Lung Razvan <long1eu>
// on 08/11/2018

part of mapbox_geojson;

/// A form of [Error] that indicates conditions that a reasonable
/// application might want to catch.
class GeoJsonError extends Error {
  GeoJsonError(this.message);

  final String message;

  @override
  String toString() => 'GeoJsonException{message: $message}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoJsonError && //
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
