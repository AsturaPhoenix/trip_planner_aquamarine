import 'dart:async';
import 'dart:core';
import 'dart:core' as core;
import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fml;
import 'package:flutter_map/flutter_map.dart' hide LatLngBounds, Polygon;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../persistence/blob_cache.dart';
import '../platform/location.dart' as location;
import '../platform/orientation.dart' as orientation;
import '../providers/ofs_client.dart';
import '../providers/trip_planner_client.dart';
import '../providers/wms_tile_provider.dart';
import '../util/angle.dart';
import '../util/animation_coordinator.dart';
import '../util/controller.dart';
import '../util/latlng.dart';
import '../util/optional.dart';
import 'info_window.dart';
import 'map_layers/current_layer.dart';
import 'map_layers/polygon_layer.dart';
import 'plot_panel.dart';
import 'tide_panel.dart';

typedef StationFilters = List<bool Function(Station)>;

extension StationFiltersExtensions on StationFilters {
  bool isStationVisible(Station station) => any((filter) => filter(station));
}

enum InfoWindowType { station, currentLocation }

class MapController extends Controller {
  MapController() {
    selectedStation.addListener(notifyListeners);
  }

  // If we migrate more state to the controller, we might be able to get rid of
  // this.
  late MapState _map;

  final selectedStation = ValueNotifier<Station?>(null);

  InfoWindowType? _infoWindow;

  @override
  void dispose() {
    selectedStation.dispose();
    super.dispose();
  }

  void selectStation(Station? station, {bool mayUnlock = true}) => setState(() {
        selectedStation.value = station;

        if (station == null) {
          showInfoWindow(null);
        } else {
          if (mayUnlock ||
              _map.trackingMode == TrackingMode.free ||
              !location.isEnabled.value) {
            _map.animateToStation(station);
          }

          showInfoWindow(InfoWindowType.station);
        }
      });

  void showInfoWindow(InfoWindowType? infoWindow) =>
      setState(() => _infoWindow = infoWindow);
}

class Map extends StatefulWidget {
  static const minZoom = 0.0, maxZoom = 22.0;
  // Center map on Alcatraz, to show the interesting points around the Bay.
  static const initialCameraPosition =
      CameraPosition(center: LatLng(37.8331, -122.4165), zoom: 12.0);

  Map({
    super.key,
    required this.client,
    required this.tileCache,
    required this.ofsClient,
    this.stations = const {},
    this.stationFilters = const [],
    this.tracks = const [],
    required this.timeWindow,
    MapController? controller,
  }) : controller = controller ?? MapController();

  final http.Client client;
  final BlobCache tileCache;
  final OfsClient ofsClient;

  final core.Map<StationId, Station> stations;
  final StationFilters stationFilters;
  final List<Track> tracks;
  final GraphTimeWindow timeWindow;

  final MapController controller;

  @override
  MapState createState() => MapState();
}

enum PrecachedAsset {
  compass(AssetImage('assets/compass.png')),
  locationReticle(AssetImage('assets/location_reticle.png')),
  locationNorth(AssetImage('assets/location_north.png')),
  compassDirections(AssetImage('assets/compass_directions.png')),
  compassIndicator(AssetImage('assets/compass_indicator.png')),
  arrowhead(AssetImage('assets/arrowhead.png')),

  selected(AssetImage('assets/markers/sel.png')),
  tcSelected(AssetImage('assets/markers/tc_sel.png')),
  location(AssetImage('assets/markers/location.png'));

  const PrecachedAsset(this.image);
  final ImageProvider image;
}

class _MarkerMetrics {
  static final station =
          _MarkerMetrics(12, 20, AnchorPos.align(AnchorAlign.top)),
      selection =
          _MarkerMetrics(22, 21, AnchorPos.exactly(Anchor(11, .35 * 21))),
      location = _MarkerMetrics(20, 20, AnchorPos.align(AnchorAlign.center));

