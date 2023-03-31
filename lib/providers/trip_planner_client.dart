import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:xml/xml.dart';

import '../persistence/blob_cache.dart';
import '../persistence/tide_graph_cache.dart';
import '../util/optional.dart';

class _RedirectInfo implements RedirectInfo {
  _RedirectInfo({
    required this.location,
    required this.method,
    required this.statusCode,
  });

  @override
  final Uri location;
  @override
  final String method;
  @override
  final int statusCode;
}

Future<Uri> resolveRedirects(
  Client client,
  Uri url, {
  required int maxRedirects,
}) async {
  final redirects = <RedirectInfo>[];
  while (redirects.length <= maxRedirects) {
    final response =
        await client.send(Request('HEAD', url)..followRedirects = false);
    if (response.isRedirect) {
      url = Uri.parse(response.headers['location']!);
      redirects.add(
        _RedirectInfo(
          location: url,
          method: 'HEAD',
          statusCode: response.statusCode,
        ),
      );
    } else if (response.statusCode == HttpStatus.ok) {
      return url;
    } else {
      throw response;
    }
  }
  throw RedirectException('Too many redirects', redirects);
}

class RetryOnDemand<T> {
  static final log = Logger('RetryOnDemand');

  RetryOnDemand(this._factory) {
    _cached = _guardedFactory();
  }

  final Future<T> Function() _factory;
  Future<T>? _cached;

  Future<T> _guardedFactory() => _factory().onError((Object e, s) {
        _cached = null;
        throw e;
      });

  Future<T> get() => _cached ??= _guardedFactory();
}

class TripPlannerClient {
  static final log = Logger('TripPlannerClient');

  static void registerAdapters() {
    Hive
      ..registerAdapter(StationAdapter())
      ..registerAdapter(LatLngAdapter());
  }

  TripPlannerClient(
    this.stationCache,
    this.tideGraphCache,
    this.httpClientFactory,
    this.timeZone,
  );
  final Box<Station> stationCache;
  final BlobCache tideGraphCache;
  Future<TripPlannerHttpClient> Function()? httpClientFactory;

  /// The server uses local time zone, and all the stations are on the West
  /// Coast.
  final TimeZone timeZone;

  void close() {
    stationCache.close().ignore();
    tideGraphCache.close();
    httpClientFactory?.call().then((client) => client.close()).ignore();
  }

  Stream<Map<StationId, Station>> getDatapoints() async* {
    final bool needResults;
    if (stationCache.isNotEmpty) {
      log.fine('Stations: cache hit.');
      yield {for (final station in stationCache.values) station.id: station};
      needResults = false;
    } else {
      log.info('Stations: cache miss.');
      needResults = true;
    }

    if (httpClientFactory != null) {
      try {
        final stations = await (await httpClientFactory!()).getDatapoints();
        log.info('Stations: fetched/refreshed.');
        yield stations;
        stationCache
          ..clear()
          ..addAll(stations.values);
      } catch (e, s) {
        if (needResults) {
          rethrow;
        } else {
          log.warning('Failed to refresh stations.', e, s);
        }
      }
    }
  }

  Stream<Uint8List> getTideGraph(
    Station station,
    int days,
    int width,
    int height,
    Date begin,
  ) async* {
    final bool needResults;

    final key = TideGraphKey(station.id, begin, days).toString();
    final cached = tideGraphCache[key];
    if (cached != null) {
      yield cached;
      needResults = false;
    } else {
      needResults = true;
    }

    if (httpClientFactory != null) {
      try {
        // TODO: Deduplicate current requests, or cancel on unsubscribe.
        yield tideGraphCache[key] = await (await httpClientFactory!())
            .getTideGraph(station, days, width, height, begin);
      } catch (e, s) {
        if (needResults) {
          rethrow;
        } else {
          log.warning('Failed to fetch/refresh tide graph.', e, s);
        }
      }
    }
  }

  ImageProvider getImage(Uri relative) => TripPlannerImage._(
        relative,
        (() async => (await httpClientFactory!.call()).baseUrl)(),
      );

  Future<String> getTideCurrentStationDetails(Station station) async =>
      (await httpClientFactory!.call()).getTideCurrentStationDetails(station);
}

class TripPlannerHttpClient {
  static final log = Logger('TripPlannerHttpClient');

  static Future<TripPlannerHttpClient> resolveFromRedirect(
    Uri baseUrl, {
    int maxRedirects = 5,
  }) async {
    final client = Client();
    try {
      baseUrl =
          await resolveRedirects(client, baseUrl, maxRedirects: maxRedirects);
    } on Object {
      // For web during development, we may run into CORS denials, so use a local instance.
      if (kIsWeb && (kDebugMode || kProfileMode)) {
        baseUrl = Uri.parse('http://localhost/trip_planner/');
      } else {
        rethrow;
      }
    }
    log.info('base URL: $baseUrl');
    return TripPlannerHttpClient(client, baseUrl);
  }

