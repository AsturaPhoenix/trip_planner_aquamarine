import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:logging/logging.dart';

part 'blob_cache.g.dart';

abstract class BlobMetadata {
  DateTime get lastAccess;
  int get accessCount;
}

@HiveType(typeId: 0)
class BlobMetadataRecord implements BlobMetadata {
  @HiveField(0)
  late int accessKey;
  @HiveField(1)
  @override
  late DateTime lastAccess;
  @HiveField(2)
  @override
  late int accessCount = 0;
}

/// A function that returns `true` if the described blob should be evicted from
/// the cache.
typedef EvictionPolicy = bool Function(int blobs, BlobMetadata metadata);

/// Helps us avoid runtime type check failures after [Future.wait].
class _BoxOpener<T> {
  _BoxOpener(this.name);
  final String name;
  Future<Box<T>> open() => Hive.openBox<T>(name);
  Future<void> delete() => Hive.deleteBoxFromDisk(name);
}

class BlobCache {
  static final defaultLogger = Logger('BlobCache');

  static void registerAdapters() {
    Hive.registerAdapter(BlobMetadataRecordAdapter());
  }

  static Future<BlobCache> open(String name) async {
    final log = Logger(name);

    final boxOpeners = [
      _BoxOpener<String>('$name.accessLog'),
      _BoxOpener<BlobMetadataRecord>('$name.metadata'),
      _BoxOpener<Uint8List>('$name.blobs')
    ];
    var boxes = await Future.wait(
      boxOpeners.map(
        (boxOpener) => boxOpener.open().onError((Object e, s) {
          log.warning('Failed to open $name; deleting associated boxes.', e, s);
          throw e;
        }),
      ),
    ).catchError((_) async {
      await Future.wait(boxOpeners.map((boxOpener) => boxOpener.delete()));
      return Future.wait(boxOpeners.map((boxOpener) => boxOpener.open()));
    });

    return BlobCache(
      boxes[0] as Box<String>,
      boxes[1] as Box<BlobMetadataRecord>,
      boxes[2] as Box<Uint8List>,
      log: log,
    );
  }

  BlobCache(this.accessLog, this.metadata, this.blobs, {Logger? log})
      : log = log ?? defaultLogger;

  final Logger log;
  final Box<String> accessLog;

  /// Metadata are stored separately from the blob to avoid unnecessarily
  /// rewriting the blob every for access. In the future, we may also share
  /// metadata across devices so that accessing blobs through the web instructs
  /// the mobile app to cache content for offline access.
  final Box<BlobMetadataRecord> metadata;
  final Box<Uint8List> blobs;

  void touch(String key) async {
    final accessKey = await accessLog.add(key);
    // It's not critical that any of this is strongly consistent.

    var meta = metadata.get(key);
    if (meta != null) {
      accessLog.delete(meta.accessKey);
    }

    (meta ??= BlobMetadataRecord())
      ..accessKey = accessKey
      ..lastAccess = DateTime.now()
      ..accessCount += 1;
    metadata.put(key, meta);
  }

  Uint8List? operator [](String key) {
    final blob = blobs.get(key);
    if (blob != null) {
      log.info('$key: cache hit');
      touch(key);
    } else {
      log.info('$key: cache miss');
    }
    return blob;
  }

  void operator []=(String key, Uint8List value) {
    blobs.put(key, value);
    if (!metadata.containsKey(key)) {
      // Skip touch for cache refreshes
      touch(key);
    }
  }

  void evict(EvictionPolicy shouldEvict) {
    // for logging
    int evictions = 0;

    while (accessLog.isNotEmpty) {
      final key = accessLog.getAt(0);
      final meta = metadata.get(key);
      if (meta == null) {
        log.warning('Removing stale key $key');
        accessLog.deleteAt(0);
        blobs.delete(key);
        continue;
      }

      if (shouldEvict(blobs.length, meta)) {
        accessLog.deleteAt(0);
        metadata.delete(key);
        blobs.delete(key);
        ++evictions;
      } else {
        log.info('Evicted $evictions blobs');
        return;
      }
    }
  }
}
