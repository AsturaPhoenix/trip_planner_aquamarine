import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

/// This is functionally similar to
/// [package:async/async.dart ChunkedStreamReader] but aims to be more
/// efficient.
class BufferedReader {
  BufferedReader(Stream<List<int>> stream) : iterator = StreamIterator(stream);

  final buffer = BytesBuilder(copy: false);
  final StreamIterator<List<int>> iterator;

  /// Advances the stream and adds the next chunk(s) to the buffer.
  Future<bool> moveNext() async {
    if (await iterator.moveNext()) {
      buffer.add(iterator.current);
      return true;
    } else {
      return false;
    }
  }

  Future<void> cancel() => iterator.cancel();

  Future<void> requireNext() async {
    if (!await moveNext()) {
      throw FormatException('Unexpected end of stream.');
    }
  }

  Future<void> requireEnd() async {
    if (buffer.isNotEmpty || await moveNext()) {
      throw FormatException('Expected end of stream.');
    }
  }

  Future<Uint8List> readBuffer(int size) async {
    // There a couple possible strategies we could consider:
    // * Preallocate output buffer and copy input buffers as we get them.
    // * Add input buffers to a BytesBuilder and take/copy when we've
    //   accumulated enough.
    // Let's go with the latter for simplicity.

    while (buffer.length < size) {
      await requireNext();
    }

    final data = buffer.takeBytes();
    buffer.add(Uint8List.sublistView(data, size));
    return Uint8List.sublistView(data, 0, size);
  }

  Future<void> consumeUntil(Uint8List marker) async {
    while (buffer.length >= marker.length || await moveNext()) {
      if (buffer.length < marker.length) continue;

      final data = buffer.takeBytes();

      outer:
      for (int i = 0; i <= data.length - marker.length; ++i) {
        for (int j = 0; j < marker.length; ++j) {
          if (data[i + j] != marker[j]) continue outer;
        }

        buffer.add(data.sublist(i + marker.length));
        return;
      }
      buffer.add(data.sublist(max(data.length - marker.length + 1, 0)));
    }
    throw const FormatException('Marker not found.');
  }
}
