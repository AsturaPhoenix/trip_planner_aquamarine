import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

/// This is functionally similar to
/// [package:async/async.dart ChunkedStreamReader] but is more efficient,
/// particularly with larger chunk sizes.
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

  /// Converts the reader into a stream that produces chunks that are multiples
  /// of [size]. This operation consumes the reader.
  Stream<Uint8List> withAlignment(int size) async* {
    try {
      while (buffer.isNotEmpty || await moveNext()) {
        // This covers the 0-length chunk case.
        if (buffer.isEmpty) continue;

        while (buffer.length < size) {
          await requireNext();
        }

        final bytes = buffer.takeBytes();
        final end = bytes.length - bytes.length % size;
        yield Uint8List.sublistView(bytes, 0, end);
        buffer.add(bytes.sublist(end));
      }
    } finally {
      await cancel();
    }
  }

  /// Similar to [package:async/async.dart ChunkedStreamReader.readStream], but
  /// does not drain on cancellation, and throws a [FormatException] if the
  /// stream ends before [size] is read.
  Stream<Uint8List> substream(int size) async* {
    int bytesRead = 0;
    while (buffer.isNotEmpty || await moveNext()) {
      if (bytesRead + buffer.length < size) {
        bytesRead += buffer.length;
        yield buffer.takeBytes();
      } else {
        final bytesWanted = size - bytesRead;
        final bytes = buffer.takeBytes();
        if (bytes.length < 2 * bytesWanted) {
          yield Uint8List.sublistView(bytes, 0, bytesWanted);
          buffer.add(bytes.sublist(bytesWanted));
        } else {
          yield bytes.sublist(0, bytesWanted);
          buffer.add(Uint8List.sublistView(bytes, bytesWanted));
        }
        return;
      }
    }

    throw FormatException('Unexpected end of stream.');
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
