import 'package:flutter/material.dart';

class AssetCache<T> {
  AssetCache()
      : configuration = null,
        _cache = {};
  AssetCache._(this.configuration, this._cache);

  final ImageConfiguration? configuration;
  late ImageConfiguration? _newConfiguration = configuration;

  /// This should be called at the beginning of every build to update the active
  /// configuration and initialize the access log.
  void beginBuild(BuildContext context, {Size? size}) {
    _newConfiguration = createLocalImageConfiguration(context, size: size);
    _toFetch = {};
  }

  final Map<String, T> _cache;
  Set<String>? _toFetch;

  T? operator [](String assetName) {
    final cached = _cache[assetName];
    if (cached == null || _newConfiguration != configuration) {
      _toFetch!.add(assetName);
    }
    return cached;
  }

  Set<String>? _lastFetch;
  ImageConfiguration? _fetchConfiguration;

  /// Schedules a fetch of all needed resources. Since this is async, this may
  /// be invoked at any time after [beginBuild] and still contain the asset
  /// names requested during the rest of the build.
  Future<AssetCache<T>?> fetchIfNeeded(
      Future<T> Function(ImageConfiguration configuration, String assetName)
          factory) async {
    if (_toFetch!.isEmpty ||
        _lastFetch == _toFetch && _fetchConfiguration == _newConfiguration) {
      return null;
    }

    _fetchConfiguration = _newConfiguration;
    final fetch = _lastFetch = _toFetch!;
    _toFetch = null;

    try {
      // There's no harm in just adding to the old cache if the configurations
      // are the same.
      final newCache =
          configuration == _fetchConfiguration ? _cache : <String, T>{};
      await Future.wait(fetch.map((assetName) =>
          factory(_fetchConfiguration!, assetName)
              .then((asset) => newCache[assetName] = asset)));
      // Identity comparison, in addition to being faster, avoids an extra
      // rebuild in a pathological case where the assets to be fetched change to
      // something different and then back again.
      return identical(_lastFetch, fetch)
          ? AssetCache._(_fetchConfiguration, newCache)
          : null;
    } on Object {
      _lastFetch = _fetchConfiguration = null;
      rethrow;
    }
  }
}
