import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';

import '../mutex.dart';
import '../ofs_client.dart';
import '../types.dart';
import 'persistence.dart' as base;
import 'v1.dart' as v1;

class UvReader implements base.UvReader {
  static int vectorByteIndex(int index) => 4 + 8 * index;

  UvReader._(this.simulationTime, this._file, this._close);

  @override
  final SimulationTime simulationTime;
  final RandomAccessFile _file;
  final void Function() _close;

  @override
  Future<void> close() async {
    await _file.close();
    _close();
  }

  @override
  Future<Hex32> readLatLngHash() async {
    await _file.setPosition(0);
    return Hex32.fromBytes(await _file.read(4));
  }

  @override
  Future<Uint8List> readVectorBytes(int index) async {
    await _file.setPosition(vectorByteIndex(index));
    return _file.read(8);
  }
}

class Persistence implements base.Persistence {
  static final log = Logger('Persistence v2');

  static const root = 'persistence/v2',
      latlngDirectory = '$root/latlng',
      uvDirectory = '$root/uv';

  static File latlngFile(FileSystem fileSystem, Hex32 hash) =>
      fileSystem.file('$latlngDirectory/$hash');
  static File uvFile(FileSystem fileSystem, HourUtc t) =>
      fileSystem.file('$uvDirectory/$t');
  static File simulationTimesFile(FileSystem fileSystem) =>
      fileSystem.file('$root/simulation_times');

  static Future<Persistence> load({
    FileSystem fileSystem = const LocalFileSystem(),
    bool blockUntilVerified = false,
  }) async {
    // Ensure initial directory structure
    await fileSystem.directory(root).create(recursive: true);
    await Future.wait([
      fileSystem.directory(latlngDirectory).create(),
      fileSystem.directory(uvDirectory).create(),
    ]);

    Map<HourUtc, SimulationTime> simulationTimes;
    try {
      simulationTimes = await readSimulationTimes(fileSystem);
    } on Object {
      log.warning('Unable to load simulation times from disk.');
      simulationTimes = {};
    }
    final persistence =
        Persistence(fileSystem, simulationTimes: simulationTimes);
    // Kick off migration and latlng verification if needed.
    final housekeeping = () async {
      await persistence.migrate();
      final verify = <Future<void>>[];
      await for (final latlng in fileSystem.directory(latlngDirectory).list()) {
        verify.add(persistence.verifyLatLng(file: latlng as File));
      }
      await Future.wait(verify);
      log.info('Housekeeping complete.');
    }();
    if (blockUntilVerified) {
      await housekeeping;
    }
    return persistence;
  }

  static SimulationTime deserializeSimulationTime(Uint8List bytes) =>
      SimulationTime(
          bytes[0] >= 128
              ? SimulationSchedule.forecast
              : SimulationSchedule.nowcast,
          HourUtc.fromHoursSinceEpoch(ByteData.sublistView(bytes).getInt32(1)),
          bytes[0] & 127);

  static Uint8List serializeSimulationTime(SimulationTime s) {
    final bytes = Uint8List(5);
    assert(s.index < 128);
    bytes[0] = s.index | (s.schedule == SimulationSchedule.forecast ? 128 : 0);
    ByteData.sublistView(bytes).setInt32(1, s.timestamp.hoursSinceEpoch);
    return bytes;
  }

  Persistence(this.fileSystem, {Map<HourUtc, SimulationTime>? simulationTimes})
      : _simulationTimes = simulationTimes ?? {};

  final FileSystem fileSystem;
  final Map<HourUtc, SimulationTime> _simulationTimes;
  final _mutexes = MutexMap();

  bool get allClosed => _mutexes.isEmpty;

  @override
  Future<bool> latlngFileExists(Hex32 hash) async {
    final mutex = _mutexes[hash];
    await mutex.acquireRead();
    try {
      // Although this await could syntactically be omitted, it affects the
      // timing of the mutex release.
      return await latlngFile(fileSystem, hash).exists();
    } finally {
      mutex.release();
    }
  }

