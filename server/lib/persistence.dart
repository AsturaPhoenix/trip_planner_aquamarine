import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aquamarine_server_interface/types.dart';
import 'package:mutex/mutex.dart';

import 'ofs_client.dart';
import 'types.dart';

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
  static const root = 'persistence';

  static File _latlngFile(Hex32 hash) => File('$root/latlng/$hash');
  static File _uvFile(HourUtc t) => File('$root/uv/$t');
  static final File _simulationTimesFile = File('$root/simulation_times');

  /// Whether a simulation time should be recorded as a candidate for a future
  /// refresh.
  static bool needsFutureRefresh(SimulationTime s, HourUtc t) =>
      s != OfsClient.simulationTimes(t, SimulationSchedule.nowcast).first;

  static Future<Persistence> load() async {
    // Ensure initial directory structure
    await Directory(root).create();
    await Future.wait([
      Directory('$root/latlng').create(),
      Directory('$root/uv').create(),
    ]);

    Map<HourUtc, SimulationTime> simulationTimes;
    try {
      simulationTimes = await readSimulationTimes();
    } on Exception {
      print('Unable to load simulation times from disk.');
      simulationTimes = {};
    }
    return Persistence(simulationTimes: simulationTimes);
  }

  Persistence({Map<HourUtc, SimulationTime>? simulationTimes})
      : _simulationTimes = simulationTimes ?? {};

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
      return await _latlngFile(hash).exists();
    } finally {
      _releaseMutex(mutex, hash);
    }
  }

  Future<Stream<List<int>>?> readLatLng(Hex32 hash) async {
    final mutex = _getMutex(hash);
    await mutex.acquireRead();

    final file = _latlngFile(hash);

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
      final file = _latlngFile(hash).openWrite();
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
        await _uvFile(t).open(),
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
    Stream<List<int>> stream,
  ) async {
    final mutex = _getMutex(t);
    await mutex.acquireWrite();
    try {
      final file = _uvFile(t).openWrite();
      try {
        file.add(latlngHash.toBytes());
        await file.addStream(stream);
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
      _simulationTimesFile.writeAsString(jsonEncode({
        for (final entry in _simulationTimes.entries)
          entry.key.toString(): {
            'typePrefix': entry.value.schedule.typePrefix,
            'timestamp': entry.value.timestamp.toString(),
            'index': entry.value.index,
          }
      }));

  static Future<Map<HourUtc, SimulationTime>> readSimulationTimes() async {
    final Map<String, dynamic> json =
        jsonDecode(await _simulationTimesFile.readAsString())
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