  const _MarkerMetrics(this.width, this.height, this.anchorPos);

  final double width, height;
  final AnchorPos anchorPos;

  Anchor get anchor => Anchor.forPos(anchorPos, width, height);
  Offset get rotateOrigin {
    final anchor = this.anchor;
    return Offset(width - anchor.left, height - anchor.top);
  }
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

class CameraPosition extends Equatable {
  const CameraPosition({
    required this.center,
    required this.zoom,
    this.rotation = Angle.zero,
  });
  CameraPosition.of(fml.MapController map)
      : center = map.center.toSpherical(),
        zoom = map.zoom,
        rotation = Degrees(map.rotation);

  final LatLng center;
  final double zoom;
  final Angle rotation;

  @override
  get props => [center, zoom, rotation];

  CameraPosition copyWith({
    CenterZoom? centerZoom,
    LatLng? center,
    double? zoom,
    Angle? rotation,
  }) =>
      CameraPosition(
        center: center ?? centerZoom?.center.toSpherical() ?? this.center,
        zoom: zoom ?? centerZoom?.zoom ?? this.zoom,
        rotation: rotation ?? this.rotation,
      );

  CameraPosition operator +(CameraDelta delta) {
    // flutter_map does optimizations if the rotation is 0, so take advantage of
    // that if we're close. This also lets us avoid putting a tolerance
    // elsewhere like on the rotation button.
    const epsilon = 1e-4;
    final newRotation = (rotation + delta.rotation).norm180;

    return CameraPosition(
      center: LatLng(
        center.latitude + delta.center.dy,
        center.longitude + delta.center.dx,
      ),
      zoom: zoom + delta.zoom,
      rotation: newRotation.degrees.abs() <= epsilon ? Angle.zero : newRotation,
    );
  }

  CameraDelta operator -(CameraPosition other) => CameraDelta(
        center: Offset(
          center.longitude - other.center.longitude,
          center.latitude - other.center.latitude,
        ),
        zoom: zoom - other.zoom,
        rotation: (rotation - other.rotation).norm180,
      );
}

class CameraDelta extends Equatable {
  const CameraDelta({
    this.center = Offset.zero,
    this.zoom = 0,
    this.rotation = Angle.zero,
  });

  final Offset center;
  final double zoom;
  final Angle rotation;

  @override
  get props => [center, zoom, rotation];

  CameraDelta operator +(CameraDelta other) => CameraDelta(
        center: center + other.center,
        zoom: zoom + other.zoom,
        rotation: rotation + other.rotation,
      );

  CameraDelta operator *(double factor) => CameraDelta(
        center: center * factor,
        zoom: zoom * factor,
        rotation: rotation * factor,
      );
}

extension on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

class MapState extends State<Map> with SingleTickerProviderStateMixin {
  static final log = Logger('MapState');

  late final WmsTileProvider chartTileProvider;
  final chartLayerReset = StreamController<void>();
  final mapController = fml.MapController();

  void _setLod(int lod) => setState(() {
        chartTileProvider.levelOfDetail = lod;
        chartLayerReset.add(null);
      });

  late List<Polyline> _trackPolylines;

  bool showCurrents = false;

  void _updateTrackPolylines() {
    _trackPolylines = [
      for (final track in widget.tracks)
        if (track.selected)
          for (final segment in track.segments)
            Polyline(
              key: segment.key,
              color: track.color,
              points: [for (final point in segment.points) point.toFml()],
              strokeWidth: 2,
            )
    ];
  }

  void _fitTracks() {
    final bounds = _calculateBounds(
      widget.tracks
          .where((track) => track.selected)
          .expand((track) => track.segments)
          .expand((segment) => segment.points),
    );

    if (bounds != null) {
      _animateToBounds(bounds);
    }
  }

  void _fitOutlines(Station station) {
    final bounds =
        _calculateBounds(station.outlines.expand((outline) => outline));

    if (bounds != null) {
      _animateToBounds(bounds);
    }
  }

