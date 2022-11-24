import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/persistence/tide_graph_cache.dart';
import 'package:trip_planner_aquamarine/util/optional.dart';
import 'package:xml/xml.dart';

class TripPlannerEndpoints {
  TripPlannerEndpoints({required this.datapoints, required this.tides});

  final Uri datapoints, tides;

  TripPlannerEndpoints resolve(Uri base) => TripPlannerEndpoints(
        datapoints: base.resolveUri(datapoints),
        tides: base.resolveUri(tides),
      );
}

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
    Hive.registerAdapter(StationAdapter());
    Hive.registerAdapter(LatLngAdapter());
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

  void close() =>
      httpClientFactory?.call().then((client) => client.close()).ignore;

  Stream<Map<StationId, Station>> getDatapoints() {
    final results = StreamController<Map<StationId, Station>>();
    final bool needResults;
    if (stationCache.isNotEmpty) {
      log.info('Stations: cache hit.');
      results.add(
        {for (final station in stationCache.values) station.id: station},
      );
      needResults = false;
    } else {
      log.info('Stations: cache miss.');
      needResults = true;
    }

    if (httpClientFactory != null) {
      () async {
        try {
          final stations = await (await httpClientFactory!()).getDatapoints();
          log.info('Stations: fetched/refreshed.');
          results.add(stations);
          stationCache
            ..clear()
            ..addAll(stations.values);
        } catch (e, s) {
          if (needResults) {
            results.addError(e, s);
          } else {
            log.warning('Failed to refresh stations.', e, s);
          }
        } finally {
          results.close();
        }
      }();
    } else {
      results.close();
    }

    return results.stream;
  }

  Stream<Uint8List> getTideGraph(
    Station station,
    int days,
    int width,
    int height,
    Date begin,
  ) {
    final results = StreamController<Uint8List>();
    final bool needResults;

    final key = TideGraphKey(station.id, begin, days).toString();
    final cached = tideGraphCache[key];
    if (cached != null) {
      results.add(cached);
      needResults = false;
    } else {
      needResults = true;
    }

    if (httpClientFactory != null) {
      () async {
        try {
          // TODO: Deduplicate current requests, or cancel on unsubscribe.
          final data = await (await httpClientFactory!())
              .getTideGraph(station, days, width, height, begin);
          results.add(data);
          tideGraphCache[key] = data;
        } catch (e, s) {
          if (needResults) {
            results.addError(e, s);
          } else {
            log.warning('Failed to fetch/refresh tide graph.', e, s);
          }
        } finally {
          results.close();
        }
      }();
    } else {
      results.close();
    }

    return results.stream;
  }
}

class TripPlannerHttpClient {
  static final log = Logger('TripPlannerHttpClient');

  static Future<TripPlannerHttpClient> resolveFromRedirect(
    Uri base,
    TripPlannerEndpoints relative, {
    int maxRedirects = 5,
  }) async {
    final client = Client();
    try {
      base = await resolveRedirects(client, base, maxRedirects: maxRedirects);
    } on Object {
      // For web during development, we may run into CORS denials, so use a local instance.
      if (kIsWeb && kDebugMode) {
        base = Uri.parse('http://localhost/trip_planner/');
      } else {
        rethrow;
      }
    }
    log.info('base URL: $base');
    return TripPlannerHttpClient(client, relative.resolve(base));
  }

  TripPlannerHttpClient(this.client, this.endpoints);
  final Client client;
  final TripPlannerEndpoints endpoints;

  void close() => client.close();

  Future<Map<StationId, Station>> getDatapoints() async {
    final response = await client.get(endpoints.datapoints);
    if (response.statusCode != HttpStatus.ok) {
      throw response;
    }

    return {
      for (final stationNode
          in XmlDocument.parse(response.body).findAllElements('station'))
        StationId.fromXml(stationNode): Station.fromXml(stationNode)
    };
  }

  Future<Uint8List> getTideGraph(
    Station station,
    int days,
    int width,
    int height,
    Date begin,
  ) async {
    final url = endpoints.tides.replace(
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

    log.info('get $url');

    final response = await client.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return response.bodyBytes;
    } else {
      throw response;
    }
  }
}

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
                );
  Station.read(BinaryReader reader)
      : id = StationId.parse(reader.readString()),
        type = StationType.forName(reader.readString()),
        marker = reader.read() as LatLng,
        noaaId = reader.readString(),
        title = reader.readString(),
        source = reader.read() as String?,
        isSubordinate = reader.readBool(),
        tideCurrentStationId = (() {
          final id = reader.readString();
          return id == '' ? null : StationId.parse(id);
        }());

  final StationId id;
  final StationType type;
  final LatLng marker;
  final String noaaId;
  bool get isLegacy => noaaId == '';
  final String title;
  String get shortTitle =>
      title.replaceAll(RegExp(r', California( Current)?'), '');
  String get typedShortTitle => '${type.description}: $shortTitle';
  final String? source;
  final bool isSubordinate;

  final StationId? tideCurrentStationId;

  void write(BinaryWriter writer) => writer
    ..writeString(id.toString())
    ..writeString(type.name)
    ..write(marker)
    ..writeString(noaaId)
    ..writeString(title)
    ..write(source)
    ..writeBool(isSubordinate)
    ..writeString(tideCurrentStationId?.toString() ?? '');
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