  /// Checks to make sure that the contents of a latlng file match the hash.
  /// Since the hash is computed from the lonc[], latc[] uninterleaved data
  /// optimized for hash computation during fetches while latlngs are stored
  /// in a (lat, lng)[] interleaved form optimized for client use, this is
  /// non-trivially expensive, but also since latlng writes are not expected to
  /// happen more than once in the lifetime of a persistence version, this can
  /// happen on load, to guard against a server terminated during write. (An
  /// interrupted latlng fetch should delete the file.)
  ///
  /// At least one of [file] or [hash] must be provided. If both are provided,
  /// the filename is not checked to be identical to the hash.
  ///
  /// If the contents of the file do not match the hash, the file is deleted.
  Future<void> verifyLatLng({File? file, Hex32? hash}) async {
    log.info('Verifying latlng $file');
    hash ??= Hex32.parse(basename(file!.path));
    file ??= latlngFile(fileSystem, hash);

    final mutex = _mutexes[hash];
    await mutex.acquireRead();
    try {
      if (!await file.exists()) return;

      Future<Hex32?> computeHash() async {
        final observedHash = AccumulatorSink<Digest>();
        final hashSink = md5.startChunkedConversion(observedHash);

        // The hash was computed from the dods download (lon[], lat[]), so we
        // need to undo the interleaving for verification.

        final lats = BytesBuilder(copy: false);
        try {
          await for (final bytes
              in BufferedReader(file!.openRead()).withAlignment(8)) {
            for (int i = 0; i < bytes.length; i += 8) {
              lats.add(bytes.sublist(i, i + 4));
              hashSink.add(bytes.sublist(i + 4, i + 8));
            }
          }
        } on Object {
          return null;
        }
        hashSink
          ..add(lats.takeBytes())
          ..close();

        return Hex32.fromBytes(observedHash.events.single.bytes);
      }

      if (hash != await computeHash()) {
        mutex.transientRelease();
        if (await mutex.acquireWrite()) {
          log.warning('Deleting corrupt latlng file $hash');
          await file.delete();
        }
      }
    } finally {
      mutex.release();
    }
  }

  /// Reads the latlng file for a given [hash]. The file is not verified since
  /// latlng updates are not expected to happen like ever; verification is
  /// performed during loading.
  @override
  Future<Stream<List<int>>?> readLatLng(Hex32 hash) async {
    final mutex = _mutexes[hash];
    await mutex.acquireRead();

    final file = latlngFile(fileSystem, hash);

    // We need to know whether the file exists to set an appropriate status code
    // for the HTTP response. If we were to rely on openRead, we wouldn't
    // necessarily know what the response should be until we already started
    // trying to read the body. While theoretically we could still set the
    // response code since we would throw an exception before we sent anything
    // for the response, doing it that way is hardly clean and doesn't fit well
    // into the Shelf API.
    if (await file.exists()) {
      return () async* {
        try {
          yield* file.openRead();
        } finally {
          mutex.release();
        }
      }();
    } else {
      mutex.release();
      return null;
    }
  }

  @override
  Future<void> writeLatLng(Hex32 hash, Stream<List<int>> stream) async {
    final mutex = _mutexes[hash];
    await mutex.acquireWrite();

    try {
      final file = latlngFile(fileSystem, hash);
      final sink = file.openWrite();
      try {
        await sink.addStream(stream);
        await sink.flush();
      } on Object {
        await sink.close();
        await file.delete();
        rethrow;
      }
      await sink.close();
    } finally {
      mutex.release();
    }
  }

  /// Creates a [UvReader] for the uv data for hour [t]. This reader must be
  /// closed by the caller.
  ///
  /// A [SimulationTime] recorded at the end of the file is verified to guard
  /// against interrupted fetches and writes. If any read operation fails or the
  /// simulation time doesn't make sense, the future completes with an exception
  /// and the file is deleted. If the simulation time does not match metadata,
  /// it is assumed that the metadata read was corrupt, and the metadata are
  /// updated.
  @override
  Future<UvReader?> readUv(HourUtc t) async {
    final mutex = _mutexes[t];
    await mutex.acquireRead();

    final file = uvFile(fileSystem, t);
    final RandomAccessFile raf;
    try {
      raf = await file.open();
    } catch (e) {
      mutex.release();
      if (e is FileSystemException) {
        return null;
      } else {
        rethrow;
      }
    }

    try {
      final length = await raf.length();
      if (length < 9) {
        throw FormatException(
            'uv files should contain at minimum a 4-byte latlng hash and a '
            '5-byte simulation time.');
      }

      await raf.setPosition(length - 5);
      final s = Persistence.deserializeSimulationTime(await raf.read(5));
      if (s.representedTimestamp == t) {
        final expectedSimulationTime =
            OfsClient.needsFutureRefresh(s) ? s : null;
        if (_simulationTimes[t] != expectedSimulationTime) {
          log.warning(
              'Metadata corruption; backfilling simulation time $s for $t');
          if (expectedSimulationTime != null) {
            _simulationTimes[t] = expectedSimulationTime;
          } else {
            _simulationTimes.remove(t);
          }
        }

        return UvReader._(
            _simulationTimes[t] ?? OfsClient.finalSimulationTime(t),
            raf,
            mutex.release);
      } else {
        throw FormatException('uv corruption; invalid simulation time.');
      }
    } on Object {
      try {
        await raf.close();
        mutex.transientRelease();
        if (await mutex.acquireWrite()) {
          log.warning('Deleting corrupt uv file $t');
          await file.delete();
        }
      } finally {
        mutex.release();
      }
      rethrow;
    }
  }

