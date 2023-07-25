import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'types.dart';

/// The data from a DODS lonc-latc-u-v download, reorganized for caching.
///
/// uv, received as [...u][...v], becomes [...(u, v)].
class LatLngUv {
  LatLngUv._({required this.latlngHash, required this.uv, required this.close});
  final Hex32 latlngHash;
  final Stream<List<int>> uv;
  final void Function() close;
}

class ResourceException implements HttpException {
  ResourceException(this.uri, this.statusCode);
  @override
  final Uri uri;
  final int statusCode;

  @override
  String get message => '$uri returned status code $statusCode';

  @override
  String toString() => message;
}

class OfsClient {
  static final log = Logger('OfsClient');

  /// Determines the simulation runs that would cover the target time [t].
  static Iterable<SimulationTime> samplesCoveringTime(
    HourUtc t,
    SimulationSchedule schedule,
  ) sync* {
    final baseHour = t + schedule.referenceHour;
    for (int i = (t.hour - SimulationSchedule.firstHour) %
            SimulationSchedule.intervalHours;
        i <= schedule.coverageHours;
        i += SimulationSchedule.intervalHours) {
      yield SimulationTime(schedule, baseHour - i, i);
    }
  }

  static SimulationTime finalSimulationTime(HourUtc t) =>
      samplesCoveringTime(t, SimulationSchedule.nowcast).first;

  /// Whether a simulation time should be recorded as a candidate for a future
  /// refresh.
  static bool needsFutureRefresh(SimulationTime s) =>
      s != finalSimulationTime(s.representedTimestamp);

  /// Enumerates the [SimulationTime]s produced by a simulation run at time [t].
  static Iterable<SimulationTime> samplesForRun(
      HourUtc t, SimulationSchedule schedule) sync* {
    if ((t.hour - SimulationSchedule.firstHour) %
            SimulationSchedule.intervalHours !=
        0) {
      throw ArgumentError('No simulation run for schedule at time t.');
    }

    for (int i = 0; i <= schedule.coverageHours; ++i) {
      yield SimulationTime(schedule, t, i);
    }
  }

  static Uri resourceUri({
    required SimulationTime simulationTime,
    required List<String> query,
  }) {
    final t = simulationTime.timestamp;
    // These files only go back a month, so no need to pad for 999 and earlier.
    final yyyy = t.year.toString(),
        mm = t.month.toString().padLeft(2, '0'),
        dd = t.day.toString().padLeft(2, '0'),
        hh = t.hour.toString().padLeft(2, '0'),
        iii = simulationTime.index.toString().padLeft(3, '0');
    final typePrefix = simulationTime.schedule.typePrefix;

    return Uri(
      scheme: 'https',
      host: 'opendap.co-ops.nos.noaa.gov',
      pathSegments: [
        'thredds',
        'dodsC',
        'NOAA',
        'SFBOFS',
        'MODELS',
        yyyy,
        mm,
        dd,
        'nos.sfbofs.fields.$typePrefix$iii.$yyyy$mm$dd.t${hh}z.nc.dods',
      ],
      query: query.join(','),
    );
  }

  static final dataMarker = ascii.encode('Data:\n');

  static Future<int> _readVectorSize(BufferedReader reader) async {
    final data = ByteData.sublistView(await reader.readBuffer(8));

    final int size = data.getUint32(0);
    // Arrays are preceded by two identical sizes. Not sure why.
    if (size != data.getUint32(4)) {
      throw FormatException('Unexpected difference between size blocks.');
    }
    return size;
  }

  static void interleaveLatLng(
    BytesBuilder out,
    Uint8List lon,
    Uint8List lat,
  ) =>
      out
        ..add(lat)
        ..add(lon);

  static void interleaveUv(
    BytesBuilder out,
    Uint8List u,
    Uint8List v,
  ) =>
      out
        ..add(u)
        ..add(v);

