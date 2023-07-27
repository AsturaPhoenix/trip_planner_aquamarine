import 'dart:typed_data';

import 'package:latlng/latlng.dart';
import 'package:vector_math/vector_math_64.dart';

import 'quadtree.dart';
import 'src/buffered_reader.dart';
import 'src/hex32.dart';
import 'src/hour_utc.dart';

export 'src/buffered_reader.dart';

Future<HourUtc> readHourUtc(BufferedReader reader) async =>
    HourUtc.fromHoursSinceEpoch(
      ByteData.sublistView(await reader.readBuffer(4)).getUint32(0),
    );

Future<Hex32> readHex32(BufferedReader reader) async =>
    Hex32.fromBytes(await reader.readBuffer(4));

Stream<List<T>> readFloat2x32<T>(
    BufferedReader reader, T Function(double, double) readElement) async* {
  await for (final data in reader.withAlignment(8).map(ByteData.sublistView)) {
    yield [
      for (int i = 0; i < data.lengthInBytes; i += 8)
        readElement(data.getFloat32(i), data.getFloat32(i + 4))
    ];
  }
}

Stream<List<Vector2>> readVectors(BufferedReader reader) =>
    readFloat2x32(reader, Vector2.new);

Stream<List<LatLng>> readLatLngs(BufferedReader reader) =>
    readFloat2x32(reader, LatLng.new);

Future<Quadtree<int>> indexLatLng(Stream<List<int>> stream,
    {int threshold = 8}) async {
  final quadtree = Quadtree<int>(threshold: threshold);
  int i = 0;
  await for (final latlngs in readLatLngs(BufferedReader(stream))) {
    for (final latlng in latlngs) {
      quadtree.add(latlng, i++);
    }
  }

  return quadtree;
}
