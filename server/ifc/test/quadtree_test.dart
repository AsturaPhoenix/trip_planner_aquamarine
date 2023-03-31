import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/quadtree.dart';
import 'package:test/test.dart';

import '../../../test/data/ofs.nc.dods.dart';
import '../../lib/ofs_client.dart';

void main() {
  group('sample', () {
    test('full', () {
      final entries = {
        for (double lat = 0; lat < 5; ++lat)
          for (double lng = 0; lng < 5; ++lng)
            QuadtreeEntry(LatLng(lat, lng), Object())
      };

      final quadtree = Quadtree<Object>();
      for (final entry in entries) {
        quadtree.add(entry.location, entry.value);
      }
      expect(
        quadtree.sample(LatLngBounds(
          southwest: const LatLng(0, 0),
          northeast: const LatLng(5, 5),
        )),
        entries,
      );
    });

    test('windowed without split', () {
      final entries = {
        for (double lat = -5; lat < 5; ++lat)
          for (double lng = -5; lng < 5; ++lng)
            QuadtreeEntry(LatLng(lat, lng), Object())
      };

      final quadtree = Quadtree<Object>(threshold: 1000);
      for (final entry in entries) {
        quadtree.add(entry.location, entry.value);
      }
      final bounds = LatLngBounds(
        southwest: const LatLng(0, 0),
        northeast: const LatLng(2, 2),
      );
      expect(
        quadtree.sample(bounds),
        {...entries.where((entry) => bounds.contains(entry.location))},
      );
    });

    test('windowed with split', () {
      final entries = {
        for (double lat = -5; lat < 5; ++lat)
          for (double lng = -5; lng < 5; ++lng)
            QuadtreeEntry(LatLng(lat, lng), Object())
      };

      final quadtree = Quadtree<Object>(threshold: 4);
      for (final entry in entries) {
        quadtree.add(entry.location, entry.value);
      }
      final bounds = LatLngBounds(
        southwest: const LatLng(0, 0),
        northeast: const LatLng(3, 3),
      );
      expect(
        quadtree.sample(bounds),
        {...entries.where((entry) => bounds.contains(entry.location))},
      );
    });

    test('full with decimation', () {
      final entries = {
        for (double lat = 0; lat < 5; ++lat)
          for (double lng = 0; lng < 5; ++lng)
            QuadtreeEntry(LatLng(lat, lng), Object())
      };

      final quadtree = Quadtree<Object>();
      for (final entry in entries) {
        quadtree.add(entry.location, entry.value);
      }
      expect(
        quadtree.sample(
            LatLngBounds(
              southwest: const LatLng(0, 0),
              northeast: const LatLng(5, 5),
            ),
            resolution: 2),
        hasLength(4),
      );
    });

    test('windowed without split with decimation', () {
      final entries = {
        for (double lat = -5; lat < 5; ++lat)
          for (double lng = -5; lng < 5; ++lng)
            QuadtreeEntry(LatLng(lat, lng), Object())
      };

      final quadtree = Quadtree<Object>(threshold: 1000);
      for (final entry in entries) {
        quadtree.add(entry.location, entry.value);
      }
      final bounds = LatLngBounds(
        southwest: const LatLng(0, 0),
        northeast: const LatLng(3, 3),
      );
      expect(
        quadtree.sample(bounds, resolution: 2),
        hasLength(4),
      );
    });

    test('windowed with finer split than decimation', () {
      final entries = {
        for (double lat = -5; lat < 5; lat += .1)
          for (double lng = -5; lng < 5; lng += .1)
            QuadtreeEntry(LatLng(lat, lng), Object())
      };

      final quadtree = Quadtree<Object>(threshold: 4);
      for (final entry in entries) {
        quadtree.add(entry.location, entry.value);
      }
      final bounds = LatLngBounds(
        southwest: const LatLng(0, 0),
        northeast: const LatLng(3, 3),
      );
      expect(
        quadtree.sample(bounds, resolution: 2),
        hasLength(4),
      );
    });

    // The act of sampling may further split a quadtree. Make sure that sampling
    // at a deeper resolution doesn't destabilize samples taken before and after
    // at a lower resolution.
    test('is stable against further splits', () async {
      final quadtree = await indexLatLng(
          OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      final bounds1 = LatLngBounds(
        southwest: const LatLng(37.749046184059644, -122.59083476257324),
        northeast: const LatLng(37.87212099252033, -122.41316523742675),
      );
      const resolution1 = 0.0068359375;
      final bounds2 = LatLngBounds(
        southwest: const LatLng(37.79521462250422, -122.5242086906433),
        northeast: const LatLng(37.82598332603151, -122.47979130935668),
      );
      const resolution2 = 0.0017106019721385875;

      final s1 = [...quadtree.sample(bounds1, resolution: resolution1)];

      // Zoom in briefly
      quadtree.sample(bounds2, resolution: resolution2).length;

      final s2 = [...quadtree.sample(bounds1, resolution: resolution1)];

      expect(s2, s1);
    });
  });
}
