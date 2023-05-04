import 'dart:convert';
import 'dart:typed_data';

import 'package:aquamarine_server_interface/types.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mutex/mutex.dart';

import '../ofs_client.dart';
import '../types.dart';

class UvReader {
  static int vectorByteIndex(int index) => 4 + 8 * index;

  UvReader(this._file, this._close);

  final RandomAccessFile _file;
  final void Function() _close;

  Future<void> close() async {
    await _file.close();
    _close();
  }

  /// This must be the first read performed on the file, as it does not set the
  /// position to 0 explicitly.
  Future<Hex32> readLatLngHash() async => Hex32.fromBytes(await _file.read(4));

  Future<Uint8List> readVectorBytes(int index) async {
    await _file.setPosition(vectorByteIndex(index));
    return _file.read(8);
  }
}

class Persistence {
  static const root = 'persistence',
      latlngDirectory = '$root/latlng',
      uvDirectory = '$root/uv';

  static File latlngFile(FileSystem fileSystem, Hex32 hash) =>
      fileSystem.file('$latlngDirectory/$hash');
  static File uvFile(FileSystem fileSystem, HourUtc t) =>
      fileSystem.file('$uvDirectory/$t');
  static File simulationTimesFile(FileSystem fileSystem) =>
      fileSystem.file('$root/simulation_times');

  /// Whether a simulation time should be recorded as a candidate for a future
  /// refresh.
  static bool needsFutureRefresh(SimulationTime s, HourUtc t) =>
      s != OfsClient.simulationTimes(t, SimulationSchedule.nowcast).first;

  static Future<Persistence> load([
    FileSystem fileSystem = const LocalFileSystem(),
  ]) async {
    // Ensure initial directory structure
    await fileSystem.directory(root).create();
    await Future.wait([
      fileSystem.directory(latlngDirectory).create(),
      fileSystem.directory(uvDirectory).create(),
    ]);

    Map<HourUtc, SimulationTime> simulationTimes;
    try {
      simulationTimes = await readSimulationTimes(fileSystem);
    } on Exception {
      print('Unable to load simulation times from disk.');
      simulationTimes = {};
    }
    return Persistence(fileSystem, simulationTimes: simulationTimes);
  }

  Persistence(this.fileSystem, {Map<HourUtc, SimulationTime>? simulationTimes})
      : _simulationTimes = simulationTimes ?? {};

  final FileSystem fileSystem;
  final Map<HourUtc, SimulationTime> _simulationTimes;
  final _mutexes = <Object, ReadWriteMutex>{};

  ReadWriteMutex _getMutex(Object key) => _mutexes[key] ??= ReadWriteMutex();
  void _releaseMutex(ReadWriteMutex mutex, Object key) {
    mutex.release();
    if (!mutex.isLocked) {
      final removed = _mutexes.remove(key);
      assert(mutex == removed);
    }
  }

  /// The simulation timestamp upon which date for time [t] is based, or null if
  /// they were based on the latest historical nowcast to include them. A
  /// refresh may be warranted if this is nonnull and a newer simulation is
  /// available.
  SimulationTime? simulationTime(HourUtc t) => _simulationTimes[t];

  Future<bool> latlngFileExists(Hex32 hash) async {
    final mutex = _getMutex(hash);
    await mutex.acquireRead();
    try {
      // Although this await could syntactically be omitted, it affects the
      // timing of the mutex release.
      return await latlngFile(fileSystem, hash).exists();
    } finally {
      _releaseMutex(mutex, hash);
    }
  }

  Future<Stream<List<int>>?> readLatLng(Hex32 hash) async {
    final mutex = _getMutex(hash);
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
          _releaseMutex(mutex, hash);
        }
      }();
    } else {
      _releaseMutex(mutex, hash);
      return null;
    }
  }

  Future<void> writeLatLng(Hex32 hash, Stream<List<int>> stream) async {
    final mutex = _getMutex(hash);
    await mutex.acquireWrite();

    try {
      final file = latlngFile(fileSystem, hash).openWrite();
      try {
        await file.addStream(stream);
        await file.flush();
      } finally {
        await file.close();
      }
    } finally {
      _releaseMutex(mutex, hash);
    }
  }

  Future<UvReader> readUv(HourUtc t) async {
    final mutex = _getMutex(t);
    await mutex.acquireRead();
    try {
      return UvReader(
        await uvFile(fileSystem, t).open(),
        () => _releaseMutex(mutex, t),
      );
    } on Object {
      _releaseMutex(mutex, t);
      rethrow;
    }
  }

  Future<void> writeUv(
    HourUtc t,
    SimulationTime s,
    Hex32 latlngHash,
    Stream<List<int>> vectorBytes,
  ) async {
    final mutex = _getMutex(t);
    await mutex.acquireWrite();
    try {
      final file = uvFile(fileSystem, t).openWrite();
      try {
        file.add(latlngHash.toBytes());
        await file.addStream(vectorBytes);
        await file.flush();
      } finally {
        await file.close();
      }

      if (needsFutureRefresh(s, t)) {
        _simulationTimes[t] = s;
      } else {
        _simulationTimes.remove(t);
      }
      writeSimulationTimes();
    } finally {
      _releaseMutex(mutex, t);
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
}
