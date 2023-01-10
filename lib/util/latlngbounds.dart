import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

extension Expand on LatLngBounds? {
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

extension ContainsBounds on LatLngBounds {
  bool containsBounds(LatLngBounds bounds) =>
      contains(bounds.northeast) && contains(bounds.southwest);
}