  LatLngBounds? _calculateBounds(Iterable<LatLng> points) {
    LatLngBounds? bounds;
    for (final point in points) {
      bounds = bounds.expand(point);
    }
    return bounds;
  }

  void _animateToBounds(LatLngBounds bounds) {
    trackingMode = TrackingMode.free;

    // This is broken when the map is rotated.
    // fleaflet/flutter_map#1342
    final centerZoom = mapController.centerZoomFitBounds(
      bounds.toFml(),
      options: FitBoundsOptions(
        padding: const EdgeInsets.all(48 + 16),
        maxZoom: math.max(cameraPosition.zoom, 14),
      ),
    );

    mapAnimation.set(cameraPosition.copyWith(centerZoom: centerZoom));
  }

  CameraPosition cameraPosition = Map.initialCameraPosition;
  late final AnimationCoordinator<CameraPosition, CameraDelta> mapAnimation;

  StreamSubscription? trackingSubscription;
  TrackingMode _trackingMode = TrackingMode.free;
  TrackingMode get trackingMode => _trackingMode;
  set trackingMode(TrackingMode value) {
    if (value != _trackingMode) {
      trackingSubscription?.cancel();
      trackingSubscription = null;

      _trackingMode = value;

      switch (value) {
        case TrackingMode.location:
          trackingSubscription = location.requestedPosition.listen(
            (position) {
              if (position == null) {
                setState(() => trackingMode = TrackingMode.free);
              } else {
                mapAnimation.add(
                  mapAnimation.target.copyWith(
                    center: position.toLatLng(),
                    rotation: Angle.zero,
                  ),
                );
              }
            },
          );
          break;
        case TrackingMode.bearing:
          orientation.updateInterval =
              const Duration(microseconds: 100000 ~/ 6);
          final geomag = orientation.CachingGeoMag();
          trackingSubscription = Rx.combineLatest2(
            location.requestedPosition,
            orientation.bearing.seededStream.whereNotNull(),
            (position, bearing) => mapAnimation.target.copyWith(
              center: position?.toLatLng(),
              rotation: -bearing -
                  Degrees(geomag.getFromPosition(position)?.dec ?? 0),
            ),
          ).listen(mapAnimation.add);
          break;
        case TrackingMode.free:
      }
    }
  }

  bool _dragging = false;

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMoveStart) {
      setState(() => _dragging = true);
    } else if (event is MapEventMoveEnd) {
      setState(() => _dragging = false);
    }

    if (event is! MapEventWithMove && event is! MapEventRotate) return;

    // TODO(AsturaPhoenix): use "target" properties of the events rather than
    // comparing against our cached position.
    final newCameraPosition = CameraPosition.of(mapController);

    final isGesture = !const {
      MapEventSource.mapController,
      MapEventSource.fitBounds,
      MapEventSource.initialization,
    }.contains(event.source);

