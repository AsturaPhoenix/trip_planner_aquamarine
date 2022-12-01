import 'dart:core';
import 'dart:core' as core;
import 'dart:developer' as debug;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:timezone/data/latest.dart';

import 'persistence/blob_cache.dart';
import 'persistence/cache_box.dart';
import 'providers/trip_planner_client.dart';
import 'util/optional.dart';
import 'widgets/details_panel.dart';
import 'widgets/map.dart';
import 'widgets/tide_panel.dart';

void main() async {
  Logger.root.onRecord.listen(
    (record) => debug.log(
      '${record.level.name}: ${record.time}: ${record.message}',
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    ),
  );

  initializeTimeZones();

  final httpClientFactory = RetryOnDemand(
    () => TripPlannerHttpClient.resolveFromRedirect(
      kIsWeb
          ? Uri(path: '/trip_planner/')
          : Uri.parse('https://www.bask.org/trip_planner/'),
    ),
  );

  await Hive.initFlutter();
  BlobCache.registerAdapters();
  TripPlannerClient.registerAdapters();

  final stationCache = CacheBox.tryOpen<Station>('StationCache');
  final tideGraphCache = BlobCache.open('TideGraphCache');
  final tileCache = BlobCache.open('TileCache');

  final softExpiry = (Instant.now() - const Duration(days: 180)).value;
  tideGraphCache.then(
    (cache) => cache.evict(
      (blobs, metadata) =>
          // approx. 5 MB @ 20 kB ea.
          blobs > 250 || blobs > 50 && metadata.lastAccess.isBefore(softExpiry),
    ),
  );
  tileCache.then(
    (cache) => cache.evict(
      (blobs, metadata) =>
          // approx. 50 MB @ 100 kB ea.
          blobs > 500 || blobs > 50 && metadata.lastAccess.isBefore(softExpiry),
    ),
  );

  runApp(
    TripPlanner(
      tripPlannerClient: TripPlannerClient(
        await stationCache,
        await tideGraphCache,
        httpClientFactory.get,
        TimeZone.forId('America/Los_Angeles'),
      ),
      wmsClient: http.Client(),
      tileCache: await tileCache,
    ),
  );
}

class TripPlanner extends StatefulWidget {
  const TripPlanner({
    super.key,
    required this.tripPlannerClient,
    required this.wmsClient,
    required this.tileCache,
  });

  final TripPlannerClient tripPlannerClient;
  final http.Client wmsClient;
  final BlobCache tileCache;

  @override
  TripPlannerState createState() => TripPlannerState();
}