  static Stream<Uint8List> interleave2x32(
    BufferedReader reader,
    void Function(BytesBuilder out, Uint8List a, Uint8List b) combiner,
  ) async* {
    final size = await _readVectorSize(reader);
    final v0 = await reader.readBuffer(size * 4);

    if (await _readVectorSize(reader) != size) {
      throw FormatException('Unequal number of values.');
    }

    for (int i = 0; i <= v0.length - 4;) {
      while (reader.buffer.length < 4) {
        await reader.requireNext();
      }

      final v1 = reader.buffer.takeBytes();
      final out = BytesBuilder();
      int j;
      for (j = 0; i <= v0.length - 4 && j <= v1.length - 4; i += 4, j += 4) {
        combiner(out, v0.sublist(i, i + 4), v1.sublist(j, j + 4));
      }

      yield out.takeBytes();

      reader.buffer.add(v1.sublist(j));
    }
  }

  /// Reads latlngs for disk caching.
  /// [...lonc][...latc] becomes [...(latc, lonc)].
  static Stream<Uint8List> readLatLng(Stream<List<int>> stream) async* {
    final reader = BufferedReader(stream);
    try {
      await reader.consumeUntil(dataMarker);
      yield* interleave2x32(reader, interleaveLatLng);
      await reader.requireEnd();
    } finally {
      reader.cancel();
    }
  }

  static Future<void> _pipeBytes(
      BufferedReader reader, Sink<List<int>> sink, int size) async {
    int remaining = size;
    void handleBuffer() {
      final int read = min(remaining, reader.buffer.length);
      final data = reader.buffer.takeBytes();
      sink.add(data.sublist(0, read));
      reader.buffer.add(data.sublist(read));
      remaining -= read;
    }

    handleBuffer();

    while (remaining > 0) {
      await reader.requireNext();
      handleBuffer();
    }
  }

  /// Hashes the raw [...lonc][...latc] data from a DODS download.
  static Future<Hex32> _hashLatLng(BufferedReader reader) async {
    final hash = AccumulatorSink<Digest>();
    final bytes = md5.startChunkedConversion(hash);

    final size = await _readVectorSize(reader);
    await _pipeBytes(reader, bytes, 4 * size);

    if (await _readVectorSize(reader) != size) {
      throw FormatException('Unequal number of values.');
    }
    await _pipeBytes(reader, bytes, 4 * size);

    bytes.close();
    return Hex32.fromBytes(hash.events.single.bytes);
  }

  /// Reads combined latlng and uv data. The returned object must be closed.
  static Future<LatLngUv> readLatLngUv(Stream<List<int>> stream) async {
    final reader = BufferedReader(stream);
    try {
      await reader.consumeUntil(dataMarker);

      return LatLngUv._(
        latlngHash: await _hashLatLng(reader),
        uv: interleave2x32(reader, interleaveUv),
        close: reader.cancel,
      );
    } on Object {
      reader.cancel();
      rethrow;
    }
  }

  static Stream<List<int>> readUv(Stream<List<int>> stream) async* {
    final reader = BufferedReader(stream);
    try {
      await reader.consumeUntil(dataMarker);
      yield* interleave2x32(reader, interleaveUv);
    } finally {
      reader.cancel();
    }
  }

  OfsClient({required this.client});
  final http.Client client;

  /// Throws [http.ClientException] and [ResourceException].
  Future<http.ByteStream> fetchResource(
      SimulationTime s, List<String> query) async {
    final request = resourceUri(simulationTime: s, query: query);
    log.info('get $request');
    final response = await client.send(http.Request('get', request));

    if (response.statusCode == HttpStatus.ok) {
      return response.stream;
    } else {
      throw ResourceException(request, response.statusCode);
    }
  }

  /// Throws [http.ClientException] and [ResourceException].
  Future<Stream<Uint8List>> fetchLatLng(SimulationTime s) async {
    final file = await fetchResource(s, const [
      'lonc',
      'latc',
    ]);
    return readLatLng(file);
  }

  /// Throws [http.ClientException] and [ResourceException].
  Future<LatLngUv> fetchLatLngUv(SimulationTime s) async {
    final file = await fetchResource(s, const [
      'lonc',
      'latc',
      'u[0][0]',
      'v[0][0]',
    ]);
    return readLatLngUv(file);
  }

  /// Throws [http.ClientException] and [ResourceException].
  Future<Stream<List<int>>> fetchUv(SimulationTime s) async {
    final file = await fetchResource(s, const [
      'u[0][0]',
      'v[0][0]',
    ]);
    return readUv(file);
  }
}