    setState(() {
      if (isGesture &&
          (cameraPosition.center != newCameraPosition.center ||
              cameraPosition.rotation != newCameraPosition.rotation)) {
        trackingMode = TrackingMode.free;
        // Don't change the tracking mode if the user somehow managed to evoke a
        // pure zoom change.
      }

      cameraPosition = newCameraPosition;

      if (event.source != MapEventSource.mapController) {
        mapAnimation.override(cameraPosition);
      }
    });
  }

  void animateToStation(Station station) {
    if (station.outlines.isEmpty) {
      if (location.isEnabled.value) {
        setState(() => trackingMode = TrackingMode.free);
        // Don't unlock tracking if location enablement is still pending.
      }
      mapAnimation.set(cameraPosition.copyWith(center: station.marker));
    } else {
      _fitOutlines(station);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller._map = this;

    chartTileProvider = WmsTileProvider(
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
    );

    mapAnimation = AnimationCoordinator<CameraPosition, CameraDelta>(
      tickerProvider: this,
      initialState: Map.initialCameraPosition,
      stateSpace: StateSpace<CameraPosition, CameraDelta>(
        applyDelta: (state, delta) => state + delta,
        calculateDelta: (after, before) => after - before,
        scaleDelta: (delta, t) => delta * t,
      ),
      setState: (cameraPosition) => mapController.moveAndRotate(
        cameraPosition.center.toFml(),
        cameraPosition.zoom,
        cameraPosition.rotation.degrees,
      ),
    );

    if (!kIsWeb) {
      trackingMode = TrackingMode.location;
    }

    _updateTrackPolylines();

    // Requires the map controller to be bound to the widget.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fitTracks();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final asset in PrecachedAsset.values) {
      precacheImage(asset.image, context);
    }

    chartTileProvider.maxOversample =
        2 + (MediaQuery.devicePixelRatioOf(context).floor()) - 1;
  }

  @override
  void didUpdateWidget(covariant Map oldWidget) {
    super.didUpdateWidget(oldWidget);

    chartTileProvider.client = widget.client;
    chartTileProvider.cache = widget.tileCache;

    if (widget.controller != oldWidget.controller) {
      widget.controller._map = this;
    }

    if (widget.tracks != oldWidget.tracks) {
      _updateTrackPolylines();

      selectedTrackIds(Iterable<Track> tracks) => {
            for (final track in tracks)
              if (track.selected) track.key
          };

      if (!setEquals(
        selectedTrackIds(widget.tracks),
        selectedTrackIds(oldWidget.tracks),
      )) {
        _fitTracks();
      }
    }
  }

  @override
  void dispose() {
    mapAnimation.dispose();
    trackingSubscription?.cancel();
    chartLayerReset.close();
    chartTileProvider.dispose();
    super.dispose();
  }

  Marker _buildInfoWindowMarker(
    LatLng position,
    _MarkerMetrics markerMetrics,
    Widget Function(BuildContext) builder,
  ) {
    const maxSize = Size(1024, 768);

    final onAnchor = Anchor.forPos(
      markerMetrics.anchorPos,
      markerMetrics.width,
      markerMetrics.height,
    );

    final anchor = Anchor(
      (maxSize.width + markerMetrics.width) / 2 - onAnchor.left,
      onAnchor.top - markerMetrics.height,
    );

    return Marker(
      point: position.toFml(),
      anchorPos: AnchorPos.exactly(anchor),
      rotateOrigin:
          Offset(maxSize.width - anchor.left, maxSize.height - anchor.top),
      width: maxSize.width,
      height: maxSize.height,
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: MouseRegion(
          cursor: SystemMouseCursors.basic,
          hitTestBehavior: HitTestBehavior.deferToChild,
          child: GestureDetector(
            onTap: () => widget.controller.showInfoWindow(null),
            child: InfoWindow(
              strokeColor: Colors.transparent,
              elevation: 8.0,
              child: builder(context),
            ),
          ),
        ),
      ),
    );
  }

  // tp.js: create_sel_marker
  static Marker _buildSelectionMarker(
    Key key,
    ImageProvider icon,
    LatLng location,
  ) =>
      Marker(
        key: key,
        // tp.js: move_sel_marker
        point: location.toFml(),
        anchorPos: _MarkerMetrics.selection.anchorPos,
        rotateOrigin: _MarkerMetrics.selection.rotateOrigin,
        width: _MarkerMetrics.selection.width,
        height: _MarkerMetrics.selection.height,
        builder: (context) => Image(image: icon),
      );

  @override
  Widget build(BuildContext context) {
    // TODO(AsturaPhoenix): This costs about 6 ms. We should probably avoid
    // doing this unnecessarily by making camera position and time window
    // observable and only updating the pertinent subtrees for those changes
    // rather than rebuilding the whole widget. We could also cache this on
    // didUpdateWidget, but then we'd have to make assumptions about stations
    // and filters being immutable.
    final stationLayers = _buildStationLayers(
      stations: widget.stations.values,
      filters: widget.stationFilters,
      onTap: (station) {
        if (widget.controller.selectedStation.value != station ||
            widget.controller._infoWindow != InfoWindowType.station) {
          widget.controller.selectStation(station);
        } else {
          widget.controller.showInfoWindow(null);
        }
      },
    );

    return MouseRegion(
      cursor: _dragging ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: cameraPosition.center.toFml(),
          zoom: cameraPosition.zoom,
          rotation: cameraPosition.rotation.degrees,
          minZoom: Map.minZoom,
          maxZoom: Map.maxZoom,
          enableMultiFingerGestureRace: true,
          rotationThreshold: 10,
          onMapEvent: _onMapEvent,
        ),
        // ignore: sort_child_properties_last
        children: [
          TileLayer(
            tileProvider: chartTileProvider,
            reset: chartLayerReset.stream,
          ),
          stationLayers.polygonLayer,
          if (showCurrents)
            CurrentLayer(
              arrowhead: PrecachedAsset.arrowhead.image,
              ofsClient: widget.ofsClient,
              timeWindow: widget.timeWindow,
            ),
          PolylineLayer(
            polylines: _trackPolylines,
          ),
          ListenableBuilder(
            listenable: widget.controller.selectedStation,
            builder: (context, _) {
              final selectedStation = widget.controller.selectedStation.value;

              if (selectedStation != null &&
                  widget.stationFilters.isStationVisible(selectedStation)) {
                final tcStation =
                    widget.stations[selectedStation.tideCurrentStationId];

                return MarkerLayer(
                  rotate: true,
                  rotateAlignment: null,
                  markers: [
                    _buildSelectionMarker(
                      const ValueKey('sel'),
                      PrecachedAsset.selected.image,
                      selectedStation.marker,
                    ),
                    if (tcStation != null &&
                        widget.stationFilters.isStationVisible(tcStation))
                      _buildSelectionMarker(
                        const ValueKey('tc_sel'),
                        PrecachedAsset.tcSelected.image,
                        tcStation.marker,
                      ),
                  ],
                );
              } else {
                return const MarkerLayer();
              }
            },
          ),
          ...stationLayers.markerLayers,
          StreamBuilder(
            initialData: location.passivePosition.value,
            stream: location.passivePosition.stream,
            builder: (context, position) => MarkerLayer(
              // This layer is exempt from fleaflet/flutter_map #1500 because
              // the marker anchorPos is its center.
              rotate: true,
              markers: [
                if (position.hasData)
                  Marker(
                    point: position.data!.toLatLng().toFml(),
                    anchorPos: _MarkerMetrics.location.anchorPos,
                    width: _MarkerMetrics.location.width,
                    height: _MarkerMetrics.location.height,
                    builder: (context) => MouseRegion(
                      cursor: SystemMouseCursors.click,
                      hitTestBehavior: HitTestBehavior.deferToChild,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.controller._infoWindow !=
                              InfoWindowType.currentLocation) {
                            widget.controller
                                .showInfoWindow(InfoWindowType.currentLocation);
                            setState(
                              () => trackingMode = TrackingMode.location,
                            );
                          } else {
                            widget.controller.showInfoWindow(null);
                          }
                        },
                        child: Image(image: PrecachedAsset.location.image),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          DefaultTextStyle.merge(
            style: const TextStyle(fontWeight: FontWeight.bold),
            child: ListenableBuilder(
              listenable: widget.controller,
              builder: (context, _) {
                switch (widget.controller._infoWindow) {
                  case InfoWindowType.station:
                    final selectedStation =
                        widget.controller.selectedStation.value;
                    return MarkerLayer(
                      rotate: true,
                      rotateAlignment: null,
                      markers: [
                        _buildInfoWindowMarker(
                          selectedStation!.marker,
                          _MarkerMetrics.station,
                          (context) => Text(selectedStation.typedShortTitle),
                        ),
                      ],
                    );
                  case InfoWindowType.currentLocation:
                    return StreamBuilder(
                      initialData: location.passivePosition.value,
                      stream: location.passivePosition.stream,
                      builder: (context, position) => MarkerLayer(
                        rotate: true,
                        rotateAlignment: null,
                        markers: [
                          if (position.hasData)
                            _buildInfoWindowMarker(
                              position.data!.toLatLng(),
                              _MarkerMetrics.location,
                              (context) => Text(formatPosition(position.data!)),
                            )
                        ],
                      ),
                    );
                  case null:
                    return const MarkerLayer();
                }
              },
            ),
          ),
        ],
        nonRotatedChildren: [
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
                lod: chartTileProvider.levelOfDetail,
                maxOversample: chartTileProvider.maxOversample,
                trackingMode: trackingMode,
                showCurrents: showCurrents,
                trackLocation: () =>
                    setState(() => trackingMode = TrackingMode.location),
                trackBearing: () =>
                    setState(() => trackingMode = TrackingMode.bearing),
                resetBearing: () => mapAnimation
                    .set(cameraPosition.copyWith(rotation: Angle.zero)),
                zoomIn: () => _zoom(1),
                zoomOut: () => _zoom(-1),
                setLod: _setLod,
                setShowCurrents: (value) =>
                    setState(() => showCurrents = value),
              ),
            ),
          ),
          AttributionWidget(
            attributionBuilder: (context) => MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                color: const Color(0xccffffff),
                child: const Text(
                  'Chart data © NOAA Office of Coast Survey',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _zoom(double delta) {
    mapAnimation.add(
      cameraPosition.copyWith(
        zoom:
            clampDouble(cameraPosition.zoom + delta, Map.minZoom, Map.maxZoom),
      ),
    );
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
    required this.lod,
    this.maxOversample = 0,
    required this.trackingMode,
    required this.showCurrents,
    this.trackLocation,
    this.trackBearing,
    this.resetBearing,
    this.zoomIn,
    this.zoomOut,
    required this.setLod,
    required this.setShowCurrents,
  });
  final CameraPosition cameraPosition;
  final int lod, maxOversample;
  final TrackingMode trackingMode;
  final bool showCurrents;
  final void Function()? trackLocation, trackBearing, zoomIn, zoomOut;
  final FutureOr<void> Function()? resetBearing;
  final void Function(int lod) setLod;
  final void Function(bool show) setShowCurrents;

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
    final layerControls = MapButtonPanel(
      children: [
        Tooltip(
          message: showCurrents ? 'Hide currents' : 'Show currents',
          child: TextButton(
            child:
                Icon(Icons.waves, color: showCurrents ? null : Colors.black26),
            onPressed: () => setShowCurrents(!showCurrents),
          ),
        )
      ],
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        const double buttonHeight = 40,
            spacing = 10,
            divider = 1,
            attribution = 14;
        final wrap = constraints.maxHeight <
            7 * buttonHeight + 3 * spacing + 3 * divider;

        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  locationControls,
                  zoomControls,
                  if (!wrap) ...[
                    lodControls,
                    layerControls,
                  ]
                ].delimit(const SizedBox(height: spacing)),
              ),
            ),
            if (wrap)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: attribution),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        lodControls,
                        layerControls,
                      ].delimit(const SizedBox(height: spacing)),
                    ),
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
  Widget build(BuildContext context) => Card(
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
        if (widget.cameraPosition.rotation == Angle.zero) {
          button = StreamBuilder(
            initialData: location.permissionStatus.value,
            stream: location.permissionStatus.stream,
            builder: (context, permissionStatus) {
              final String tooltip;
              final bool enabled;
              if (!location.canRequestLocation) {
                // We anticipate canRequestLocation to be true in most real cases,
                // so let's not make too much of an effort to tailor the UI to this
                // case (simply disable and show a tooltip for now). We might have
                // to revisit this later though.
                tooltip = 'My location (requires HTTPS)';
                enabled = false;
              } else if (permissionStatus.data?.isPermanentlyDenied ?? false) {
                tooltip = 'My location (disabled)';
                enabled = false;
              } else {
                tooltip = 'My location';
                enabled = true;
              }

              return Tooltip(
                message: tooltip,
                child: TextButton(
                  onPressed: enabled ? widget.trackLocation : null,
                  child: enabled
                      ? orientation.isOrientationAvailable
                          ? Image(image: PrecachedAsset.locationReticle.image)
                          : const Icon(Icons.location_searching)
                      : const Icon(Icons.location_disabled),
                ),
              );
            },
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
                angle: widget.cameraPosition.rotation.radians,
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
                      ..rotateZ(widget.cameraPosition.rotation.radians)
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
  Widget build(BuildContext context) => TextButton(
        onHover: (value) => setState(() => hover = value),
        onPressed: widget.onPressed,
        child: widget.childBuilder(context, hover),
      );
}

final _stationIcons = <StationType, ImageProvider>{};

class _StationLayers {
  _StationLayers({required this.polygonLayer, required this.markerLayers});
  final Widget polygonLayer;
  final List<Widget> markerLayers;
}

class _StationPolygonId extends Equatable {
  const _StationPolygonId(this.stationId, this.index);
  final StationId stationId;
  final int index;
  @override
  get props => [stationId, index];
}

/// Builds the marker and polygon layers for a given station configuration. This
/// cannot be a single widget as intervening layers may be rendered between
/// polygons and markers.
///
/// [filters]: Station filter functions, in order of precedence. Stations
/// matched by earlier filters are rendered over stations matched only by later
/// filters.
_StationLayers _buildStationLayers({
  required Iterable<Station> stations,
  required StationFilters filters,
  required void Function(Station) onTap,
}) {
  final polygons = <Widget>[];
  final markersForLayer = List.generate(filters.length, (_) => <Marker>[]);

  for (final station in stations) {
    for (int i = 0; i < filters.length; ++i) {
      if (filters[i](station)) {
        final icon = _stationIcons[station.type] ??=
            AssetImage('assets/markers/${station.type.name}.png');

        // tp.js: create_station
        final opacity = station.isLegacy
            ? .3
            : station.isSubordinate
                ? .6
                : 1.0;

        markersForLayer[i].add(
          Marker(
            key: ValueKey(station.id),
            point: station.marker.toFml(),
            anchorPos: _MarkerMetrics.station.anchorPos,
            rotateOrigin: _MarkerMetrics.station.rotateOrigin,
            width: _MarkerMetrics.station.width,
            height: _MarkerMetrics.station.height,
            builder: (context) => MouseRegion(
              cursor: SystemMouseCursors.click,
              hitTestBehavior: HitTestBehavior.deferToChild,
              child: GestureDetector(
                onTap: () => onTap(station),
                child: Image(
                  image: icon,
                  opacity: AlwaysStoppedAnimation(opacity),
                ),
              ),
            ),
          ),
        );

        for (int i = 0; i < station.outlines.length; ++i) {
          polygons.add(
            MouseRegion(
              cursor: SystemMouseCursors.click,
              hitTestBehavior: HitTestBehavior.deferToChild,
              child: GestureDetector(
                onTap: () => onTap(station),
                child: Polygon(
                  key: ValueKey(_StationPolygonId(station.id, i)),
                  vertices: [
                    for (final point in station.outlines[i]) point.toFml()
                  ],
                  style: const PolygonStyle(
                    fillColor: Color(0x40ff0000),
                    strokeColor: Colors.red,
                    strokeWidth: 1,
                  ),
                ),
              ),
            ),
          );
        }

        break;
      }
    }
  }

  return _StationLayers(
    polygonLayer: Stack(children: polygons),
    markerLayers: [
      for (final markers in markersForLayer.reversed)
        MarkerLayer(rotate: true, rotateAlignment: null, markers: markers)
    ],
  );
}
