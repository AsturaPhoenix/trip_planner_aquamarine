// This is mostly copied from google_maps_flutter_platform_interface, modified
// to strip out Flutter dependencies and add quality-of-life operations.

import 'dart:math';

import 'package:equatable/equatable.dart';

/// A pair of latitude and longitude coordinates, stored as degrees.
class LatLng extends Equatable {
  /// Creates a geographical location specified in degrees [latitude] and
  /// [longitude].
  ///
  /// The latitude is clamped to the inclusive interval from -90.0 to +90.0.
  ///
  /// The longitude is normalized to the half-open interval from -180.0
  /// (inclusive) to +180.0 (exclusive).
  const LatLng(double latitude, double longitude)
      : latitude =
            latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude),
        // Avoids normalization if possible to prevent unnecessary loss of precision
        longitude = longitude >= -180 && longitude < 180
            ? longitude
            : (longitude + 180.0) % 360.0 - 180.0;

  /// The latitude in degrees between -90.0 and 90.0, both inclusive.
  final double latitude;

  /// The longitude in degrees between -180.0 (inclusive) and 180.0 (exclusive).
  final double longitude;

  @override
  get props => [latitude, longitude];

  @override
  String toString() => 'LatLng($latitude, $longitude)';
}

/// A latitude/longitude aligned rectangle.
///
/// The rectangle conceptually includes all points (lat, lng) where
/// * lat ∈ [`southwest.latitude`, `northeast.latitude`]
/// * lng ∈ [`southwest.longitude`, `northeast.longitude`],
///   if `southwest.longitude` ≤ `northeast.longitude`,
/// * lng ∈ [-180, `northeast.longitude`] ∪ [`southwest.longitude`, 180],
///   if `northeast.longitude` < `southwest.longitude`
class LatLngBounds extends Equatable {
  /// Creates geographical bounding box with the specified corners.
  ///
  /// The latitude of the southwest corner cannot be larger than the
  /// latitude of the northeast corner.
  LatLngBounds({required this.southwest, required this.northeast})
      : assert(southwest.latitude <= northeast.latitude);

  /// The southwest corner of the rectangle.
  final LatLng southwest;

  /// The northeast corner of the rectangle.
  final LatLng northeast;

  @override
  get props => [southwest, northeast];

  /// Returns whether this rectangle contains the given [LatLng].
  bool contains(LatLng point) =>
      _containsLatitude(point.latitude) && _containsLongitude(point.longitude);

  bool _containsLatitude(double lat) =>
      (southwest.latitude <= lat) && (lat <= northeast.latitude);

  bool _containsLongitude(double lng) {
    if (southwest.longitude <= northeast.longitude) {
      return southwest.longitude <= lng && lng <= northeast.longitude;
    } else {
      return southwest.longitude <= lng || lng <= northeast.longitude;
    }
  }

  @override
  String toString() => 'LatLngBounds($southwest, $northeast)';

  bool containsBounds(LatLngBounds bounds) =>
      contains(bounds.northeast) && contains(bounds.southwest);

  bool intersectsBounds(LatLngBounds bounds) =>
      _intersectsBoundsLatitude(bounds) && _intersectsBoundsLongitude(bounds);

  bool _intersectsBoundsLatitude(LatLngBounds bounds) =>
      northeast.latitude >= bounds.southwest.latitude &&
      southwest.latitude <= bounds.northeast.latitude;

  bool _intersectsBoundsLongitude(LatLngBounds bounds) =>
      _containsLongitude(bounds.northeast.longitude) ||
      _containsLongitude(bounds.southwest.longitude) ||
      bounds._containsLongitude(northeast.longitude);
  // If this doesn't contain either of bounds' endpoints, then bounds must
  // contain either both or neither of this's endpoints.

  /// Padds the bounds on each side by a factor. A factor of 0 indicates no
  /// padding, while a factor of .5 doubles the total area.
  LatLngBounds pad(double factor) {
    final latPadding = factor * (northeast.latitude - southwest.latitude);
    final lonPadding = factor * (northeast.longitude - southwest.longitude);
    return LatLngBounds(
      southwest: LatLng(
        southwest.latitude - latPadding,
        southwest.longitude - lonPadding,
      ),
      northeast: LatLng(
        northeast.latitude + latPadding,
        northeast.longitude + lonPadding,
      ),
    );
  }
}

/// [LatLngBounds] cannot represent empty or global bounds. This set of
/// extensions treats `null` as empty bounds.
extension NullableOperations on LatLngBounds? {
  bool get isEmpty => this == null;

  LatLngBounds expand(LatLng point) {
    if (isEmpty) return LatLngBounds(southwest: point, northeast: point);

    final southwest = this!.southwest, northeast = this!.northeast;
    final westOffset = (point.longitude - southwest.longitude) % 360,
        eastOffset = (point.longitude - northeast.longitude) % 360;
    return LatLngBounds(
      southwest: LatLng(
        min(southwest.latitude, point.latitude),
        westOffset > 180 ? point.longitude : southwest.longitude,
      ),
      northeast: LatLng(
        max(northeast.latitude, point.latitude),
        eastOffset > 180 ? northeast.longitude : point.longitude,
      ),
    );
  }
}
