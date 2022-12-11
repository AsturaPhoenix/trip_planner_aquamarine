import 'dart:async';
import 'dart:core';
import 'dart:core' as core;
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../main.dart' show canRequestLocation;
import '../persistence/blob_cache.dart';
import '../platform/orientation.dart' as orientation;
import '../providers/trip_planner_client.dart';
import '../providers/wms_tile_provider.dart';
import '../util/optional.dart';

class Map extends StatefulWidget {
  static const minZoom = 0, maxZoom = 22;
  static const initialCameraPosition = CameraPosition(
    // Center map on Alcatraz, to show the interesting points around the Bay.
    target: LatLng(37.8331, -122.4165),
    zoom: 12,
  );

  // TODO: make this configurable
  static const showMarkerTypes = {
    StationType.tide,
    StationType.current,
    StationType.launch,
    StationType.destination,
  };

  Map({
    super.key,
    required this.client,
    required this.tileCache,
    this.stations = const {},
    this.selectedStation,
    double Function(StationType type)? stationPriority,
    this.onStationSelected,
    this.locationEnabled = false,
    this.onLocationRequest,
  }) : stationPriority =
            stationPriority ?? ((type) => type.isTideCurrent ? 1 : 0);

  final http.Client client;
  final BlobCache tileCache;
  final core.Map<StationId, Station> stations;
  final Station? selectedStation;

  final double Function(StationType type) stationPriority;
  final void Function(Station station)? onStationSelected;

  final bool locationEnabled;
  final Future<bool> Function()? onLocationRequest;

  @override
  MapState createState() => MapState();
}

class TileOverlayConfiguration<T extends TileProvider> {
  final TileOverlayId id;
  final T tileProvider;
  TileOverlayConfiguration(String id, this.tileProvider)
      : id = TileOverlayId(id);
}

class _MarkerIcons {
  _MarkerIcons({
    required this.stations,
    required this.selected,
    required this.tcSelected,
    required this.location,
  });
  final core.Map<StationType, BitmapDescriptor> stations;

  /// Halo for the selected location.
  final BitmapDescriptor selected,

      /// Halo for a nearby tide/current station, when the selected location is
      /// not tide/current.
      tcSelected,
      location;
}

enum PrecachedAsset {
  compass(AssetImage('assets/compass.png')),
  locationReticle(AssetImage('assets/location_reticle.png')),
  locationNorth(AssetImage('assets/location_north.png')),
  compassDirections(AssetImage('assets/compass_directions.png')),
  compassIndicator(AssetImage('assets/compass_indicator.png'));

  const PrecachedAsset(this.image);
  final ImageProvider image;
}

/// I'm not sure there's an official source, but this seems to be a consensus
/// format for reporting to the Coast Guard.
String formatPosition(Position position) {
  String formatPolar(
    double polar,
    String positiveSuffix,
    String negativeSuffix,
  ) =>
      "${polar.abs().truncate()}° ${(polar.abs() % 1 * 60).toStringAsFixed(2)}'"
      ' ${polar >= 0 ? positiveSuffix : negativeSuffix}';
  return '${formatPolar(position.latitude, 'N', 'S')}, '
      '${formatPolar(position.longitude, 'E', 'W')}';
}

class MarkerClass {
  static const double selection = 1, station = 3, currentLocation = 10;
}

extension on CameraPosition {
  CameraPosition copyWith({
    double? bearing,
    LatLng? target,
    double? tilt,
    double? zoom,
  }) =>
      CameraPosition(
        bearing: bearing ?? this.bearing,
        target: target ?? this.target,
        tilt: tilt ?? this.tilt,
        zoom: zoom ?? this.zoom,
      );
}

extension on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

class MapState extends State<Map> with SingleTickerProviderStateMixin {
  static final log = Logger('MapState');

  late final chartOverlays = [
    TileOverlayConfiguration(
      'nautical',
      WmsTileProvider(
        client: widget.client,
        cache: widget.tileCache,
        tileType: 'nautical',
        url: Uri.parse(
          'https://gis.charttools.noaa.gov/arcgis/rest/services/MCS/NOAAChartDisplay/MapServer/exts/MaritimeChartService/WMSServer',
        ),
        fetchLod: 2,
        levelOfDetail: 14,
        params: WmsParams()
          ..version = '1.3.0'
          ..layers = '0,1,2,3,4,5,6,7',
      ),
    )
  ];
  GoogleMapController? gmap;

