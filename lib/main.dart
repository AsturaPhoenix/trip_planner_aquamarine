import 'dart:async';
import 'dart:core';
import 'dart:core' as core;
import 'dart:developer' as debug;

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart';

import 'persistence/blob_cache.dart';
import 'persistence/cache_box.dart';
import 'platform/location.dart' as location;
import 'platform/orientation.dart' as orientation;
import 'providers/trip_planner_client.dart';
import 'util/distance.dart';
import 'util/optional.dart';
import 'widgets/compass.dart';
import 'widgets/details_panel.dart';
import 'widgets/map.dart';
import 'widgets/plot_panel.dart';
import 'widgets/tide_panel.dart';

late final SharedPreferences sharedPreferences;

void main() async {
  Logger.root.onRecord.listen(
    (record) => debug.log(
      '${record.level.name}: ${record.time}: ${record.message}',
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    ),
  );

  final prefetch = Future.wait([
    orientation.prefetchCapabilities(),
    SharedPreferences.getInstance()
        .then((instance) => sharedPreferences = instance)
  ]);

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

  await prefetch;

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

class TripPlannerState extends State<TripPlanner> {
  static const distanceSystemSettingKey = 'distanceSystem';

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
  final distanceSystem = ValueNotifier(
    DistanceSystem
        .values[sharedPreferences.getInt(distanceSystemSettingKey) ?? 0],
  );
  var stations = <StationId, Station>{};
  StreamSubscription? _stationsSubscription;
  var tracks = <Track>[];

  Iterable<Station> get selectableStations => stations.values
      .where((station) => Map.showMarkerTypes.contains(station.type));

  Station? get tideCurrentStation => Optional(selectedStation).map(
        (station) => station.type.isTideCurrent
            ? station
            : stations[station.tideCurrentStationId],
      );

  bool locationEnabled = false;
  late CancelableOperation<void> getInitialPosition;
  Position? _initialPosition;

  double Function(StationType)? stationPriority;

  bool hasModal = false;

  void _maybeCompleteInitialStationSelection() {
    if (mounted &&
        selectedStation == null &&
        getInitialPosition.isCompleted &&
        selectableStations.isNotEmpty) {
      setState(
        () => selectedStation = _initialPosition != null
            ? nearestStation(selectableStations, _initialPosition!)
            : selectableStations.first,
      );
    }
  }

  @override
  void initState() {
    super.initState;
    updateClient();

    final cancel = StreamCloser<Position?>();
    getInitialPosition = CancelableOperation.fromFuture(
      (kIsWeb
              ? location.passivePosition.seededStream
              : location.requestedPosition)
          .timeout(const Duration(seconds: 10))
          .transform(cancel)
          .first,
      onCancel: cancel.close,
    ).then((position) => _initialPosition = position)
      ..then((_) => _maybeCompleteInitialStationSelection());

    distanceSystem.addListener(
      () => sharedPreferences.setInt(
        distanceSystemSettingKey,
        distanceSystem.value.index,
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
    _stationsSubscription?.cancel();
    _stationsSubscription = widget.tripPlannerClient
        .getDatapoints()
        .handleError(
          (e, StackTrace s) => log.warning('Failed to get station list.', e, s),
        )
        .listen((stations) {
      if (stations.isNotEmpty) {
        setState(() => this.stations = stations);
        _maybeCompleteInitialStationSelection();
      }
    });
  }

  @override
  void dispose() {
    widget.tripPlannerClient.close();
    getInitialPosition.cancel();
    _stationsSubscription?.cancel();
    distanceSystem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BASK Trip Planner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffbbccff),
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
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected)
                  ? const Color(0xb0000000)
                  : null,
            ),
          ),
        ),
        home: LayoutBuilder(
          builder: (context, constraints) => (
            BuildContext context,
            BoxConstraints constraints,
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
                actions: [
                  if (orientation.isOrientationAvailable)
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          allowSnapshotting: false,
                          builder: (context) => Compass(
                            waypoint: selectedStation,
                            distanceSystem: distanceSystem,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.explore),
                      tooltip: 'Compass',
                    )
                ],
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
                                tracks: tracks,
                                stationPriority: stationPriority,
                                onStationSelected: (station) =>
                                    setState(() => selectedStation = station),
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
                              tripPlanner: this,
                              horizontal: horizontal,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }(
            context,
            constraints,
          ),
        ),
      );
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
  _Panel({required this.tripPlanner, required this.horizontal});

  final TripPlannerState tripPlanner;
  final bool horizontal;

  late final List<Type> tabs = [
    if (tripPlanner.tideCurrentStation != null) TidePanel,
    DetailsPanel,
    PlotPanel,
  ];

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<_Panel> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final tabBarViewKey = GlobalKey(),
      // This is needed to persist plot panel state between states with
      // different available tabs, such as between station selections with and
      // without tide/current information.
      plotPanelKey = GlobalKey();

  TripPlannerState get tripPlanner => widget.tripPlanner;

  void _onPanelChanged() {
    final panel = widget.tabs[tabController.index];
    // Flipping marker z indices is relatively expensive, so defer while
    // animations are in progress.
    SchedulerBinding.instance.scheduleTask(
      () => setState(
        () => tripPlanner.stationPriority = (type) => panel == DetailsPanel
            ? (type.isTideCurrent ? 0 : 1)
            : (type.isTideCurrent ? 1 : 0),
      ),
      Priority.animation - 1,
    );
  }

  void _onModal(bool modal) =>
      tripPlanner.setState(() => tripPlanner.hasModal = modal);

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );

    tabController.addListener(_onPanelChanged);
    scheduleMicrotask(_onPanelChanged);
  }

  @override
  void didUpdateWidget(covariant _Panel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) {
      int delta = widget.tabs.length - oldWidget.tabs.length;
      final oldTab = oldWidget.tabs[tabController.index];

      tabController.dispose();
      tabController = TabController(
        length: widget.tabs.length,
        initialIndex: max(tabController.index + delta, 0),
        vsync: this,
      );

      tabController.addListener(_onPanelChanged);
      if (widget.tabs[tabController.index] != oldTab) {
        scheduleMicrotask(_onPanelChanged);
      }
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final viewport = TabBarView(
      key: tabBarViewKey,
      controller: tabController,
      children: [
        if (tripPlanner.tideCurrentStation != null)
          TidePanel(
            client: tripPlanner.widget.tripPlannerClient,
            station: tripPlanner.tideCurrentStation!,
            timeWindow: tripPlanner.timeWindow,
            onTimeWindowChanged: (timeWindow) =>
                tripPlanner.setState(() => tripPlanner.timeWindow = timeWindow),
            onModal: _onModal,
          ),
        DetailsPanel(
          client: tripPlanner.widget.tripPlannerClient,
          station: tripPlanner.selectedStation!,
        ),
        PlotPanel(
          key: plotPanelKey,
          timeZone: tripPlanner.timeWindow.t.timeZone,
          distanceSystem: tripPlanner.distanceSystem,
          tracks: tripPlanner.tracks,
          onTracksChanged: (tracks) =>
              tripPlanner.setState(() => tripPlanner.tracks = tracks),
          onModal: _onModal,
        ),
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
                if (tripPlanner.tideCurrentStation != null) const Text('Tides'),
                const Text('Details'),
                const Text('Plot'),
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
