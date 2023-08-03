import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';

class FakeBox<T> extends Fake implements Box<T> {
  final data = <T>{};

  @override
  bool get isEmpty => data.isEmpty;
  @override
  bool get isNotEmpty => data.isNotEmpty;
  @override
  Iterable<T> get values => data;
  @override
  Future<Iterable<int>> addAll(Iterable<T> values) async {
    data.addAll(values);
    int i = 0;
    return [for (final _ in values) i++];
  }

  @override
  Future<int> clear() async {
    final size = data.length;
    data.clear();
    return size;
  }

  @override
  Future<void> close() async {}
}

class FakeBlobCache extends Fake implements BlobCache {
  final data = <String, Uint8List>{};

  @override
  Uint8List? operator [](String key) => data[key];
  @override
  void operator []=(String key, Uint8List value) => data[key] = value;
  @override
  void remove(String key) => data.remove(key);
  @override
  void close() {}
}