  int chartOverlayIndex = 0;
  TileOverlayConfiguration<WmsTileProvider> get chartOverlay =>
      chartOverlays[chartOverlayIndex];

  void _setLod(int lod) => setState(() {
        for (final overlay in chartOverlays) {
          overlay.tileProvider.levelOfDetail = lod;
          // TODO: This does not cancel inflight requests, which can leave stale tiles.
          gmap!.clearTileCache(overlay.id);
        }
      });

  Future<_MarkerIcons>? _markerIcons;

  Position? devicePosition;
  // TODO: suspend on screen off
  StreamSubscription? positionSubscription, bearingSubscription;
  TrackingMode _trackingMode = TrackingMode.location;
  TrackingMode get trackingMode => _trackingMode;
  CameraPosition cameraPosition = Map.initialCameraPosition;
  late MapAnimationController mapAnimation = MapAnimationController(
    tickerProvider: this,
    cameraPosition: Map.initialCameraPosition,
    moveCamera: (cameraPosition) async {
      await gmap?.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() => this.cameraPosition = cameraPosition);
    },
  );
  set trackingMode(TrackingMode value) {
    if (value != _trackingMode) {
      if (_trackingMode == TrackingMode.bearing) {
        bearingSubscription!.cancel();
        bearingSubscription = null;
      }

      _trackingMode = value;

      if (value == TrackingMode.bearing) {
        orientation.updateInterval = const Duration(microseconds: 100000 ~/ 6);
        bearingSubscription = orientation
            .withGeomagneticCorrection(
          orientation.wrapWithPositionFunction(
            orientation.bearing,
            () => devicePosition,
          ),
        )
            .listen(
          (bearing) {
            if (bearing.geomagneticCorrection != null) {
              mapAnimation.add(
                PartialCameraPosition(
                  bearing: bearing.value + bearing.geomagneticCorrection!.dec,
                ),
              );
            }
          },
        );
      }
    }
  }

  void subscribeToPosition() {
    positionSubscription = Geolocator.getPositionStream().listen(
      updateDevicePosition,
      onError: (_) => setState(() => devicePosition = null),
    );
  }

  void updateDevicePosition(Position position) {
    setState(() => devicePosition = position);
    if (trackingMode != TrackingMode.free) {
      animateTrackingCamera();
    }
  }

  void animateTrackingCamera() => mapAnimation.add(
        PartialCameraPosition(
          target: devicePosition!.toLatLng(),
          bearing: trackingMode == TrackingMode.bearing ? null : 0,
        ),
      );

  // For the most part this isn't called for moveCamera, but there are cases
  // where it is.
  void updateCameraPosition(CameraPosition newPosition) {
    // A full screen-space mapping uses the message channel and can interleave
    // with animation frames and produce an invalid result, so take advantage of
    // the Mercator projection and compute it here.
    Offset toRelativeScreenSpace(LatLng latlng, double zoom) =>
        Offset(
          latlng.longitude,
          -math.log(math.tan((90 + latlng.latitude) * math.pi / 360)),
        ) *
        (WmsTileProvider.logicalTileSize * math.pow(2, zoom) / 360);

    const pixelSquaredTolerance = .25;

    final cmpZoom = math.min(newPosition.zoom, cameraPosition.zoom);
    if ((toRelativeScreenSpace(cameraPosition.target, cmpZoom) -
                toRelativeScreenSpace(newPosition.target, cmpZoom))
            .distanceSquared >
        pixelSquaredTolerance) {
      setState(() {
        trackingMode = TrackingMode.free;
        cameraPosition = newPosition;
        mapAnimation.override(newPosition);
      });
    }
  }

  void animateToSelectedStation() {
    mapAnimation
        .set(PartialCameraPosition(target: widget.selectedStation!.marker));
  }

  @override
  void initState() {
    super.initState();
    if (widget.locationEnabled) {
      subscribeToPosition();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final asset in PrecachedAsset.values) {
      precacheImage(asset.image, context);
    }

    Future<BitmapDescriptor> loadAsset(
      String type,
      ImageConfiguration imageConfiguration,
    ) =>
        BitmapDescriptor.fromAssetImage(
          imageConfiguration,
          'assets/markers/$type.png',
          mipmaps: false,
        );

    final defaultConfiguration = createLocalImageConfiguration(context);
    final stations = [
      for (final stationType in Map.showMarkerTypes)
        loadAsset(stationType.name, defaultConfiguration)
    ];

    final selConfiguration =
        defaultConfiguration.copyWith(size: const Size(22, 21));
    final selected = loadAsset('sel', selConfiguration);
    final tcSelected = loadAsset('tc_sel', selConfiguration);

    final location = BitmapDescriptor.fromAssetImage(
      defaultConfiguration,
      'assets/markers/location.png',
    );

    _markerIcons = (() async => _MarkerIcons(
          stations: core.Map.fromIterables(
            Map.showMarkerTypes,
            await Future.wait(stations),
          ),
          selected: await selected,
          tcSelected: await tcSelected,
          location: await location,
        ))();

    final maxOversample =
        2 + (defaultConfiguration.devicePixelRatio?.floor() ?? 1) - 1;
    for (final overlay in chartOverlays) {
      overlay.tileProvider.maxOversample = maxOversample;
    }
  }

  @override
  void didUpdateWidget(covariant Map oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (final overlay in chartOverlays) {
      overlay.tileProvider.client = widget.client;
      overlay.tileProvider.cache = widget.tileCache;
    }

    if (widget.locationEnabled && !oldWidget.locationEnabled) {
      subscribeToPosition();
    } else if (oldWidget.locationEnabled && !widget.locationEnabled) {
      positionSubscription?.cancel();
      positionSubscription = null;
      devicePosition = null;
    }

    if (widget.selectedStation != null &&
        oldWidget.selectedStation == null &&
        gmap != null &&
        (trackingMode == TrackingMode.free || !widget.locationEnabled)) {
      animateToSelectedStation();
    }
  }

  @override
  void dispose() {
    super.dispose();
    positionSubscription?.cancel();
    bearingSubscription?.cancel();
    gmap?.dispose();
    for (final overlay in chartOverlays) {
      overlay.tileProvider.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tileSize = (MediaQuery.of(context).devicePixelRatio *
            WmsTileProvider.logicalTileSize)
        .ceil();

    for (final overlay in chartOverlays) {
      overlay.tileProvider.preferredTileSize = tileSize;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder(
          future: _markerIcons,
          builder: (context, iconsSnapshot) {
            final markers = <Marker>{};

            if (iconsSnapshot.hasData) {
              final markerIcons = iconsSnapshot.data!;

              if (devicePosition != null) {
                const markerId = MarkerId('current location');
                markers.add(
                  Marker(
                    markerId: markerId,
                    anchor: const Offset(.5, .5),
                    position: devicePosition!.toLatLng(),
                    icon: markerIcons.location,
                    // TODO: This text does not update while the info window is
                    // shown.
                    infoWindow: InfoWindow(
                      title: formatPosition(devicePosition!),
                      onTap: kIsWeb
                          ? null
                          : () => gmap!.hideMarkerInfoWindow(markerId),
                    ),
                    // Take precedence over other markers.
                    zIndex: MarkerClass.currentLocation,
                    onTap: () {
                      setState(() => trackingMode = TrackingMode.location);
                      // Although the map will automatically animate, start an
                      // explicit animation so we don't have to try to ignore
                      // the onCameraMove events.
                      animateTrackingCamera();
                    },
                  ),
                );
              }

              // tp.js: show_hide_marker
              bool stationFilter(Station station) =>
                  Map.showMarkerTypes.contains(station.type) &&
                  !(station.type.isTideCurrent && station.isLegacy);

              for (final station
                  in widget.stations.values.where(stationFilter)) {
                final icon = markerIcons.stations[station.type];
                if (icon != null) {
                  // tp.js: create_station
                  final markerId = MarkerId(station.id.toString());
                  final visualMinor =
                      [station.isLegacy, station.isSubordinate].indexOf(true) %
                          3;
                  final visualMajor = widget.stationPriority(station.type);

                  markers.add(
                    Marker(
                      markerId: markerId,
                      position: station.marker,
                      alpha: (1 + visualMinor) / 3,
                      icon: icon,
                      infoWindow: InfoWindow(
                        title: station.typedShortTitle,
                        onTap: kIsWeb
                            ? null
                            : () => gmap!.hideMarkerInfoWindow(markerId),
                      ),
                      // In tp.js, this is 4 for current stations and 3 for
                      // everything else. However, on smaller screens we
                      // should try to keep touch response consistent with
                      // alpha.
                      zIndex:
                          MarkerClass.station + 3 * visualMajor + visualMinor,
                      onTap: () => widget.onStationSelected?.call(station),
                    ),
                  );
                }
              }

              // tp.js: create_sel_marker
              void createSelectionMarker(
                MarkerId id,
                BitmapDescriptor icon,
                LatLng? location,
              ) =>
                  markers.add(
                    Marker(
                      markerId: id,
                      anchor: const Offset(.5, .65),
                      icon: icon,
                      // tp.js: move_sel_marker
                      position: location ?? const LatLng(0, 0),
                      visible: location != null,
                      zIndex: MarkerClass.selection,
                    ),
                  );

              createSelectionMarker(
                const MarkerId('sel'),
                markerIcons.selected,
                widget.selectedStation?.marker,
              );

              createSelectionMarker(
                const MarkerId('tc_sel'),
                markerIcons.tcSelected,
                Optional(widget.selectedStation?.tideCurrentStationId)
                    .map((tcid) => widget.stations[tcid]?.marker),
              );
            }

            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: Map.initialCameraPosition,
              markers: markers,
              tileOverlays: {
                TileOverlay(
                  tileOverlayId: chartOverlay.id,
                  tileProvider: chartOverlay.tileProvider,
                  tileSize: tileSize,
                ),
              },
              compassEnabled: false,
              zoomControlsEnabled: false,
              onCameraMove: updateCameraPosition,
              onMapCreated: (controller) async {
                setState(() => gmap = controller);
                controller.setMapStyle(
                  await DefaultAssetBundle.of(context)
                      .loadString('assets/nautical-style.json'),
                );
                if (widget.selectedStation != null &&
                    (trackingMode == TrackingMode.free ||
                        !widget.locationEnabled)) {
                  animateToSelectedStation();
                }
              },
            );
          },
        ),
        if (gmap != null)
          Theme(
            data: ThemeData(
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade800,
                  fixedSize: const Size.square(40),
                  minimumSize: const Size.square(40),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                ),
              ),
              tooltipTheme: const TooltipThemeData(
                waitDuration: Duration(milliseconds: 600),
              ),
              dividerTheme: const DividerThemeData(
                color: Color(0xffe6e6e6),
                space: 1,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: MapControls(
                cameraPosition: cameraPosition,
                lod: chartOverlay.tileProvider.levelOfDetail,
                maxOversample: chartOverlay.tileProvider.maxOversample,
                trackingMode: trackingMode == TrackingMode.location
                    ? devicePosition == null
                        ? TrackingMode.free
                        : TrackingMode.location
                    : trackingMode,
                trackLocation: Optional(devicePosition).map(
                      (_) => () {
                        setState(() => trackingMode = TrackingMode.location);
                        animateTrackingCamera();
                      },
                    ) ??
                    Optional(widget.onLocationRequest).map(
                      (f) => () {
                        setState(() => trackingMode = TrackingMode.location);
                        f();
                        // Tracking will begin once location is enabled.
                      },
                    ),
                trackBearing: () =>
                    setState(() => trackingMode = TrackingMode.bearing),
                resetBearing: () =>
                    mapAnimation.set(PartialCameraPosition(bearing: 0)),
                zoomIn: () => mapAnimation.addDelta(CameraDelta(zoom: 1)),
                zoomOut: () => mapAnimation.addDelta(CameraDelta(zoom: -1)),
                setLod: _setLod,
              ),
            ),
          ),
      ],
    );
  }
}