  TripPlannerHttpClient(this.client, this.baseUrl);
  final Client client;
  final Uri baseUrl;

  void close() => client.close();

  late final datapointsUrl = baseUrl.resolve('datapoints.xml');

  Future<Map<StationId, Station>> getDatapoints() async {
    final response = await client.get(datapointsUrl);
    if (response.statusCode != HttpStatus.ok) {
      throw response;
    }

    /// The server may omit character encoding for XML, which should default to
    /// UTF-8 or 16 rather than latin1 as in the default RFC 2616 for
    /// Response.body. Since we control the data source, go ahead and hard-code
    /// UTF-8.
    return parseStations(utf8.decode(response.bodyBytes));
  }

  late final tidesUrl = baseUrl.resolve('tides.php');

  Future<Uint8List> getTideGraph(
    Station station,
    int days,
    int width,
    int height,
    Date begin,
  ) async {
    final url = tidesUrl.replace(
      queryParameters: {
        'days': days.toString(),
        'mode': 'graph',
        'tcd': station.source,
        'station': station.title,
        'type': station.type.name,
        'width': width.toString(),
        'height': height.toString(),
        'begin': '${begin.year}-${begin.month}-${begin.day}',
        'subord': station.isSubordinate ? '1' : '',
      },
    );

    log.fine('get $url');

    final response = await client.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return response.bodyBytes;
    } else {
      throw response;
    }
  }

  Future<String> getTideCurrentStationDetails(Station station) async {
    final url = tidesUrl.replace(
      queryParameters: {
        'mode': 'about',
        'tcd': station.source,
        'station': station.title,
        'head': '${station.type.description}: ${station.shortTitle}',
      },
    );

    log.fine('get $url');

    final response = await client.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else {
      throw response;
    }
  }
}

Map<StationId, Station> parseStations(String xml) => {
      for (final station in XmlDocument.parse(xml)
          .findAllElements('station')
          .map(Station.fromXml))
        station.id: station
    };

LatLng latLngFromXml(XmlElement node) => LatLng(
      double.parse(node.getAttribute('lat')!),
      double.parse(node.getAttribute('lng')!),
    );

enum StationType {
  launch('Launch Site'),
  meeting('Meeting Place'),
  destination('Destination'),
  tide('Tide Station'),
  current('Current Station'),
  legacy('Legacy Tide and Current Stations'),
  subordinate('Subordinate Tide and Current Stations'),
  yourcoast('YourCoast'),
  nogo('Restricted Area');

  static final _byName = {for (final e in values) e.name: e};

  const StationType(this.description);
  factory StationType.forName(String name) => _byName[name]!;
  final String description;

  bool get isTideCurrent => this == tide || this == current;
}

enum StationIdPrefix { t, c, x }

class StationId extends Equatable {
  const StationId(this.prefix, this.index);
  StationId.parse(String string)
      : prefix = StationIdPrefix.values.singleWhere(
          (p) => string[0] == p.name,
          orElse: () =>
              throw FormatException('Station ID prefix not found.', string, 0),
        ),
        index = int.parse(string.substring(1));
  factory StationId.fromXml(XmlElement stationNode) {
    for (final prefix in StationIdPrefix.values) {
      final index = stationNode.getAttribute('${prefix.name}id');
      if (index != null) {
        return StationId(prefix, int.parse(index));
      }
    }
    throw FormatException('Missing required .id attribute', stationNode);
  }

  final StationIdPrefix prefix;
  final int index;

  @override
  List<Object?> get props => [prefix, index];

  @override
  String toString() => '${prefix.name}$index';
}

// tp.js: marker_from_xml
class Station {
  Station({
    required this.id,
    required this.type,
    required this.marker,
    this.noaaId = '',
    required this.title,
    this.source,
    this.isSubordinate = false,
    this.tideCurrentStationId,
    this.details,
    this.outlines = const [],
  });
  Station.fromXml(XmlElement node)
      : id = StationId.fromXml(node),
        type = StationType.forName(node.getAttribute('station_type')!),
        marker = latLngFromXml(node.findElements('marker').first),
        noaaId = node.getAttribute('noaa_id') ?? '',
        title = node.getAttribute('title')!,
        source = node.getAttribute('source'),
        isSubordinate = node.getAttribute('subtype') == 'Subordinate',
        tideCurrentStationId =
            Optional(node.findElements('tide_station').firstOrNull).map(
                  (tsid) => StationId(StationIdPrefix.t, int.parse(tsid.text)),
                ) ??
                Optional(node.findElements('current_station').firstOrNull).map(
                  (csid) => StationId(StationIdPrefix.c, int.parse(csid.text)),
                ),
        details = node.findElements('details').firstOrNull?.text,
        outlines = [
          for (final outline in node.findElements('outline'))
            [...outline.findElements('coord').map(latLngFromXml)]
        ];
  Station.read(BinaryReader reader)
      : id = StationId.parse(reader.readString()),
        type = StationType.forName(reader.readString()),
        marker = reader.read() as LatLng,
        noaaId = reader.readString(),
        title = reader.readString(),
        source = reader.read() as String?,
        isSubordinate = reader.readBool(),
        tideCurrentStationId =
            Optional.string(reader.readString()).map(StationId.parse),
        details = Optional.string(reader.readString()).value,
        outlines = [
          for (final outline in reader.readList()) (outline as List).cast()
        ];

