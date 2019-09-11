library mapbox_geojson;

import 'dart:convert';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:mapbox_geojson/src/shifter/coordinate_shifter_manager.dart';
import 'package:meta/meta.dart';

part 'src/bounding_box.dart';
part 'src/common.dart';
part 'src/feature.dart';
part 'src/feature_collection.dart';
part 'src/geojson_error.dart';
part 'src/geojson_type.dart';
part 'src/geometry_collection.dart';
part 'src/line_string.dart';
part 'src/multi_line_string.dart';
part 'src/multi_point.dart';
part 'src/multi_polygon.dart';
part 'src/point.dart';
part 'src/polygon.dart';
part 'src/utils/geojson_utils.dart';
part 'src/utils/polyline_utils.dart';

/// A Mercator project has a finite longitude values, this constant represents
/// the lowest value available to represent a geolocation.
const double kMinLongitude = -180;

/// A Mercator project has a finite longitude values, this constant represents
/// the highest value available to represent a geolocation.
const double kMaxLongitude = 180;

/// While on a Mercator projected map the width (longitude) has a finite values,
/// the height (latitude) can be infinitely long. This constant restrains the
/// lower latitude value to -90 in order to preserve map readability and allows
/// easier logic for tile selection.
const double kMinLatitude = -90;

/// While on a Mercator projected map the width (longitude) has a finite values,
/// the height (latitude) can be infinitely long. This constant restrains the
/// upper latitude value to 90 in order to preserve map readability and allows
/// easier logic for tile selection.
const double kMaxLatitude = 90;
