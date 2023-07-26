import 'package:flutter_map/plugin_api.dart' as fml;
import 'package:latlng/latlng.dart';
import 'package:latlong2/latlong.dart' as fml;

extension LatLngExtensions on LatLng {
  fml.LatLng toFml() => fml.LatLng(latitude, longitude);
}

extension FmlLatLngExtensions on fml.LatLng {
  LatLng toSpherical() => LatLng(latitude, longitude);
}

extension LatLngBoundsExtensions on LatLngBounds {
  fml.LatLngBounds toFml() {
    final p1 = southwest.toFml(), p2 = northeast.toFml();

    // flutter_map doesn't support wrapping over the 180 meridian, so truncate.
    if (southwest.longitude > northeast.longitude) {
      if (180 - southwest.longitude <= northeast.longitude - (-180)) {
        p1.longitude = -180;
      } else {
        p2.longitude = 180;
      }
    }

    return fml.LatLngBounds(p1, p2);
  }
}

extension FmlLatLngBoundsExtensions on fml.LatLngBounds {
  LatLngBounds? toSpherical() => isValid
      ? LatLngBounds(
          southwest: southWest!.toSpherical(),
          northeast: northEast!.toSpherical(),
        )
      : null;
}