  final StationId id;
  final StationType type;
  final LatLng marker;
  final String noaaId;
  bool get isLegacy => type.isTideCurrent && noaaId == '';
  final String title;
  String get shortTitle =>
      title.replaceAll(RegExp(r', California( Current)?'), '');
  String get typedShortTitle => '${type.description}: $shortTitle';
  final String? source;
  final bool isSubordinate;
  final StationId? tideCurrentStationId;
  final String? details;
  final List<List<LatLng>> outlines;

  void write(BinaryWriter writer) => writer
    ..writeString(id.toString())
    ..writeString(type.name)
    ..write(marker)
    ..writeString(noaaId)
    ..writeString(title)
    ..write(source)
    ..writeBool(isSubordinate)
    ..writeString(tideCurrentStationId?.toString() ?? '')
    ..writeString(details ?? '')
    ..writeList(outlines);
}

class StationAdapter extends TypeAdapter<Station> {
  @override
  final int typeId = 1;

  @override
  Station read(BinaryReader reader) => Station.read(reader);

  @override
  void write(BinaryWriter writer, Station obj) => obj.write(writer);
}

class LatLngAdapter extends TypeAdapter<LatLng> {
  @override
  final int typeId = 2;

  @override
  LatLng read(BinaryReader reader) =>
      LatLng(reader.readDouble(), reader.readDouble());

  @override
  void write(BinaryWriter writer, LatLng obj) => writer
    ..writeDouble(obj.latitude)
    ..writeDouble(obj.longitude);
}

class TripPlannerImageKey extends Equatable {
  const TripPlannerImageKey(this.uri);
  final Uri uri;

  @override
  get props => [uri];
}

class _DelegatingImageStreamCompleterHandle
    implements ImageStreamCompleterHandle {
  _DelegatingImageStreamCompleterHandle(this.completer, this.superHandle);

  final DelegatingImageStreamCompleter completer;
  final ImageStreamCompleterHandle superHandle;

  @override
  void dispose() {
    if (--completer._keepAliveHandles == 0) {
      completer._delegateHandle?.dispose();
    }
    superHandle.dispose();
  }
}

class DelegatingImageStreamCompleter extends ImageStreamCompleter {
  late final delegateListener = ImageStreamListener(
    (image, _) => setImage(image),
    onChunk: reportImageChunkEvent,
    onError: (e, s) => reportError(exception: e, stack: s),
  );

  set delegate(ImageStreamCompleter value) {
    if (value != _delegate) {
      _delegate?.removeListener(delegateListener);
      _delegateHandle?.dispose();

      _delegate = value;

      if (_keepAliveHandles > 0) {
        _delegateHandle = value.keepAlive();
      }
      if (hasListeners) {
        value.addListener(delegateListener);
      }
    }
  }

  ImageStreamCompleter? _delegate;
  ImageStreamCompleterHandle? _delegateHandle;
  int _keepAliveHandles = 0;

  @override
  void addListener(ImageStreamListener listener) {
    if (!hasListeners) {
      _delegate?.addListener(delegateListener);
    }
    super.addListener(listener);
  }

  @override
  void removeListener(ImageStreamListener listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      _delegate?.removeListener(delegateListener);
    }
  }

  @override
  keepAlive() {
    if (_keepAliveHandles++ == 0) {
      _delegateHandle = _delegate?.keepAlive();
    }
    return _DelegatingImageStreamCompleterHandle(this, super.keepAlive());
  }
}

class TripPlannerImage extends ImageProvider<TripPlannerImageKey> {
  TripPlannerImage._(this.relative, this.base);
  final Uri relative;
  final Future<Uri> base;

  @override
  Future<TripPlannerImageKey> obtainKey(ImageConfiguration configuration) =>
      // It's important that this is a [SynchronousFuture] rather than a
      // [Future.sync] or similar or else the images may flicker on rebuild.
      SynchronousFuture(TripPlannerImageKey(relative));

  @override
  ImageStreamCompleter loadImage(
    TripPlannerImageKey key,
    ImageDecoderCallback decode,
  ) {
    final completer = DelegatingImageStreamCompleter();
    base.then((base) {
      final net = NetworkImage(base.resolveUri(relative).toString());
      completer.delegate = net.loadImage(net, decode);
    });
    return completer;
  }
}
