import 'dart:io';

import 'package:mapbox_core/src/constants.dart';

/// Checks that the provided access token is not empty or null, and that it starts with
/// the right prefixes. Note that this method does not check Mapbox servers to verify that
/// it actually belongs to an account.
bool isAccessTokenValid(String accessToken) {
  return accessToken.isNotEmpty &&
      !(!accessToken.startsWith("pk.") && !accessToken.startsWith("sk.") && !accessToken.startsWith("tk."));
}

String toHexString(int red, int green, int blue) {
  StringBuffer buffer = StringBuffer();
  buffer //
    ..write('#')
    ..write(red.toRadixString(16).padLeft(2, '0').toUpperCase())
    ..write(green.toRadixString(16).padLeft(2, '0').toUpperCase())
    ..write(blue.toRadixString(16).padLeft(2, '0').toUpperCase());
  return buffer.toString();
}

String getHeaderUserAgent(String clientAppName) =>
    'MapbocDart/${Constants.version} ${Platform.operatingSystem}/${Platform.operatingSystemVersion}';