class PartialCameraPosition {
  PartialCameraPosition({this.bearing, this.target, this.zoom});
  final double? bearing;
  final LatLng? target;
  final double? zoom;

  CameraDelta operator -(CameraPosition basis) => CameraDelta(
        bearing:
            bearing == null ? 0 : (bearing! - basis.bearing + 180) % 360 - 180,
        target: target == null
            ? const LatLng(0, 0)
            : LatLng(
                target!.latitude - basis.target.latitude,
                target!.longitude - basis.target.longitude,
              ),
        zoom: zoom == null ? 0 : zoom! - basis.zoom,
      );

  CameraPosition apply(CameraPosition original) =>
      original.copyWith(bearing: bearing, target: target, zoom: zoom);
}

class CameraDelta {
  CameraDelta({
    this.bearing = 0,
    this.target = const LatLng(0, 0),
    this.zoom = 0,
  });
  final double bearing;
  final LatLng target;
  final double zoom;

  CameraDelta operator +(CameraDelta other) => CameraDelta(
        bearing: bearing + other.bearing,
        target: LatLng(
          target.latitude + other.target.latitude,
          target.longitude + other.target.longitude,
        ),
        zoom: zoom + other.zoom,
      );

  CameraDelta operator *(double factor) => CameraDelta(
        bearing: bearing * factor,
        target: LatLng(target.latitude * factor, target.longitude * factor),
        zoom: zoom * factor,
      );
}

