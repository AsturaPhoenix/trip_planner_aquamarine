import 'dart:async';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';

/// A [Box] name bound to its element type.
class BoxOpener<T> {
  BoxOpener(this.name);
  final String name;
  Future<Box<T>> open() => Hive.openBox<T>(name);
  Future<void> delete() => Hive.deleteBoxFromDisk(name);
}

abstract class CacheBox {
  static final log = Logger('CacheBox');

  static Future<Box<T>> tryOpen<T>(String name) async {
    final boxOpener = BoxOpener<T>(name);
    try {
      return await boxOpener.open();
    } catch (e, s) {
      log.warning(
        'Failed to open ${boxOpener.name}. Deleting and reopening.',
        e,
        s,
      );
      await boxOpener.delete();
      return boxOpener.open();
    }
  }
}

/// A set of [Box]es that must open together or not at all. Upon failure, all
/// [Box]es are deleted and reopened.
class CacheBoxSet {
  static final log = Logger('CacheBoxSet');

  final boxOpeners = <BoxOpener, Completer<Box>>{};

  Future<Box<T>> tryOpen<T>(String name) {
    final completer = Completer<Box<T>>();
    boxOpeners[BoxOpener<T>(name)] = completer;
    return completer.future;
  }

  Future<void> onErrorDeleteAndRetry() async {
    try {
      final openings = await Future.wait(
        boxOpeners.keys.map(
          (boxOpener) => boxOpener.open().onError((Object e, s) {
            log.warning('Failed to open ${boxOpener.name}.', e, s);
            throw e;
          }),
        ),
      );

      for (final pair in IterableZip(<Iterable>[openings, boxOpeners.values])) {
        pair[1].complete(pair[0]);
      }
    } on Object {
      log.warning('Deleting boxes ${[
        for (final boxOpener in boxOpeners.keys) boxOpener.name
      ]} and reopening.');
      await Future.wait(boxOpeners.keys.map((boxOpener) => boxOpener.delete()));
      for (final entry in boxOpeners.entries) {
        entry.value.complete(entry.key.open());
      }
    }
  }
}
