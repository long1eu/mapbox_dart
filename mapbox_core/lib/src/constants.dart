import 'dart:io';

/// Includes common variables used throughout the Mapbox Service modules.
class Constants {
  Constants._();

  static final String version = '0.0.1';

  /// User agent for HTTP requests.
  static final String headerUserAgent = 'MapboxDart/${Platform.version} ($version)';

  /// Base URL for all API calls, not hardcoded to enable testing.
  static final String baseApiUrl = "https://api.mapbox.com";

  /// The default user variable used for all the Mapbox user names.
  static final String mapboxUser = "mapbox";

  /// Use a precision of 6 decimal places when encoding or decoding a polyline.
  static final int precision6 = 6;

  /// Use a precision of 5 decimal places when encoding or decoding a polyline.
  static final int precision5 = 5;
}