extension on CameraPosition {
  CameraPosition operator +(CameraDelta delta) => CameraPosition(
        bearing: (bearing + delta.bearing) % 360,
        target: LatLng(
          target.latitude + delta.target.latitude,
          target.longitude + delta.target.longitude,
        ),
        zoom: zoom + delta.zoom,
      );
}

class CameraAnimation {
  CameraAnimation({
    required this.delta,
    required this.start,
    required this.length,
    required this.curve,
  });
  final CameraDelta delta;
  final Duration start, length;
  Duration get end => start + length;
  final Curve curve;
  final completer = Completer<bool>();

  double normalize(Duration t) => t < start
      ? 0
      : t > end
          ? 1
          : (t - start).inMicroseconds / length.inMicroseconds;

  CameraDelta evaluate(Duration t) => delta * curve.transform(normalize(t));
}

class MapAnimationController {
  MapAnimationController({
    required TickerProvider tickerProvider,
    required CameraPosition cameraPosition,
    this.moveCamera,
  })  : _basis = cameraPosition,
        _target = cameraPosition {
    ticker = tickerProvider.createTicker(_onTick);
  }
  late final Ticker ticker;
  void Function(CameraPosition)? moveCamera;

  CameraPosition _basis, _target;
  late Duration t;

  bool get isActive => ticker.isActive;

