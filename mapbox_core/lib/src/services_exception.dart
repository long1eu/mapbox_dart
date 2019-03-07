/// A form of [Exception] that indicates conditions that a reasonable application might want to catch.
///
/// The detail [message] (which is saved for later.
class ServicesException implements Exception {
  const ServicesException(this.message);

  final String message;

  @override
  String toString() => 'ServicesException{message: $message}';
}
