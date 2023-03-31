import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:test/test.dart';

class Chunker {
  static const mono = Chunker('not chunked', _mono),
      natural = Chunker('natural chunks', _natural),
      bisecting = Chunker('bisecting chunks', _bisecting),
      extreme = Chunker('extreme chunks', _extreme);
  static const all = [mono, natural, bisecting, extreme];

  const Chunker(this.description, this.impl);
  final String description;
  final Stream<List<int>> Function(Iterable<List<int>> data) impl;

  Stream<List<int>> call(Iterable<List<int>> data) => impl(data);
}

Stream<List<int>> _mono(Iterable<List<int>> data) {
  final builder = BytesBuilder();
  data.forEach(builder.add);
  return Stream.value(builder.takeBytes());
}

Stream<List<int>> _natural(Iterable<List<int>> data) =>
    Stream.fromIterable(data);

Stream<List<int>> _bisecting(Iterable<List<int>> data) =>
    Stream.fromIterable(data.expand((data) {
      final pivot = data.length ~/ 2;
      return [data.sublist(0, pivot), data.sublist(pivot)];
    }));

Stream<List<int>> _extreme(Iterable<List<int>> data) async* {
  for (final data in data) {
    for (final byte in data) {
      yield [byte];
    }
  }
}

/// Runs a set of tests with different chunking strategies.
///
/// Test groups use regular expressions to determine what tests to run and
/// require that the first argument be the description. So that we have
/// something to run, provide a default description that matches one of the
/// chunker descriptions.
@isTestGroup
void forChunkers(
  String defaultVariant,
  dynamic Function(Chunker chunker) body, [
  Iterable<Chunker> chunkers = Chunker.all,
]) {
  for (final chunker in chunkers) {
    group(chunker.description, () => body(chunker));
  }
}
