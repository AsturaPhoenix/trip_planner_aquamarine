import 'package:aquamarine_server/ofs_client.dart';
import 'package:aquamarine_server/types.dart';
import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:test/test.dart';

import '../../test/data/ofs.nc.dods.dart';
import 'util/chunker.dart';

const kLatlngHash = Hex32(0x6cff5cb2);
const kSpeedLimit = 5; // ~10 kt

void main() {
  const n = SimulationSchedule.nowcast, f = SimulationSchedule.forecast;

  group('chooses correct nowcast outputs', () {
    test('for middle-of-the-road timestamps', () {
      expect(OfsClient.simulationTimes(HourUtc(2023, 3, 27, 5), n), [
        SimulationTime(n, HourUtc(2023, 3, 27, 9), 2),
      ]);
      expect(OfsClient.simulationTimes(HourUtc(2023, 3, 27, 6), n), [
        SimulationTime(n, HourUtc(2023, 3, 27, 9), 3),
      ]);
    });

    test('coincident with a simulation run', () {
      expect(OfsClient.simulationTimes(HourUtc(2023, 3, 27, 3), n), [
        SimulationTime(n, HourUtc(2023, 3, 27, 9), 0),
        SimulationTime(n, HourUtc(2023, 3, 27, 3), 6),
      ]);
    });

    test('at the end of the day', () {
      expect(OfsClient.simulationTimes(HourUtc(2023, 3, 27, 23), n), [
        SimulationTime(n, HourUtc(2023, 3, 28, 3), 2),
      ]);
    });

    test('coincident with a simulation run at the end of the day', () {
      expect(OfsClient.simulationTimes(HourUtc(2023, 3, 27, 21), n), [
        SimulationTime(n, HourUtc(2023, 3, 28, 3), 0),
        SimulationTime(n, HourUtc(2023, 3, 27, 21), 6),
      ]);
    });
  });

  group('chooses correct forecast outputs', () {
    test('for middle-of-the-road timestamps', () {
      expect(OfsClient.simulationTimes(HourUtc(2023, 3, 27, 5), f), [
        SimulationTime(f, HourUtc(2023, 3, 27, 3), 2),
        SimulationTime(f, HourUtc(2023, 3, 26, 21), 8),
        SimulationTime(f, HourUtc(2023, 3, 26, 15), 14),
        SimulationTime(f, HourUtc(2023, 3, 26, 9), 20),
        SimulationTime(f, HourUtc(2023, 3, 26, 3), 26),
        SimulationTime(f, HourUtc(2023, 3, 25, 21), 32),
        SimulationTime(f, HourUtc(2023, 3, 25, 15), 38),
        SimulationTime(f, HourUtc(2023, 3, 25, 9), 44),
      ]);
    });

    test('coincident with a simulation run', () {
      expect(OfsClient.simulationTimes(HourUtc(2023, 3, 27, 3), f), [
        SimulationTime(f, HourUtc(2023, 3, 27, 3), 0),
        SimulationTime(f, HourUtc(2023, 3, 26, 21), 6),
        SimulationTime(f, HourUtc(2023, 3, 26, 15), 12),
        SimulationTime(f, HourUtc(2023, 3, 26, 9), 18),
        SimulationTime(f, HourUtc(2023, 3, 26, 3), 24),
        SimulationTime(f, HourUtc(2023, 3, 25, 21), 30),
        SimulationTime(f, HourUtc(2023, 3, 25, 15), 36),
        SimulationTime(f, HourUtc(2023, 3, 25, 9), 42),
        SimulationTime(f, HourUtc(2023, 3, 25, 3), 48),
      ]);
    });
  });

  test('builds URI', () {
    expect(
        OfsClient.resourceUri(
          simulationTime: SimulationTime(n, HourUtc(2023, 3, 27, 3), 1),
          query: const ['lonc', 'latc', 'u[0][0]', 'v[0][0]'],
        ).toString(),
        'https://opendap.co-ops.nos.noaa.gov/thredds/dodsC/NOAA/SFBOFS/MODELS'
        '/2023/03/27/nos.sfbofs.fields.n001.20230327.t03z.nc.dods?'
        'lonc,latc,u%5B0%5D%5B0%5D,v%5B0%5D%5B0%5D');
  });

  forChunkers('not chunked', (chunker) {
    test('readLatLng', () async {
      final result = OfsClient.readLatLng(chunker([kOfsLonLatNcDods]));

      final bounds = LatLngBounds(
        southwest: const LatLng(35, -125),
        northeast: const LatLng(40, -120),
      );

      int count = 0;
      final reader = BufferedReader(result);
      try {
        await readLatLngs(reader, (latlng) {
          expect(
            latlng,
            predicate((LatLng latlng) => bounds.contains(latlng)),
          );
          ++count;
        });
      } finally {
        reader.cancel();
      }

      expect(count, kOfsNele);
    });

    test('readUv', () async {
      final result = await OfsClient.readUv(chunker([kOfsNcDods]));
      expect(result.latlngHash, kLatlngHash);

      int count = 0;
      final reader = BufferedReader(result.uv);
      try {
        await readVectors(reader, () => true, (vector) {
          expect(vector.length, lessThan(kSpeedLimit));
          ++count;
        });
      } finally {
        reader.cancel();
      }

      expect(count, kOfsNele);
    });
  }, [Chunker.mono, Chunker.extreme]);
}