  @override
  Future<void> writeUv(
    SimulationTime s,
    Hex32 latlngHash,
    Stream<List<int>> vectorBytes,
  ) async {
    final t = s.representedTimestamp;
    final mutex = _mutexes[t];
    await mutex.acquireWrite();
    try {
      final file = uvFile(fileSystem, t);
      final sink = file.openWrite();
      try {
        sink.add(latlngHash.toBytes());
        await sink.addStream(vectorBytes);

        // For integrity verification, echo the simulation time into the file.
        sink.add(serializeSimulationTime(s));

        await sink.flush();
      } on Object {
        await sink.close();
        await file.delete();
        rethrow;
      }
      await sink.close();

      if (OfsClient.needsFutureRefresh(s)) {
        _simulationTimes[t] = s;
      } else {
        _simulationTimes.remove(t);
      }
      writeSimulationTimes();
    } finally {
      mutex.release();
    }
  }

  Future<void> writeSimulationTimes() =>
      simulationTimesFile(fileSystem).writeAsString(jsonEncode({
        for (final entry in _simulationTimes.entries)
          entry.key.toString(): {
            'typePrefix': entry.value.schedule.typePrefix,
            'timestamp': entry.value.timestamp.toString(),
            'index': entry.value.index,
          }
      }));

  static Future<Map<HourUtc, SimulationTime>> readSimulationTimes(
      FileSystem fileSystem) async {
    final Map<String, dynamic> json =
        jsonDecode(await simulationTimesFile(fileSystem).readAsString())
            as Map<String, dynamic>;

    return {
      for (final entry in json.entries)
        HourUtc.fromDateTime(DateTime.parse(entry.key)): SimulationTime(
          const {
            'f': SimulationSchedule.forecast,
            'n': SimulationSchedule.nowcast,
          }[entry.value['typePrefix']]!,
          HourUtc.fromDateTime(
              DateTime.parse(entry.value['timestamp'] as String)),
          entry.value['index'] as int,
        )
    };
  }

  Future<void> migrate() async {
    v1.Persistence? p1;
    Future<v1.Persistence> loadV1() => v1.Persistence.load(fileSystem);

    {
      final latlng = fileSystem.directory(v1.Persistence.latlngDirectory);
      if (await latlng.exists()) {
        log.info('Migrating latlng from v1');
        p1 = await loadV1();
        await for (final file in latlng.list()) {
          log.info('Migrating $file');
          try {
            final hash = Hex32.parse(basename(file.path));
            await writeLatLng(hash, (await p1.readLatLng(hash))!);
            await file.delete();
          } catch (e, s) {
            log.warning('Error while migrating $file', e, s);
          }
        }
        try {
          await latlng.delete();
        } catch (e, s) {
          log.warning('Could not delete $latlng', e, s);
        }
      }
    }
    {
      final uv = fileSystem.directory(v1.Persistence.uvDirectory);
      if (await uv.exists()) {
        log.info('Migrating uv from v1');
        p1 ??= await loadV1();
        await for (final file in uv.list()) {
          log.info('Migrating $file');
          try {
            final t = HourUtc.fromDateTime(DateTime.parse(basename(file.path)));
            final uv = await p1.readUv(t);
            try {
              await writeUv(
                p1.simulationTime(t) ??
                    OfsClient.samplesCoveringTime(t, SimulationSchedule.nowcast)
                        .first,
                await uv.readLatLngHash(),
                v1.Persistence.uvFile(fileSystem, t).openRead(4),
              );
            } finally {
              await uv.close();
            }
            await file.delete();
          } catch (e, s) {
            log.warning('Error while migrating $file', e, s);
          }
        }
        try {
          await uv.delete();
        } catch (e, s) {
          log.warning('Could not delete $uv', e, s);
        }
      }
    }
  }
}