  final activeAnimations = <CameraAnimation>{};

  void _start() {
    ticker.start();
    t = Duration.zero;
  }

  Future<bool> addDelta(
    CameraDelta delta, [
    Duration length = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  ]) {
    if (activeAnimations.isEmpty) {
      _start();
    }

    final animation = CameraAnimation(
      delta: delta,
      start: t,
      length: length,
      curve: curve,
    );
    activeAnimations.add(animation);

    _target += delta;
    return animation.completer.future;
  }

  Future<bool> add(
    PartialCameraPosition target, [
    Duration length = const Duration(milliseconds: 600),
    Curve curve = Curves.easeInOut,
  ]) {
    if (activeAnimations.isEmpty) {
      _start();
    }

    final animation = CameraAnimation(
      delta: target - _target,
      start: t,
      length: length,
      curve: curve,
    );
    activeAnimations.add(animation);

    _target = target.apply(_target);
    return animation.completer.future;
  }

  Future<bool> set(
    PartialCameraPosition target, [
    Duration length = const Duration(milliseconds: 600),
    Curve curve = Curves.easeInOut,
  ]) {
    if (activeAnimations.isEmpty) {
      _start();
    }

    final animation = CameraAnimation(
      delta: target - _target,
      start: t,
      length: length,
      curve: curve,
    );
    activeAnimations
      ..clear()
      ..add(animation);

    _target = target.apply(_target);
    return animation.completer.future;
  }

