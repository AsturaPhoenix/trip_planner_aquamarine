import 'dart:async';
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
import 'package:mutex/mutex.dart';
import 'package:test/test.dart';

import '../../test/data/ofs.nc.dods.dart';
@GenerateNiceMocks([
  MockSpec<OfsClient>(),
  MockSpec<Persistence>(),
  MockSpec<UvReader>(),
])
import 'aquamarine_server_test.mocks.dart';
import 'ofs_client_test.dart';

class FakeUvReader implements UvReader {
  FakeUvReader(this.data, this._close);
  final Uint8List data;
  final void Function() _close;

  @override
  Future<void> close() async => _close();

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
  Map<Object, ReadWriteMutex> mutexes = {};

  bool get allClosed => !mutexes.values.any((mutex) => mutex.isLocked);

  @override
  SimulationTime? simulationTime(HourUtc t) => simulationTimes[t];

  @override
  Future<bool> latlngFileExists(Hex32 hash) async => latlngs.containsKey(hash);

  @override
  Future<Stream<List<int>>?> readLatLng(Hex32 hash) =>
      (mutexes[hash] ?? ReadWriteMutex()).protectRead(() async {
        final data = latlngs[hash];
        return data == null ? null : Stream.fromIterable(data);
      });

  @override
  Future<void> writeLatLng(Hex32 hash, Stream<List<int>> stream) =>
      (mutexes[hash] ?? ReadWriteMutex())
          .protectWrite(() async => latlngs[hash] = await stream.toList());

  @override
  Future<UvReader> readUv(HourUtc t) async {
    final mutex = mutexes[t] ?? ReadWriteMutex();
    await mutex.acquireRead();
    final data = uvs[t];
    if (data == null) {
      mutex.release();
      throw FileSystemException('thrown from FakePersistence', t.toString());
    } else {
      return FakeUvReader(data, mutex.release);
    }
  }

  @override
  Future<void> writeUv(HourUtc t, SimulationTime s, Hex32 latlngHash,
          Stream<List<int>> stream) =>
      (mutexes[t] ?? ReadWriteMutex()).protectWrite(() async {
        final builder = BytesBuilder(copy: false)..add(latlngHash.toBytes());
        await stream.forEach(builder.add);
        uvs[t] = builder.takeBytes();

        if (Persistence.needsFutureRefresh(s, t)) {
          simulationTimes[t] = s;
        } else {
          simulationTimes.remove(t);
        }
      });
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

    Future<void> verifyResponse(
      Stream<UvResponseEntry> stream, {
      int responseCount = 1,
    }) async {
      final responses = await stream.toList();
      expect(responses.length, responseCount);

      for (final response in responses) {
        expect(response.t, sampleTime);
        expect(response.latLngHash, kLatlngHash);

        int vectorCount = 0;
        final reader = BufferedReader(response.uv);
        try {
          await readVectors(reader, () => true, (vector) {
            expect(vector.length, lessThan(kSpeedLimit));
            ++vectorCount;
          });
        } finally {
          reader.cancel();
        }

        expect(vectorCount, inInclusiveRange(100, 1000));
      }
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

      expect(persistence.allClosed, true);
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

      expect(persistence.allClosed, true);
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

      expect(persistence.allClosed, true);
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

      expect(persistence.allClosed, true);
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

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      await verifyResponse(server.uv(sampleTime, sampleTime, bounds, .005));

      verify(ofsClient.fetchUv(simulationTime));
      // Make sure we never tried to refetch the simulation we already had.
      verifyNever(ofsClient.fetchUv(oldSimulationTime));

      expect(persistence.allClosed, true);
    });

    test('updates response if a newer simulation is available', () async {
      final ofsClient = MockOfsClient();
      final persistence = FakePersistence();

      final oldSimulationTime = SimulationTime(
          SimulationSchedule.forecast, HourUtc(2023, 03, 26, 21), 1);

      final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
      await persistence.writeLatLng(
          kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      await persistence.writeUv(
          sampleTime, oldSimulationTime, data.latlngHash, data.uv);

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      when(ofsClient.fetchUv(simulationTime))
          .thenAnswer((_) => OfsClient.readUv(Stream.value(kOfsNcDods)));

      await verifyResponse(
        server.uv(sampleTime, sampleTime, bounds, .005),
        responseCount: 2,
      );

      expect(persistence.allClosed, true);
    });

    // latlng and uv refreshes complete whether or not the response stream is
    // cancelled, so we only have to test response cancellation cases that
    // happen while we're reading from disk. On the other hand, we will want to
    // make sure we clean up if the fetches themselves are interrupted.

    test('cleans up if cancelled while reading latlng file', () async {
      final ofsClient = MockOfsClient();
      final persistence = MockPersistence();
      final uvReader = MockUvReader();

      when(persistence.readUv(sampleTime)).thenAnswer((_) async => uvReader);
      when(uvReader.readLatLngHash()).thenAnswer((_) async => Hex32.zero);
      when(persistence.readLatLng(Hex32.zero))
          .thenAnswer((_) async => Stream.value(const <int>[]));

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      final subscription = server
          .uv(sampleTime, sampleTime, bounds, .005)
          .listen((_) => fail('Unexpected response emission'));

      await untilCalled(persistence.readLatLng(Hex32.zero));
      await subscription.cancel();
      verify(uvReader.close());
    });
  });
}
