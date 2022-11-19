import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:trip_planner_aquamarine/persistence/cache_box.dart';

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
  int accessCount = 0;
}

/// A function that returns `true` if the described blob should be evicted from
/// the cache.
typedef EvictionPolicy = bool Function(int blobs, BlobMetadata metadata);

class BlobCache {
  static final defaultLogger = Logger('BlobCache');

  static void registerAdapters() {
    Hive.registerAdapter(BlobMetadataRecordAdapter());
  }

  static Future<BlobCache> open(String name) async {
    final caches = CacheBoxSet();
    final accessLog = caches.tryOpen<String>('$name.accessLog');
    final metadata = caches.tryOpen<BlobMetadataRecord>('$name.metadata');
    final blobs = caches.tryOpen<Uint8List>('$name.blobs');
    caches.onErrorDeleteAndRetry();

    return BlobCache(
      await accessLog,
      await metadata,
      await blobs,
      log: Logger(name),
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
