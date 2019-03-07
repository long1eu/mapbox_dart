/// Contains simple precondition checks.
class Preconditions {
  /// Checks if the passed in value is not Null. Throws a [ArgumentError] if the value is null.
  static void checkNotNull(Object value, String message) {
    if (value == null) {
      throw ArgumentError.value(value, null, message);
    }
  }

  Preconditions._() {}
}
