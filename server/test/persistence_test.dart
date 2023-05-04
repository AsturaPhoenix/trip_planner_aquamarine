import 'dart:async';

import 'package:aquamarine_server/ofs_client.dart';
import 'package:aquamarine_server/persistence/v1.dart' as v1;
import 'package:aquamarine_server/persistence/v2.dart';
import 'package:aquamarine_server/types.dart';
import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test/data/ofs.nc.dods.dart';
import 'ofs_client_test.dart';
@GenerateNiceMocks([
  MockSpec<FileSystem>(),
  MockSpec<File>(),
  MockSpec<IOSink>(),
])
import 'persistence_test.mocks.dart';

void main() {
  final n6 = SimulationTime(
        SimulationSchedule.nowcast,
        HourUtc(2023, 3, 27, 9),
        6,
      ),
      f48 = SimulationTime(
        SimulationSchedule.forecast,
        HourUtc(2023, 3, 27, 9),
        48,
      );

  test('simulationTime serialization', () {
    expect(
        Persistence.deserializeSimulationTime(
            Persistence.serializeSimulationTime(n6)),
        n6);

    expect(
        Persistence.deserializeSimulationTime(
            Persistence.serializeSimulationTime(f48)),
        f48);
  });

  test('releases mutexes on incomplete read', () async {
    final fileSystem = MockFileSystem();
    final persistence = Persistence(fileSystem);

    final latlngFile = MockFile();
    when(fileSystem.file(any)).thenReturn(latlngFile);
    when(latlngFile.exists()).thenAnswer((_) async => true);
    when(latlngFile.openRead()).thenAnswer((_) async* {
      while (true) {
        yield const [];
      }
    });

    // Make sure that if we cancel the IO stream, we don't hold onto the
    // read lock and can write to the file later.
    final stream = await persistence.readLatLng(Hex32.zero);
    await stream!.listen(null).cancel();

    final latlngWrite = MockIOSink();
    when(latlngFile.openWrite()).thenReturn(latlngWrite);

    await persistence.writeLatLng(Hex32.zero, Stream.empty());
  });

  group('fake file system', () {
    late FileSystem fileSystem;
    late Persistence persistence;
    Future<void> reload() async =>
        persistence = await Persistence.load(fileSystem: fileSystem);

    setUp(() => fileSystem = MemoryFileSystem.test());
    setUp(reload);

    test('latlng that does not exist fails fast', () async {
      expect(await persistence.latlngFileExists(Hex32.zero), false);
      expect(await persistence.readLatLng(Hex32.zero), null);
    });

    test('incomplete latlng write does not cause irreparable corruption',
        () async {
      await expectLater(
        persistence.writeLatLng(Hex32.zero, Stream.error('foo')),
        throwsA('foo'),
      );
      expect(await persistence.latlngFileExists(Hex32.zero), false);
    });

    test('corrupt latlng is deleted on verication', () async {
      await Persistence.latlngFile(persistence.fileSystem, Hex32.zero)
          .writeAsString('foo');
      await persistence.verifyLatLng(hash: Hex32.zero);
      expect(await persistence.latlngFileExists(Hex32.zero), false);
    });

    test('cleanup of corrupt latlng does not delete update', () async {
      // Be aware that this test could be running with a concurrent `verify`
      // from `load`.

      // Write a corrupt latlng file.
      await Persistence.latlngFile(persistence.fileSystem, Hex32.zero)
          .writeAsString('foo');
      // Start a read lock.
      final verify = persistence.verifyLatLng(hash: Hex32.zero);
      expect(persistence.allClosed, false);
      // Start a conflicting write. (This won't be verified.)
      await persistence.writeLatLng(Hex32.zero, Stream.empty());

      await verify;
      expect(await persistence.latlngFileExists(Hex32.zero), true);
    });

    test('uv that does not exist fails fast', () async {
      expect(await persistence.readUv(n6.representedTimestamp), null);
    });

    test('incomplete uv write does not cause irreparable corruption', () async {
      await expectLater(
        persistence.writeUv(
          n6,
          Hex32.zero,
          Stream.error('foo'),
        ),
        throwsA('foo'),
      );
      expect(await persistence.readUv(n6.representedTimestamp), null);
    });

    test('too-short uv file is deleted', () async {
      final t = n6.representedTimestamp;
      final file = Persistence.uvFile(fileSystem, t);
      file.writeAsBytesSync(const [], flush: true);

      await expectLater(persistence.readUv(t), throwsA(isA<FormatException>()));
      expect(file.existsSync(), false);
    });

    test('cleanup of corrupt uv does not delete update', () async {
      await Persistence.uvFile(persistence.fileSystem, n6.representedTimestamp)
          .writeAsString('foo');

      // This starts a read lock. Verification will start asynchronously since
      // it'll need to await that lock, and we'll reserve a conflicting write
      // lock in the meantime.
      //
      // We also need to register the expectLater ahead of time to prevent the
      // exception from being considered uncaught.
      final read = expectLater(
        persistence.readUv(n6.representedTimestamp),
        throwsA(isA<FormatException>()),
      );
      await persistence.writeUv(n6, Hex32.zero, Stream.empty());
      await read;
      expect(await persistence.readUv(n6.representedTimestamp), isNotNull);
    });
  });

  test('migration', () async {
    final simulationTime = SimulationTime(
      SimulationSchedule.nowcast,
      HourUtc(2023, 03, 27, 03),
      1,
    );
    final data = await OfsClient.readUv(Stream.value(kOfsNcDods));
    final fileSystem = MemoryFileSystem();
    final p1 = await v1.Persistence.load(fileSystem);
    await p1.writeLatLng(
        kLatlngHash, OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)));
    await p1.writeUv(
      simulationTime.representedTimestamp,
      simulationTime,
      data.latlngHash,
      data.uv,
    );

    final p2 = await Persistence.load(
        fileSystem: fileSystem, blockUntilVerified: true);

    expect(
      fileSystem.directory(v1.Persistence.latlngDirectory).existsSync(),
      false,
    );
    expect(
      fileSystem.directory(v1.Persistence.uvDirectory).existsSync(),
      false,
    );

    expect(await p2.latlngFileExists(kLatlngHash), true);
    expect(
        await p2.readLatLng(kLatlngHash),
        emitsInOrder([
          emitsInOrder(
            await OfsClient.readLatLng(Stream.value(kOfsLonLatNcDods)).toList(),
          ),
          emitsDone,
        ]));

    final uvReader = (await p2.readUv(simulationTime.representedTimestamp))!;
    expect(await uvReader.readLatLngHash(), data.latlngHash);

    final uvReferenceReader =
        BufferedReader((await OfsClient.readUv(Stream.value(kOfsNcDods))).uv);

    for (int i = 0;
        uvReferenceReader.buffer.isNotEmpty ||
            await uvReferenceReader.moveNext();
        ++i) {
      expect(
        await uvReader.readVectorBytes(i),
        await uvReferenceReader.readBuffer(8),
      );
    }

    await uvReader.close();
  });
}
