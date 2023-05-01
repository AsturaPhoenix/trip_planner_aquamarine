import 'dart:async';
import 'dart:core';
import 'dart:core' as core;
import 'dart:developer' as debug;

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart';

import 'persistence/blob_cache.dart';
import 'persistence/cache_box.dart';
import 'platform/location.dart' as location;
import 'platform/orientation.dart' as orientation;
import 'providers/ofs_client.dart';
import 'providers/trip_planner_client.dart';
import 'util/distance.dart';
import 'util/http.dart';
import 'util/optional.dart';
import 'widgets/compass.dart';
import 'widgets/details_panel.dart';
import 'widgets/iterative_flex.dart';
import 'widgets/map.dart';
import 'widgets/plot_panel.dart';
import 'widgets/tide_panel.dart';

late SharedPreferences sharedPreferences;

void initializeLogger() => Logger.root.onRecord.listen(
      (record) => debug.log(
        '${record.level.name}: ${record.time}: ${record.message}',
        name: record.loggerName,
        error: record.error,
        stackTrace: record.stackTrace,
      ),
    );

Future<T> Function() retryOnDemand<T>(Future<T> Function() fn) {
  Future<T>? cached;

  Future<T> evaluate() async {
    try {
      return fn();
    } on Object {
      cached = null;
      rethrow;
    }
  }

  cached = evaluate();

  return () => cached ??= evaluate();
}

void main() async => runApp(await TripPlanner.main());

class TripPlanner extends StatefulWidget {
  /// Loads global prerequisites. This method may be called multiple timesd in
  /// testing.
  static Future<void> initAsyncGlobals() => Future.wait([
        orientation.prefetchCapabilities(),
        SharedPreferences.getInstance()
            .then((instance) => sharedPreferences = instance)
      ]);

  // tp.js: show_hide_marker
  static const tideCurrentPriorityFilter = [
        _tideCurrentFilter,
        _launchDestinationFilter,
        _nogoFilter,
      ],
      launchDestinationPriorityFilter = [
        _launchDestinationFilter,
        _tideCurrentFilter,
        _nogoFilter,
      ];

  static bool _tideCurrentFilter(Station station) =>
      const {StationType.tide, StationType.current}.contains(station.type) &&
      !station.isLegacy;

  static bool _launchDestinationFilter(Station station) => const {
        StationType.launch,
        StationType.destination
      }.contains(station.type);

  static bool _nogoFilter(Station station) => station.type == StationType.nogo;