  void _onTick(Duration t) {
    this.t = t;
    final delta =
        activeAnimations.map((a) => a.evaluate(t)).reduce((a, b) => a + b);
    moveCamera?.call(_basis + delta);
    final completed = [...activeAnimations.where((a) => t >= a.end)];
    if (completed.isNotEmpty) {
      _basis += completed.map((a) => a.delta).reduce((a, b) => a + b);
      activeAnimations.removeAll(completed);
      if (activeAnimations.isEmpty) {
        ticker.stop();
      }
      for (final animation in completed) {
        animation.completer.complete(true);
      }
    }
  }

  void override(CameraPosition override) {
    ticker.stop(canceled: true);
    _basis = _target = override;
    for (final animation in activeAnimations) {
      animation.completer.complete(false);
    }
    activeAnimations.clear();
  }
}

extension on List<Widget> {
  List<Widget> delimit(Widget delimiter) => [
        ...[
          for (final e in this) ...[delimiter, e]
        ].skip(1)
      ];
}

enum TrackingMode { free, location, bearing }

class MapControls extends StatelessWidget {
  const MapControls({
    super.key,
    required this.cameraPosition,
    this.lod = 14,
    this.maxOversample = 0,
    this.trackingMode = TrackingMode.free,
    this.trackLocation,
    this.trackBearing,
    this.resetBearing,
    this.zoomIn,
    this.zoomOut,
    required this.setLod,
  });
  final CameraPosition cameraPosition;
  final int lod, maxOversample;
  final TrackingMode trackingMode;
  final void Function()? trackLocation, trackBearing, zoomIn, zoomOut;
  final FutureOr<void> Function()? resetBearing;
  final void Function(int lod) setLod;

  @override
  Widget build(BuildContext context) {
    final locationControls = LocationControls(
      cameraPosition: cameraPosition,
      trackingMode: trackingMode,
      trackLocation: trackLocation,
      trackBearing: trackBearing,
      resetBearing: resetBearing,
    );
    final zoomControls = MapButtonPanel(
      children: [
        Tooltip(
          message: 'Zoom in',
          child: TextButton(
            onPressed: cameraPosition.zoom < Map.maxZoom ? zoomIn : null,
            child: const Icon(Icons.add),
          ),
        ),
        Tooltip(
          message: 'Zoom out',
          child: TextButton(
            onPressed: cameraPosition.zoom > Map.minZoom ? zoomOut : null,
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
    final lodControls = LodControls(
      zoom: cameraPosition.zoom.toInt(),
      lod: lod,
      maxOversample: maxOversample,
      setLod: setLod,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        const double buttonHeight = 40,
            spacing = 10,
            divider = 1,
            logo = 26,
            notices = kIsWeb ? 14 : 0;
        final wrap = constraints.maxHeight <
            6 * buttonHeight + 2 * spacing + logo + 3 * divider;

        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: logo),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    locationControls,
                    zoomControls,
                    if (!wrap) lodControls
                  ].delimit(const SizedBox(height: spacing)),
                ),
              ),
            ),
            if (wrap)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: notices),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: lodControls,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class MapButtonPanel extends StatelessWidget {
  const MapButtonPanel({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => PointerInterceptor(
        child: Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          child: SizedBox(
            width: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children.delimit(const Divider()),
            ),
          ),
        ),
      );
}

class LocationControls extends StatefulWidget {
  const LocationControls({
    super.key,
    required this.cameraPosition,
    this.trackingMode = TrackingMode.free,
    this.trackLocation,
    this.trackBearing,
    this.resetBearing,
  });
  final CameraPosition cameraPosition;
  final TrackingMode trackingMode;
  final void Function()? trackLocation, trackBearing;
  final FutureOr<void> Function()? resetBearing;

  @override
  State<LocationControls> createState() => _LocationControlsState();
}

class _LocationControlsState extends State<LocationControls> {
  bool bearingResetInProgress = false;

