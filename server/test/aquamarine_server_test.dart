import 'dart:async';
import 'dart:typed_data';

import 'package:aquamarine_server/aquamarine_server.dart';
import 'package:aquamarine_server/ofs_client.dart';
import 'package:aquamarine_server/persistence/v2.dart';
import 'package:aquamarine_server/types.dart';
import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:file/memory.dart';
import 'package:latlng/latlng.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test/data/ofs.nc.dods.dart';
@GenerateNiceMocks([
  MockSpec<OfsClient>(),
  MockSpec<Persistence>(),
  MockSpec<UvReader>(),
])
import 'aquamarine_server_test.mocks.dart';
import 'ofs_client_test.dart';

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

    Future<void> verifyResponse(UvResponseEntry response) async {
      try {
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
      } finally {
        await response.close();
      }
    }

    Future<void> verifyResponses(
      Stream<UvResponseEntry> stream, {
      int responseCount = 1,
    }) async {
      int responses = 0;

      await for (final response in stream) {
        ++responses;
        await verifyResponse(response);
      }

      expect(responses, responseCount);
    }

    test('fetches everything from a cold start', () async {
      final ofsClient = MockOfsClient();
      final persistence =
          await Persistence.load(fileSystem: MemoryFileSystem.test());

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      when(ofsClient.fetchUv(simulationTime))
          .thenAnswer((_) => OfsClient.readUv(Stream.value(kOfsNcDods)));
      when(ofsClient.fetchLatLng(simulationTime)).thenAnswer(
          (_) async => OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));

      await verifyResponses(server.uv(sampleTime, sampleTime, bounds, .005));
      expect(persistence.allClosed, true);
    });

    test('does not fetch when cache is up to date', () async {
      final ofsClient = MockOfsClient();
      final persistence =
          await Persistence.load(fileSystem: MemoryFileSystem.test());

      final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
      await persistence.writeLatLng(
          kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      await persistence.writeUv(simulationTime, data.latlngHash, data.uv);

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      await verifyResponses(server.uv(sampleTime, sampleTime, bounds, .005));
      verifyZeroInteractions(ofsClient);

      expect(persistence.allClosed, true);
    });

    test('does not fetch when simulation would be in the future', () async {
      final ofsClient = MockOfsClient();
      final persistence =
          await Persistence.load(fileSystem: MemoryFileSystem.test());

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
      final persistence =
          await Persistence.load(fileSystem: MemoryFileSystem.test());

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
      final persistence =
          await Persistence.load(fileSystem: MemoryFileSystem.test());

      final oldSimulationTime = SimulationTime(
          SimulationSchedule.forecast, HourUtc(2023, 03, 26, 21), 1);

      final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
      await persistence.writeLatLng(
          kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      await persistence.writeUv(oldSimulationTime, data.latlngHash, data.uv);

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      await verifyResponses(server.uv(sampleTime, sampleTime, bounds, .005));

      verify(ofsClient.fetchUv(simulationTime));
      // Make sure we never tried to refetch the simulation we already had.
      verifyNever(ofsClient.fetchUv(oldSimulationTime));

      expect(persistence.allClosed, true);
    });

    test('does not block while attempting to fetch a newer simulation',
        () async {
      final ofsClient = MockOfsClient();
      final persistence =
          await Persistence.load(fileSystem: MemoryFileSystem.test());

      final oldSimulationTime = SimulationTime(
          SimulationSchedule.forecast, HourUtc(2023, 03, 26, 21), 1);

      final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
      await persistence.writeLatLng(
          kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      await persistence.writeUv(oldSimulationTime, data.latlngHash, data.uv);

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      when(ofsClient.fetchUv(simulationTime)).thenAnswer((_) async => OfsUvData(
          latlngHash: data.latlngHash,
          uv: StreamController<List<int>>().stream));

      server.uv(sampleTime, sampleTime, bounds, .005).drain();

      await untilCalled(ofsClient.fetchUv(simulationTime));

      // Make sure we can start receiving a new response even while the last one
      // is awaiting a write.
      await verifyResponse(
          await server.uv(sampleTime, sampleTime, bounds, .005).first);
    });

    test('updates response if a newer simulation is available', () async {
      final ofsClient = MockOfsClient();
      final persistence =
          await Persistence.load(fileSystem: MemoryFileSystem.test());

      final oldSimulationTime = SimulationTime(
          SimulationSchedule.forecast, HourUtc(2023, 03, 26, 21), 1);

      final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
      await persistence.writeLatLng(
          kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
      await persistence.writeUv(oldSimulationTime, data.latlngHash, data.uv);

      final server = AquamarineServer(
        ofsClient: ofsClient,
        persistence: persistence,
        clock: () => DateTime.utc(2023, 04, 01),
      );

      final partialData = [
        Uint8List.sublistView(kOfsNcDods, 0, kOfsNcDods.length ~/ 2),
        Uint8List.sublistView(kOfsNcDods, kOfsNcDods.length ~/ 2),
      ];
      final controller = StreamController<List<int>>();
      when(ofsClient.fetchUv(simulationTime))
          .thenAnswer((_) => OfsClient.readUv(controller.stream));
      // We want to make sure the server doesn't block while trying to write
      // UVs, so prime some UV data.
      controller.add(partialData[0]);

      final responses =
          StreamIterator(server.uv(sampleTime, sampleTime, bounds, .005));
      expect(await responses.moveNext(), true);
      verifyResponse(responses.current);

      controller.add(partialData[1]);
      expect(await responses.moveNext(), true);
      verifyResponse(responses.current);

      expect(await responses.moveNext(), false);
      expect(persistence.allClosed, true);
    });

    // latlng and uv refreshes complete whether or not the response stream is
    // cancelled, so we only have to test response cancellation cases that
    // happen while we're reading from disk.

    test('caches even if cancelled while reading latlng file', () async {
      final ofsClient = MockOfsClient();
      final persistence = MockPersistence();
      final uvReader = MockUvReader();

      when(uvReader.simulationTime).thenReturn(simulationTime);
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
      verify(persistence.readLatLng(Hex32.zero));

      await expectLater(server.uv(sampleTime, sampleTime, bounds, .005),
          emitsInOrder([isA<UvResponseEntry>(), emitsDone]));
      verifyNever(persistence.readLatLng(Hex32.zero));
    });
  });
}