  static Future<TripPlanner> main() async {
    initializeLogger();

    final prefetch = TripPlanner.initAsyncGlobals();

    initializeTimeZones();

    final client = http.Client();

    final Future<Uri> Function() tripPlannerUrl;
    final Uri ofsUrl;
    const alphaServer = '34.83.198.158';

    // Gate on !kReleaseMode rather than kDebugMode to make development easier
    // by allowing profile builds to use a local override.
    if (kIsWeb && !kReleaseMode) {
      tripPlannerUrl = () async =>
          (await client.test(Uri.http('localhost', '/trip_planner/'))) ??
          Uri.http(alphaServer, '/trip_planner/');
      ofsUrl = (await client.test(Uri.http('localhost:1080'))) ??
          Uri.http('$alphaServer:1080');
    } else {
      tripPlannerUrl = () => client.resolveRedirects(
            kIsWeb
                ? Uri(path: '/trip_planner/')
                : Uri.https('www.bask.org', '/trip_planner/'),
          );
      ofsUrl = Uri.http('$alphaServer:1080');
    }

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
            blobs > 250 ||
            blobs > 50 && metadata.lastAccess.isBefore(softExpiry),
      ),
    );
    tileCache.then(
      (cache) => cache.evict(
        (blobs, metadata) =>
            // approx. 50 MB @ 100 kB ea.
            blobs > 500 ||
            blobs > 50 && metadata.lastAccess.isBefore(softExpiry),
      ),
    );

    await prefetch;

    return TripPlanner(
      tripPlannerClient: TripPlannerClient(
        await stationCache,
        await tideGraphCache,
        retryOnDemand(
          () async => TripPlannerHttpClient(client, await tripPlannerUrl()),
        ),
        TimeZone.forId('America/Los_Angeles'),
      ),
      client: client,
      tileCache: await tileCache,
      ofsClient: OfsClient(client, ofsUrl),
    );
  }

  const TripPlanner({
    super.key,
    required this.tripPlannerClient,
    required this.client,
    required this.tileCache,
    required this.ofsClient,
  });

  final TripPlannerClient tripPlannerClient;
  final http.Client client;
  final BlobCache tileCache;
  final OfsClient ofsClient;

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

  final _mapKey = GlobalKey(), _panelKey = GlobalKey();

  final mapController = MapController();
  late GraphTimeWindow timeWindow =
      GraphTimeWindow.now(widget.tripPlannerClient.timeZone);
  final distanceSystem = ValueNotifier(
    DistanceSystem
        .values[sharedPreferences.getInt(distanceSystemSettingKey) ?? 0],
  );
  var stations = <StationId, Station>{};
  StreamSubscription? _stationsSubscription;
  var tracks = <Track>[];

  StationFilters stationFilters = TripPlanner.tideCurrentPriorityFilter;

  Iterable<Station> get selectableStations =>
      stations.values.where(stationFilters.isStationVisible);

  Station? get selectedStation => mapController.selectedStation.value;
  Station? get tideCurrentStation => Optional(selectedStation).map(
        (station) => station.type.isTideCurrent
            ? station
            : stations[station.tideCurrentStationId],
      );

  bool locationEnabled = false;
  late CancelableOperation<void> getInitialPosition;
  Position? _initialPosition;

  void _maybeCompleteInitialStationSelection() {
    // The underlying flutter_map controller needs to be bound to a map, which
    // happens in a build method, so wrap this in a post-frame callback just
    // in case we somehow get stations and a GPS lock before the widget tree
    // manages to build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted &&
          selectedStation == null &&
          getInitialPosition.isCompleted &&
          selectableStations.isNotEmpty) {
        mapController.selectStation(
          _initialPosition != null
              ? nearestStation(selectableStations, _initialPosition!)
              : selectableStations.first,
          mayUnlock: false,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
    ).then(
      (position) => _initialPosition = position,
      onError: (e, s) => log.warning('Failed to get initial position', e, s),
    )..then((_) => _maybeCompleteInitialStationSelection());

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
    assert(widget.client == oldWidget.client);
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
    mapController.dispose();
    widget.client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapPanel = Map(
      key: _mapKey,
      client: widget.client,
      tileCache: widget.tileCache,
      ofsClient: widget.ofsClient,
      stations: stations,
      stationFilters: stationFilters,
      tracks: tracks,
      timeWindow: timeWindow,
      controller: mapController,
    );

    return MaterialApp(
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
        builder: (context, constraints) {
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
              title: ListenableBuilder(
                listenable: mapController.selectedStation,
                builder: (context, _) => Row(
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
            body: ListenableBuilder(
              listenable: mapController.selectedStation,
              builder: (context, _) => Column(
                children: [
                  if (selectedStation != null && !inlineStationBar)
                    _SelectedStationBar(
                      selectedStation!,
                      blendEdges: false,
                    ),
                  Expanded(
                    child: horizontal
                        ? Row(
                            children: [
                              Expanded(child: mapPanel),
                              if (selectedStation != null)
                                SizedBox(
                                  width: min(
                                    constraints.maxWidth / 2,
                                    TidePanel.defaultGraphWidth,
                                  ),
                                  child:
                                      _Panel(key: _panelKey, tripPlanner: this),
                                ),
                            ],
                          )
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final defaultPanelHeight = min(
                                _Panel.estimateHeight(
                                  context,
                                  constraints.maxWidth,
                                ),
                                constraints.maxHeight,
                              );

                              final minMapHeight =
                                  constraints.maxHeight - defaultPanelHeight;

                              final defaultPosition =
                                  defaultPanelHeight / constraints.maxHeight;
                              final minimizedPosition =
                                  _Panel.tabBarHeight / constraints.maxHeight;

                              return IterativeColumn(
                                children: [
                                  IterativeFlexible(
                                    pass: 1,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) =>
                                          OverflowBox(
                                        alignment: Alignment.topLeft,
                                        minHeight: minMapHeight,
                                        maxHeight: max(
                                          minMapHeight,
                                          constraints.maxHeight,
                                        ),
                                        child: mapPanel,
                                      ),
                                    ),
                                  ),
                                  if (selectedStation != null)
                                    DraggableScrollableSheet(
                                      initialChildSize: defaultPosition,
                                      minChildSize: minimizedPosition,
                                      snap: true,
                                      snapSizes: [defaultPosition],
                                      expand: false,
                                      builder: (context, scrollController) =>
                                          CustomScrollView(
                                        controller: scrollController,
                                        // We need to disable scrolling
                                        // explicitly since we're telling the
                                        // sliver below to stay at least as
                                        // large as the estimated tide graph
                                        // height. Otherwise, when the sheet is
                                        // collapsed, other scroll methods such
                                        // as mouse wheel can scroll the sheet
                                        // content without expanding the sheet.
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollBehavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(scrollbars: false),
                                        slivers: [
                                          SliverFillRemaining(
                                            // Allow the SizedBox to act as a
                                            // sort of min height beyond which
                                            // to clip the panel while also
                                            // allowing it to expand.
                                            hasScrollBody: false,
                                            child: SizedBox(
                                              height: defaultPanelHeight,
                                              child: _Panel(
                                                key: _panelKey,
                                                tripPlanner: this,
                                                scrollController:
                                                    scrollController,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
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
  static const tabBarHeight = 48.0;
  static double estimateHeight(BuildContext context, double maxWidth) =>
      tabBarHeight + TidePanel.estimateHeight(context, maxWidth);

  _Panel({super.key, required this.tripPlanner, this.scrollController})
      : selectedStation = tripPlanner.selectedStation!,
        tabs = [
          if (tripPlanner.tideCurrentStation != null) TidePanel,
          DetailsPanel,
          PlotPanel,
        ];

  final TripPlannerState tripPlanner;
  final ScrollController? scrollController;

  // Cache a copy of the selected station so we know when it changes. This
  // supports changing the panel to the details panel if a nogo station is
  // selected. However, this differs from the behavior of the web trip planner,
  // where clicking on a nogo area always switches to the info panel even if the
  // area was already selected. If we want to do that, we would probably want to
  // hoist the tab controller into the trip planner, but we'd need to think more
  // carefully about where then to manage which tabs are available.
  final Station selectedStation;
  final List<Type> tabs;

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<_Panel> with SingleTickerProviderStateMixin {
  late TabController tabController;
  // This is needed to persist plot panel state between states with different
  // available tabs, such as between station selections with and without
  // tide/current information.
  final plotPanelKey = GlobalKey();

  TripPlannerState get tripPlanner => widget.tripPlanner;

  void _onPanelChanged() {
    // In any case but the case of direct user interaction, this is likely to be
    // called during a parent build, during which we're not allowed to change
    // tripPlanner state, so always schedule a microtask for simplicity.
    scheduleMicrotask(() {
      final stationFilters = const {
        TidePanel: TripPlanner.tideCurrentPriorityFilter,
        DetailsPanel: TripPlanner.launchDestinationPriorityFilter,
      }[widget.tabs[tabController.index]];

      if (stationFilters != null &&
          stationFilters != tripPlanner.stationFilters) {
        tripPlanner.setState(() => tripPlanner.stationFilters = stationFilters);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: widget.selectedStation.type == StationType.nogo
          ? widget.tabs.indexOf(DetailsPanel)
          : 0,
      length: widget.tabs.length,
      vsync: this,
    );

    tabController.addListener(_onPanelChanged);
    _onPanelChanged();
  }

  @override
  void didUpdateWidget(covariant _Panel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) {
      final int delta = widget.tabs.length - oldWidget.tabs.length;
      final oldTab = oldWidget.tabs[tabController.index];

      tabController.dispose();
      tabController = TabController(
        length: widget.tabs.length,
        initialIndex: widget.selectedStation.type == StationType.nogo
            ? widget.tabs.indexOf(DetailsPanel)
            : max(tabController.index + delta, 0),
        vsync: this,
      );

      tabController.addListener(_onPanelChanged);
      if (widget.tabs[tabController.index] != oldTab) {
        _onPanelChanged();
      }
    } else if (widget.selectedStation != oldWidget.selectedStation &&
        widget.selectedStation.type == StationType.nogo) {
      tabController.animateTo(widget.tabs.indexOf(DetailsPanel));
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
                if (tripPlanner.tideCurrentStation != null)
                  const Tab(text: 'Tides'),
                const Tab(text: 'Details'),
                const Tab(text: 'Plot'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                if (tripPlanner.tideCurrentStation != null)
                  TidePanel(
                    client: tripPlanner.widget.tripPlannerClient,
                    station: tripPlanner.tideCurrentStation!,
                    timeWindow: tripPlanner.timeWindow,
                    onTimeWindowChanged: (timeWindow) => tripPlanner
                        .setState(() => tripPlanner.timeWindow = timeWindow),
                  ),
                DetailsPanel(
                  client: tripPlanner.widget.tripPlannerClient,
                  station: widget.selectedStation,
                  scrollController: widget.scrollController,
                ),
                PlotPanel(
                  key: plotPanelKey,
                  timeZone: tripPlanner.timeWindow.t.timeZone,
                  distanceSystem: tripPlanner.distanceSystem,
                  tracks: tripPlanner.tracks,
                  scrollController: widget.scrollController,
                  onTracksChanged: (tracks) =>
                      tripPlanner.setState(() => tripPlanner.tracks = tracks),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
