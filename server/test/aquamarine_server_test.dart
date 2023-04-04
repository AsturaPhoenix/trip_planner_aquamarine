import 'dart:io';
import 'dart:typed_data';

import 'package:aquamarine_server/aquamarine_server.dart';
import 'package:aquamarine_server/ofs_client.dart';
import 'package:aquamarine_server/persistence.dart';
import 'package:aquamarine_server/types.dart';
import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:latlng/latlng.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test/data/ofs.nc.dods.dart';
@GenerateNiceMocks([MockSpec<OfsClient>()])
import 'aquamarine_server_test.mocks.dart';
import 'ofs_client_test.dart';

class FakeUvReader implements UvReader {
  FakeUvReader(this.data);
  final Uint8List data;

  @override
  Future<void> close() async {}

  @override
  Future<Hex32> readLatLngHash() async => Hex32.fromBytes(data);

  @override
  Future<Uint8List> readVectorBytes(int index) async {
    final offset = UvReader.vectorByteIndex(index);
    return data.sublist(offset, offset + 8);
  }
}

class FakePersistence extends Fake implements Persistence {
  Map<HourUtc, SimulationTime> simulationTimes = {};
  Map<Hex32, List<List<int>>> latlngs = {};
  Map<HourUtc, Uint8List> uvs = {};

  @override
  SimulationTime? simulationTime(HourUtc t) => simulationTimes[t];

  @override
  Future<bool> latlngFileExists(Hex32 hash) async => latlngs.containsKey(hash);

  @override
  Future<Stream<List<int>>?> readLatLng(Hex32 hash) async {
    final data = latlngs[hash];
    return data == null ? null : Stream.fromIterable(data);
  }

  @override
  Future<void> writeLatLng(Hex32 hash, Stream<List<int>> stream) async {
    latlngs[hash] = await stream.toList();
  }

  @override
  Future<UvReader> readUv(HourUtc t) async {
    final data = uvs[t];
    if (data == null) {
      throw FileSystemException('thrown from FakePersistence');
    } else {
      return FakeUvReader(data);
    }
  }

  @override
  Future<void> writeUv(HourUtc t, SimulationTime s, Hex32 latlngHash,
      Stream<List<int>> stream) async {
    final builder = BytesBuilder(copy: false)..add(latlngHash.toBytes());
    await stream.forEach(builder.add);
    uvs[t] = builder.takeBytes();

    if (Persistence.needsFutureRefresh(s, t)) {
      simulationTimes[t] = s;
    } else {
      simulationTimes.remove(t);
    }
  }
}

void main() {
  final simulationTime = SimulationTime(
    SimulationSchedule.nowcast,
    HourUtc(2023, 03, 27, 03),
    1,
  );
  final HourUtc sampleTime = HourUtc(2023, 03, 26, 22);

  group('uv', () {
    final bounds = LatLngBounds(
      southwest: const LatLng(37.8, -122.5),
      northeast: const LatLng(37.9, -122.4),
    );

    Future<void> verifyResponse(Stream<UvResponseEntry> stream) async {
      final response = await stream.toList();

      expect(response.single.t, sampleTime);
      expect(response.single.latLngHash, kLatlngHash);

      int count = 0;
      final reader = BufferedReader(response.single.uv);
      try {
        await readVectors(reader, () => true, (vector) {
          expect(vector.length, lessThan(kSpeedLimit));
          ++count;
        });
      } finally {
        reader.cancel();
      }

      expect(count, inInclusiveRange(100, 1000));
    }

    test('fetches everything from a cold start', () async {
      final ofsClient = MockOfsClient();
      final persistence = FakePersistence();

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      when(ofsClient.fetchUv(simulationTime))
          .thenAnswer((_) => OfsClient.readUv(Stream.value(kOfsNcDods)));
      when(ofsClient.fetchLatLng(simulationTime)).thenAnswer(
          (_) async => OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));

      await verifyResponse(server.uv(sampleTime, sampleTime, bounds, .005));
    });

    test('does not fetch when cache is up to date', () async {
      final ofsClient = MockOfsClient();
      final persistence = FakePersistence();

      final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
      await persistence.writeLatLng(
          kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      await persistence.writeUv(
          sampleTime, simulationTime, data.latlngHash, data.uv);

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      await verifyResponse(server.uv(sampleTime, sampleTime, bounds, .005));
      verifyZeroInteractions(ofsClient);
    });

    test('does not fetch when simulation would be in the future', () async {
      final ofsClient = MockOfsClient();
      final persistence = FakePersistence();

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      final future = HourUtc(2038, 01, 19, 04);

      final response = await server.uv(future, future, bounds, .005).single;
      expect(response.t, future);
      expect(response.latLngHash, Hex32.zero);
      expect(response.uv, emitsDone);
      verifyZeroInteractions(ofsClient);
    });

    test('does not fetch when simulation would be too old', () async {
      final ofsClient = MockOfsClient();
      final persistence = FakePersistence();

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      final past = HourUtc(1955, 11, 05, 12);

      final response = await server.uv(past, past, bounds, .005).single;
      expect(response.t, past);
      expect(response.latLngHash, Hex32.zero);
      expect(response.uv, emitsDone);
      verifyZeroInteractions(ofsClient);
    });

    test('attempts to fetch if a newer simulation might be available',
        () async {
      final ofsClient = MockOfsClient();
      final persistence = FakePersistence();

      final oldSimulationTime = SimulationTime(
          SimulationSchedule.forecast, HourUtc(2023, 03, 26, 21), 1);

      final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
      await persistence.writeLatLng(
          kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      await persistence.writeUv(
          sampleTime, oldSimulationTime, data.latlngHash, data.uv);

      when(ofsClient.fetchUv(oldSimulationTime)).thenAnswer((_) async => null);

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      await verifyResponse(server.uv(sampleTime, sampleTime, bounds, .005));

      verify(ofsClient.fetchUv(simulationTime));
      // Make sure we never tried to refetch the simulation we already had.
      verifyNever(ofsClient.fetchUv(oldSimulationTime));
    });
  });
}
