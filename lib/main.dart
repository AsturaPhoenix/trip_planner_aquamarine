import 'dart:async';
import 'dart:core';
import 'dart:core' as core;
import 'dart:developer' as debug;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
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

/// Most browsers won't surface a location permission request unless we're using
/// https.
final bool canRequestLocation =
    !kIsWeb || Uri.base.scheme == 'https' || Uri.base.host == 'localhost';

class TripPlannerState extends State<TripPlanner> {
  static final log = Logger('TripPlannerState');

  static Station nearestStation(Iterable<Station> stations, Position position) {
    double nearestDistance = double.infinity;
    late Station nearestStation;
    for (final station in stations) {
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        station.marker.latitude,
        station.marker.longitude,
      );
      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestStation = station;
      }
    }
    return nearestStation;
  }

  Station? selectedStation;
  late GraphTimeWindow timeWindow =
      GraphTimeWindow.now(widget.tripPlannerClient.timeZone);
  late Stream<core.Map<StationId, Station>> stations;

  bool locationEnabled = false;
  late Future<Position?> initialPosition;

  double Function(StationType)? stationPriority;

  bool hasModal = false;

  Future<bool> requestLocationPermission() async {
    // Use Permission rather than Geolocator for permission request to take
    // advantage of it failing on web so we don't default to making an annoying
    //permission request.
    //
    // If this negatively affects the experience on mobile web, we can consider
    // gating on kWeb + defaultTargetPlatform instead.
    bool enabled =
        kIsWeb ? true : await Permission.locationWhenInUse.request().isGranted;
    setState(() => locationEnabled = enabled);
    return enabled;
  }

  @override
  void initState() {
    super.initState;
    updateClient();

    initialPosition = kIsWeb
        ? Future.value(null)
        : requestLocationPermission().then(
            (_) => Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.medium,
              timeLimit: const Duration(seconds: 10),
            ),
          );
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
            tertiary: const Color(0xffaa0000),
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
        home: FutureBuilder(
          future: initialPosition,
          builder: (context, initialPositionSnapshot) => StreamBuilder(
            stream: stations,
            builder: (context, stationsSnapshot) {
              final stations = stationsSnapshot.data ?? {};
              final selectableStations = stations.values.where(
                (station) => Map.showMarkerTypes.contains(station.type),
              );

              if (selectedStation == null &&
                  selectableStations.isNotEmpty &&
                  initialPositionSnapshot.connectionState ==
                      ConnectionState.done) {
                selectedStation = initialPositionSnapshot.hasData
                    ? nearestStation(
                        selectableStations,
                        initialPositionSnapshot.data!,
                      )
                    : selectableStations.first;
              }

              return LayoutBuilder(
                builder: (context, constraints) => _buildScaffold(
                  context,
                  constraints,
                  stations,
                ),
              );
            },
          ),
        ),
      );

  Widget _buildScaffold(
    BuildContext context,
    BoxConstraints constraints,
    core.Map<StationId, Station> stations,
  ) {
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
          : stations[station.tideCurrentStationId],
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
                  child: Stack(
                    children: [
                      Map(
                        client: widget.wmsClient,
                        tileCache: widget.tileCache,
                        stations: stations,
                        selectedStation: selectedStation,
                        stationPriority: stationPriority,
                        onStationSelected: (station) =>
                            setState(() => selectedStation = station),
                        locationEnabled: locationEnabled,
                        onLocationRequest: canRequestLocation
                            ? requestLocationPermission
                            : null,
                      ),
                      if (hasModal)
                        // ignore: prefer_const_constructors
                        PointerInterceptor(
                          child: const SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        )
                    ],
                  ),
                ),
                if (selectedStation != null)
                  SizedBox(
                    width: horizontal
                        ? min(
                            constraints.maxWidth / 2,
                            TidePanel.defaultGraphWidth,
                          )
                        : constraints.maxWidth,
                    child: _Panel(
                      tripPlannerClient: widget.tripPlannerClient,
                      horizontal: horizontal,
                      selectedStation: selectedStation!,
                      tideCurrentStation: tideCurrentStation,
                      timeWindow: timeWindow,
                      onTimeWindowChanged: (timeWindow) =>
                          setState(() => this.timeWindow = timeWindow),
                      onPanelChanged: (panel) =>
                          // Flipping
                          SchedulerBinding.instance.scheduleTask(
                        () => setState(
                          () => stationPriority = (type) =>
                              panel == DetailsPanel
                                  ? (type.isTideCurrent ? 0 : 1)
                                  : (type.isTideCurrent ? 1 : 0),
                        ),
                        Priority.animation - 1,
                      ),
                      onModal: (modal) => setState(() => hasModal = modal),
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

class _Panel extends StatefulWidget {
  _Panel({
    required this.tripPlannerClient,
    required this.horizontal,
    required this.selectedStation,
    this.tideCurrentStation,
    required this.timeWindow,
    this.onTimeWindowChanged,
    this.onPanelChanged,
    this.onModal,
  });

  final TripPlannerClient tripPlannerClient;
  final bool horizontal;
  final Station selectedStation;
  final Station? tideCurrentStation;
  final GraphTimeWindow timeWindow;
  final void Function(GraphTimeWindow timeWindow)? onTimeWindowChanged;
  final void Function(Type panel)? onPanelChanged;
  final void Function(bool modal)? onModal;

  late final List<Type> tabs = [
    if (tideCurrentStation != null) TidePanel,
    DetailsPanel
  ];

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<_Panel> with TickerProviderStateMixin {
  late TabController tabController;

  void _firePanelChanged() {
    widget.onPanelChanged!(widget.tabs[tabController.index]);
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );

    if (widget.onPanelChanged != null) {
      tabController.addListener(_firePanelChanged);
      scheduleMicrotask(_firePanelChanged);
    }
  }

  @override
  void didUpdateWidget(covariant _Panel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) {
      int delta = widget.tabs.length - oldWidget.tabs.length;
      final oldTab = oldWidget.tabs[tabController.index];

      tabController = TabController(
        length: widget.tabs.length,
        initialIndex: max(tabController.index + delta, 0),
        vsync: this,
      );

      if (widget.onPanelChanged != null) {
        tabController.addListener(_firePanelChanged);
        if (widget.tabs[tabController.index] != oldTab) {
          scheduleMicrotask(_firePanelChanged);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final viewport = TabBarView(
      controller: tabController,
      children: [
        if (widget.tideCurrentStation != null)
          TidePanel(
            client: widget.tripPlannerClient,
            station: widget.tideCurrentStation!,
            timeWindow: widget.timeWindow,
            onTimeWindowChanged: widget.onTimeWindowChanged,
            onModal: widget.onModal,
          ),
        DetailsPanel(
          client: widget.tripPlannerClient,
          station: widget.selectedStation,
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
              tabs: [
                if (widget.tideCurrentStation != null) const Text('Tides'),
                const Text('Details')
              ],
            ),
          ),
          widget.horizontal
              ? Expanded(child: viewport)
              : LayoutBuilder(
                  builder: (context, boxConstraints) => SizedBox(
                    height: TidePanel.estimateHeight(
                      context,
                      boxConstraints.maxWidth,
                    ),
                    child: viewport,
                  ),
                ),
        ],
      ),
    );
  }
}
