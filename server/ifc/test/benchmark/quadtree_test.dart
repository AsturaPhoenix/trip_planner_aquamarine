import 'package:aquamarine_server_interface/io.dart';
import 'package:latlng/latlng.dart';
import 'package:test/test.dart';
import 'package:test_data/ofs.nc.dods.dart';

import '../../../lib/ofs_client.dart';

void main() {
  test('index and sample', () async {
    // Decode before starting the stopwatch.
    final data = kOfsLonLatNcDods;

    final stopwatch = Stopwatch()..start();
    final quadtree =
        await indexLatLng(OfsClient.readLatLng(Stream.value(data)));
    stopwatch.stop();
    print('index: ${stopwatch.elapsedMilliseconds} ms');
    print('node count: ${quadtree.nodeCount}');

    stopwatch.reset();

    final bounds = LatLngBounds(
      southwest: const LatLng(37.8, -122.5),
      northeast: const LatLng(37.9, -122.4),
    );

    for (int resolution = 50; resolution >= 10; resolution -= 10) {
      stopwatch.start();
      const nops = 100;
      int? length;
      for (int i = 0; i < nops; ++i) {
        final oldLength = length;
        length = quadtree.sample(bounds, resolution: .1 / resolution).length;
        if (oldLength != null) {
          expect(length, oldLength);
        }
      }
      stopwatch.stop();
      print('sample ${resolution}x$resolution: '
          '${stopwatch.elapsedMicroseconds / nops} µs; actual length $length');
      print('node count: ${quadtree.nodeCount}');
    }
  });
}