class TripPlannerState extends State<TripPlanner>
    with SingleTickerProviderStateMixin {
  static final log = Logger('TripPlannerState');

  Station? selectedStation;
  Instant t = Instant.now();
  late Stream<core.Map<StationId, Station>> stations;

  late final panelTabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState;
    updateClient();
  }

  @override
  void didUpdateWidget(covariant TripPlanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tripPlannerClient != oldWidget.tripPlannerClient) {
      updateClient();
    }
  }

  void updateClient() {
    stations = widget.tripPlannerClient
        .getDatapoints()
        .where((stations) => stations.isNotEmpty)
        .handleError(
          (e, StackTrace s) => log.warning('Failed to get station list.', e, s),
        );
  }

  @override
  void dispose() {
    super.dispose();
    widget.tripPlannerClient.close();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BASK Trip Planner',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xffbbccff)).copyWith(
            background: const Color(0xffbbccff),
            secondary: const Color(0xff8899cc),
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.resolveWith(
              (states) => states.isEmpty ? const Color(0x38000000) : null,
            ),
            thumbVisibility: const MaterialStatePropertyAll(true),
          ),
          tabBarTheme: const TabBarTheme(
            indicator: BoxDecoration(
              color: Color(0x40ffffff),
              border: Border(
                bottom: BorderSide(width: 2, color: Color(0x40000000)),
              ),
            ),
            labelColor: Colors.black,
            labelPadding: EdgeInsets.all(4),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        home: LayoutBuilder(
          builder: (context, boxConstraints) {
            return StreamBuilder(
              stream: stations,
              builder: (context, stationsSnapshot) {
                final stations = stationsSnapshot.data;
                selectedStation ??= stations?.values.first;

                return _Scaffold(
                  wmsClient: widget.wmsClient,
                  tripPlannerClient: widget.tripPlannerClient,
                  tileCache: widget.tileCache,
                  panelTabController: panelTabController,
                  constraints: boxConstraints,
                  stations: stations,
                  selectedStation: selectedStation,
                  onStationSelected: (station) =>
                      setState(() => selectedStation = station),
                  t: t,
                  onTimeChanged: (t) => setState(() => this.t = t),
                );
              },
            );
          },
        ),
      );
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.wmsClient,
    required this.tripPlannerClient,
    required this.tileCache,
    required this.panelTabController,
    required this.constraints,
    this.stations,
    this.selectedStation,
    this.onStationSelected,
    required this.t,
    this.onTimeChanged,
  });

  final http.Client wmsClient;
  final TripPlannerClient tripPlannerClient;
  final BlobCache tileCache;
  final TabController panelTabController;
  final BoxConstraints constraints;
  final core.Map<StationId, Station>? stations;
  final Station? selectedStation;
  final void Function(Station)? onStationSelected;
  final Instant t;
  final void Function(Instant)? onTimeChanged;

  @override
  Widget build(BuildContext context) {
    const double selectedStationBarMinWidth = 480,
        titleAreaPadding = 164,
        selectedStationBarMinPadding = 16;
    final centeredInlineStationBar = constraints.maxWidth >=
        selectedStationBarMinWidth +
            2 *
                (_SelectedStationBar.blendedHorizontalPadding +
                    selectedStationBarMinPadding +
                    titleAreaPadding);
    final inlineStationBar = constraints.maxWidth >=
        selectedStationBarMinWidth +
            2 *
                (_SelectedStationBar.blendedHorizontalPadding +
                    selectedStationBarMinPadding) +
            titleAreaPadding;
    final horizontal = constraints.maxWidth >= constraints.maxHeight;

    final tideCurrentStation = Optional(selectedStation).map(
      (station) => station.type.isTideCurrent
          ? station
          : stations![station.tideCurrentStationId],
    );

    const title = Text('BASK Trip Planner');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            title,
            if (selectedStation != null && inlineStationBar)
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: selectedStationBarMinPadding,
                  ),
                  child: _SelectedStationBar(
                    selectedStation!,
                    blendEdges: true,
                  ),
                ),
              ),
            if (centeredInlineStationBar)
              const Opacity(opacity: 0, child: title),
          ],
        ),
      ),
      body: Column(
        children: [
          if (selectedStation != null && !inlineStationBar)
            _SelectedStationBar(
              selectedStation!,
              blendEdges: false,
            ),
          Expanded(
            child: Flex(
              direction: horizontal ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Map(
                    client: wmsClient,
                    tileCache: tileCache,
                    stations: stations ?? {},
                    selectedStation: selectedStation,
                    onStationSelected: onStationSelected,
                  ),
                ),
                SizedBox(
                  width: horizontal
                      ? min(
                          constraints.maxWidth / 2,
                          TidePanel.defaultGraphWidth,
                        )
                      : constraints.maxWidth,
                  child: _Panel(
                    tripPlannerClient: tripPlannerClient,
                    tabController: panelTabController,
                    horizontal: horizontal,
                    selectedStation: selectedStation,
                    tideCurrentStation: tideCurrentStation,
                    t: t,
                    onTimeChanged: onTimeChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedStationBar extends StatelessWidget {
  static const double verticalPadding = 6, blendedHorizontalPadding = 40;
  static const double preferredWidth = 0x2C0;

  static Widget blendedEdgeContainer({
    required Color color,
    required Widget child,
  }) =>
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.elliptical(32, 4)),
          gradient: LinearGradient(
            colors: [Colors.transparent, color, color, Colors.transparent],
            stops: const [0, .05, .95, 1],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: blendedHorizontalPadding,
        ),
        width: preferredWidth,
        child: child,
      );

  static Widget fullWidthContainer({
    required Color color,
    required Widget child,
  }) =>
      Container(
        color: color,
        padding: const EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: 16,
        ),
        child: Center(child: child),
      );

  const _SelectedStationBar(this.station, {this.blendEdges = true});

  final Station station;
  final bool blendEdges;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide()),
        ),
        position: DecorationPosition.foreground,
        child: (blendEdges ? blendedEdgeContainer : fullWidthContainer)(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: FittedBox(
            child: Text(
              station.typedShortTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      );
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.tripPlannerClient,
    required this.tabController,
    required this.horizontal,
    this.selectedStation,
    this.tideCurrentStation,
    required this.t,
    this.onTimeChanged,
  });

  final TripPlannerClient tripPlannerClient;
  final TabController tabController;
  final bool horizontal;
  final Station? selectedStation, tideCurrentStation;
  final Instant t;
  final void Function(Instant)? onTimeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final viewport = TabBarView(
      controller: tabController,
      children: [
        tideCurrentStation == null
            ? const Text('No tide/current station selected.')
            : TidePanel(
                client: tripPlannerClient,
                station: tideCurrentStation!,
                t: t,
                onTimeChanged: onTimeChanged,
              ),
        selectedStation == null
            ? const Text('No location selected.')
            : DetailsPanel(
                client: tripPlannerClient,
                station: selectedStation!,
              )
      ],
    );

    return Material(
      color: theme.colorScheme.background,
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: theme.colorScheme.secondary,
            elevation: .25,
            child: TabBar(
              controller: tabController,
              tabs: const [Text('Tides'), Text('Details')],
            ),
          ),
          horizontal
              ? Expanded(child: viewport)
              : LayoutBuilder(
                  builder: (context, boxConstraints) => SizedBox(
                    height: TidePanel.estimateHeight(boxConstraints.maxWidth),
                    child: viewport,
                  ),
                ),
        ],
      ),
    );
  }
}
