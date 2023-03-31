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

import 'types.dart';

/// The data from a DODS lonc-latc-u-v download, reorganized for caching.
///
/// uv, received as [...u][...v], becomes [...(u, v)].
///
/// Since we don't expect latlngs to change often if ever, they are hashed as
/// they come and discarded. If we do get a cache miss, we fire off a new
/// download. This should more than halve memory usage.
class OfsUvData {
  OfsUvData({required this.latlngHash, required this.uv});
  final Hex32 latlngHash;
  final Stream<List<int>> uv;
}

class OfsClient {
  /// Determines the simulation runs that would cover the target time [t].
  static Iterable<SimulationTime> simulationTimes(
    HourUtc t,
    SimulationSchedule schedule,
  ) sync* {
    final baseHour = t + schedule.referenceHour;
    for (int i = (t.hour - schedule.firstHour) % schedule.intervalHours;
        i <= schedule.coverageHours;
        i += schedule.intervalHours) {
      yield SimulationTime(schedule, baseHour - i, i);
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

      for (int j = 0; j <= v1.length - 4; i += 4, j += 4) {
        combiner(out, v0.sublist(i, i + 4), v1.sublist(j, j + 4));
      }

      yield out.takeBytes();

      reader.buffer.add(v1.sublist(v1.length & -4));
    }
  }

  /// Reads latlngs for disk caching.
  /// [...lonc][...latc] becomes [...(latc, lonc)].
  static Stream<Uint8List> readLatLng(Stream<List<int>> stream) async* {
    final reader = BufferedReader(stream);
    try {
      await reader.consumeUntil(dataMarker);

      yield* interleave2x32(
          reader,
          (out, a, b) => out
            ..add(b)
            ..add(a));

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

  static Future<OfsUvData> readUv(Stream<List<int>> stream) async {
    final reader = BufferedReader(stream);
    try {
      await reader.consumeUntil(dataMarker);

      return OfsUvData(
        latlngHash: await _hashLatLng(reader),
        uv: () async* {
          try {
            yield* interleave2x32(
              reader,
              (out, a, b) => out
                ..add(a)
                ..add(b),
            );
          } finally {
            reader.cancel();
          }
        }(),
      );
    } on Exception {
      reader.cancel();
      rethrow;
    }
  }

  OfsClient({required this.client});
  final http.Client client;

  Future<http.ByteStream?> fetchResource(
      SimulationTime s, List<String> query) async {
    final http.StreamedResponse response;
    try {
      response = await client.send(
          http.Request('get', resourceUri(simulationTime: s, query: query)));
    } on http.ClientException {
      return null;
    }

    return response.statusCode == HttpStatus.ok ? response.stream : null;
  }

  Future<Stream<Uint8List>?> fetchLatLng(SimulationTime s) async {
    final file = await fetchResource(s, const [
      'lonc',
      'latc',
    ]);
    return file == null ? null : readLatLng(file);
  }

  Future<OfsUvData?> fetchUv(SimulationTime s) async {
    final file = await fetchResource(s, const [
      'lonc',
      'latc',
      'u[0][0]',
      'v[0][0]',
    ]);
    return file == null ? null : readUv(file);
  }
}
