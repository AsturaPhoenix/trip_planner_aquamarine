import 'dart:typed_data';

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

/// Reads chunked data as vectors.
Future<void> readFloat2x32<T>(
  BufferedReader reader,
  T Function(double a, double b) readElement,
  bool Function() condition,
  void Function(T element) forEach,
) async {
  // Only evaluate condition when we're about to produce a value so that
  // iterators can be used.
  bool ok = true;

  while (ok && (reader.buffer.length >= 8 || await reader.moveNext())) {
    if (reader.buffer.length < 8) continue;

    final bytes = reader.buffer.takeBytes();
    // Use ByteData rather than buffer.asFloat32List to be consistently big
    // endian.
    // We need to use sublistView as the buffer itself may extend beyond the
    // populated contents.
    final data = ByteData.sublistView(bytes);

    int j = 0;
    while ((ok = condition()) && j <= data.lengthInBytes - 8) {
      forEach(readElement(data.getFloat32(j), data.getFloat32(j + 4)));
      j += 8;
    }
    reader.buffer.add(bytes.sublist(j));
  }

  if (ok) {
    await reader.requireEnd();
  }
}

Future<void> readVectors(
  BufferedReader reader,
  bool Function() condition,
  void Function(Vector2 vector) forEach,
) =>
    readFloat2x32(reader, Vector2.new, condition, forEach);

Future<void> readLatLngs(
  BufferedReader reader,
  void Function(LatLng latlng) forEach,
) =>
    readFloat2x32(reader, LatLng.new, () => true, forEach);

Future<Quadtree<int>> indexLatLng(Stream<List<int>> stream) async {
  final quadtree = Quadtree<int>();
  int i = 0;
  final reader = BufferedReader(stream);
  try {
    await readLatLngs(reader, (latlng) => quadtree.add(latlng, i++));
  } finally {
    reader.cancel();
  }

  return quadtree;
}