  @override
  Widget build(BuildContext context) {
    final Widget button;

    switch (widget.trackingMode) {
      case TrackingMode.free:
        if (widget.cameraPosition.bearing == 0) {
          button = Tooltip(
            message:
                // We anticipate canRequestLocation to be true in most real
                // cases, so let's not make too much of an effort to tailor the
                // UI to this case (simply disable and show a tooltip for now).
                // We might have to revisit this later though.
                canRequestLocation
                    ? 'My location'
                    : 'My location (requires HTTPS)',
            child: TextButton(
              onPressed: widget.trackLocation,
              child: orientation.isOrientationAvailable
                  ? Image(image: PrecachedAsset.locationReticle.image)
                  : const Icon(Icons.location_searching),
            ),
          );
        } else {
          button = Tooltip(
            message: 'Reset north',
            child: TextButton(
              onPressed: bearingResetInProgress
                  ? widget.trackLocation
                  : Optional(widget.resetBearing).map(
                      (f) => () async {
                        setState(() => bearingResetInProgress = true);
                        await f();
                        setState(() => bearingResetInProgress = false);
                      },
                    ),
              child: Transform.rotate(
                angle: -widget.cameraPosition.bearing * math.pi / 180,
                child: Image(image: PrecachedAsset.compass.image),
              ),
            ),
          );
        }
        break;
      case TrackingMode.location:
        button = Tooltip(
          message: orientation.isOrientationAvailable
              ? 'Toggle heading'
              : 'My location',
          child: TextButton(
            onPressed: orientation.isOrientationAvailable
                ? widget.trackBearing
                : widget.trackLocation,
            child: orientation.isOrientationAvailable
                ? Image(image: PrecachedAsset.locationNorth.image)
                : const Icon(Icons.my_location),
          ),
        );
        break;
      case TrackingMode.bearing:
        button = Tooltip(
          message: 'Toggle heading',
          child: TextButton(
            onPressed: widget.trackLocation,
            child: Stack(
              alignment: Alignment.center,
              children: [
                UnconstrainedBox(
                  clipBehavior: Clip.hardEdge,
                  child: Transform(
                    transform: Matrix4.translationValues(40.0, 60.0, 0.0)
                      ..rotateZ(-widget.cameraPosition.bearing * math.pi / 180)
                      ..translate(-40.0, -40.0, 0.0),
                    child: Image(image: PrecachedAsset.compassDirections.image),
                  ),
                ),
                Image(image: PrecachedAsset.compassIndicator.image),
              ],
            ),
          ),
        );
        break;
    }

    return MapButtonPanel(children: [button]);
  }
}

// TODO: tooltip text
// TODO: consistent weight with Maps zoom buttons (Material font doesn't support weight for these symbols)
// TODO: consistent size with Maps zoom buttons? may need to replace them with our own
class LodControls extends StatelessWidget {
  const LodControls({
    super.key,
    required this.lod,
    required this.zoom,
    required this.maxOversample,
    required this.setLod,
  });
  final int lod, zoom, maxOversample;
  final void Function(int) setLod;

  @override
  Widget build(BuildContext context) => MapButtonPanel(
        children: [
          Tooltip(
            message: 'Increase detail',
            child: TextButton(
              onPressed: lod < zoom + maxOversample
                  ? () => setLod(math.max(lod, zoom) + 1)
                  : null,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/lodinc.png',
                    opacity: const AlwaysStoppedAnimation(.625),
                    excludeFromSemantics: true,
                  ),
                  const Icon(Icons.add)
                ],
              ),
            ),
          ),
          Tooltip(
            message: lod == 0 ? 'Lock detail' : 'Reset detail',
            child: _HoverButton(
              onPressed: () => setLod(lod == 0 ? zoom : 0),
              childBuilder: (_, hover) => Icon(
                lod == 0
                    ? hover
                        ? Icons.lock_outlined
                        : Icons.lock_open
                    : Icons.sync,
              ),
            ),
          ),
          Tooltip(
            message: 'Decrease detail',
            child: TextButton(
              onPressed: lod > zoom
                  ? () => setLod(math.min(lod, zoom + maxOversample) - 1)
                  : null,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/loddec.png',
                    opacity: const AlwaysStoppedAnimation(.625),
                    excludeFromSemantics: true,
                  ),
                  const Icon(Icons.remove)
                ],
              ),
            ),
          ),
        ],
      );
}

class _HoverButton extends StatefulWidget {
  const _HoverButton({this.onPressed, required this.childBuilder});
  final void Function()? onPressed;
  final Widget Function(BuildContext, bool hover) childBuilder;

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onHover: (value) => setState(() => hover = value),
      onPressed: widget.onPressed,
      child: widget.childBuilder(context, hover),
    );
  }
}
