import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core' as core;
import 'dart:math' as math;

import 'package:aquamarine_server_interface/types.dart' as ifc;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

import '../persistence/blob_cache.dart';
import '../platform/location.dart' as location;
import '../platform/orientation.dart' as orientation;
import '../providers/ofs_client.dart';
import '../providers/trip_planner_client.dart';
import '../providers/wms_tile_provider.dart';
import '../util/angle.dart';
import '../util/animation_coordinator.dart';
import '../util/async_throttle.dart';
import '../util/optional.dart';
import 'plot_panel.dart';
import 'tide_panel.dart';

String b64LatLng(ifc.LatLng latlng) => base64.encode(
      Uint8List.view(
        Float32List.fromList([
          latlng.latitude,
          latlng.longitude,
        ]).buffer,
      ),
    );

extension on LatLng {
  ifc.LatLng toIfc() => ifc.LatLng(latitude, longitude);
}

extension on ifc.LatLng {
  LatLng toGmaps() => LatLng(latitude, longitude);
}

extension on LatLngBounds {
  ifc.LatLngBounds toIfc() => ifc.LatLngBounds(
        southwest: southwest.toIfc(),
        northeast: northeast.toIfc(),
      );

  bool containsBounds(LatLngBounds other) =>
      toIfc().containsBounds(other.toIfc());

  LatLngBounds pad(double factor) => toIfc().pad(factor).toGmaps();
}

extension on ifc.LatLngBounds {
  LatLngBounds toGmaps() => LatLngBounds(
        southwest: southwest.toGmaps(),
        northeast: northeast.toGmaps(),
      );
}

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
    StationType.nogo,
  };

  Map({
    super.key,
    required this.client,
    required this.tileCache,
    required this.ofsClient,
    this.stations = const {},
    this.selectedStation,
    this.tracks = const [],
    required this.timeWindow,
    int Function(StationType type)? stationPriority,
    this.onStationSelected,
  }) : stationPriority =
            stationPriority ?? ((type) => type.isTideCurrent ? 1 : 0);

  final http.Client client;
  final BlobCache tileCache;
  final OfsClient ofsClient;
  final core.Map<StationId, Station> stations;
  final Station? selectedStation;
  final List<Track> tracks;
  final GraphTimeWindow timeWindow;

  final int Function(StationType type) stationPriority;
  final void Function(Station station)? onStationSelected;

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

class _CurrentsViewKey extends Equatable {
  const _CurrentsViewKey(this.bounds, this.zoom);
  final LatLngBounds bounds;
  final double zoom;
  @override
  get props => [bounds, zoom];
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

class _ZIndex {
  static const int nogo = 1, track = 2;
  static const double selection = 3, currentLocation = 13;
  static double station(int major, int minor) {
    assert(0 <= minor && minor < 3);
    final zIndex = 4.0 + 3 * major + minor;
    assert(selection < zIndex && zIndex < currentLocation);
    return zIndex;
  }
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

  CameraPosition operator +(CameraDelta delta) => CameraPosition(
        bearing: (bearing + delta.bearing) % 360,
        target: LatLng(
          target.latitude + delta.target.dy,
          target.longitude + delta.target.dx,
        ),
        zoom: zoom + delta.zoom,
      );

  CameraDelta operator -(CameraPosition other) => CameraDelta(
        bearing: (bearing - other.bearing + 180) % 360 - 180,
        target: Offset(
          target.longitude - other.target.longitude,
          target.latitude - other.target.latitude,
        ),
        zoom: zoom - other.zoom,
      );
}

class CameraDelta {
  CameraDelta({
    this.bearing = 0,
    this.target = Offset.zero,
    this.zoom = 0,
  });
  final double bearing;
  final Offset target;
  final double zoom;

  CameraDelta operator +(CameraDelta other) => CameraDelta(
        bearing: bearing + other.bearing,
        target: target + other.target,
        zoom: zoom + other.zoom,
      );

  CameraDelta operator *(double factor) => CameraDelta(
        bearing: bearing * factor,
        target: target * factor,
        zoom: zoom * factor,
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

  late Future<_MarkerIcons> _markerIcons;
  late Future<BitmapDescriptor> _arrowhead;

  late Set<Polyline> _trackPolylines;
  Set<Polyline> _currentPolylines = {};
  bool showCurrents = false;

  void _updateTrackPolylines() {
    _trackPolylines = {
      for (final track in widget.tracks)
        if (track.selected)
          for (final segment in track.segments)
            Polyline(
              polylineId: segment.key,
              color: track.color,
              points: segment.points,
              width: 2,
              zIndex: _ZIndex.track,
            )
    };
  }

  final _currentsThrottle = AsyncThrottle();
  _CurrentsViewKey? _currentsBounds;

  void _updateCurrentPolylines({bool testBounds = false}) {
    _currentsThrottle.schedule([
      () async {
        if (gmap == null) return;
        final bounds = await gmap!.getVisibleRegion();

        if (testBounds &&
            _currentsBounds != null &&
            _currentsBounds!.bounds.containsBounds(bounds) &&
            (_currentsBounds!.zoom - cameraPosition.zoom).abs() < .1) {
          return;
        }

        _currentsBounds =
            _CurrentsViewKey(bounds.pad(.125), cameraPosition.zoom);

        final currents = await widget.ofsClient.getCurrents(
          timeWindow: widget.timeWindow,
          bounds: _currentsBounds!.bounds.toIfc(),
          zoom: _currentsBounds!.zoom,
        );

        if (currents == null) return;

        final northAspect =
                math.cos(Degrees(bounds.northeast.latitude).radians),
            southAspect = math.cos(Degrees(bounds.southwest.latitude).radians);
        final aspectM = (northAspect - southAspect) /
            (bounds.northeast.latitude - bounds.southwest.latitude);

        LatLng perturb(ifc.LatLng anchor, Vector2 delta) {
          final factor = 16 / math.pow(2, cameraPosition.zoom);
          final aspect = southAspect +
              (anchor.latitude - bounds.southwest.latitude) * aspectM;
          return LatLng(
            anchor.latitude + aspect * factor * delta.y,
            anchor.longitude + factor * delta.x,
          );
        }

        final arrowhead = await _arrowhead;

        if (!mounted || !showCurrents) return;

        setState(() {
          _currentPolylines = {
            for (final current in currents)
              Polyline(
                polylineId: PolylineId('ofs-${b64LatLng(current.location)}'),
                points: [
                  current.location.toGmaps(),
                  perturb(current.location, current.value),
                ],
                endCap: Cap.customCapFromBitmap(arrowhead, refWidth: 4),
                zIndex: _ZIndex.track,
                width: 1,
              )
          };
        });
      }
    ]);
  }

  void _setShowCurrents(bool show) {
    if (show) {
      setState(() => showCurrents = true);
      _updateCurrentPolylines();
      widget.ofsClient.addListener(_updateCurrentPolylines);
    } else {
      setState(() {
        showCurrents = false;
        _currentsThrottle.clearNext();
        _currentPolylines = const {};
        _currentsBounds = null;
      });
      widget.ofsClient.removeListener(_updateCurrentPolylines);
    }
  }

  void _fitTracks() {
    final bounds = _calculateBounds(
      widget.tracks
          .where((track) => track.selected)
          .expand((track) => track.segments)
          .expand((segment) => segment.points),
    );

    if (bounds != null && gmap != null) {
      _animateToBounds(bounds);
    }
  }

  void _fitOutlines(Station station) {
    final bounds =
        _calculateBounds(station.outlines.expand((outline) => outline));

    if (bounds != null && gmap != null) {
      _animateToBounds(bounds);
    }
  }

  LatLngBounds? _calculateBounds(Iterable<LatLng> points) {
    ifc.LatLngBounds? bounds;
    for (final point in points) {
      bounds = bounds.expand(point.toIfc());
    }
    return bounds?.toGmaps();
  }

  void _animateToBounds(LatLngBounds bounds) {
    trackingMode = TrackingMode.free;
    // Cancel any animations in progress.
    mapAnimation.override(cameraPosition);
    gmap!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 48 + 16));
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
                  mapAnimation.target
                      .copyWith(target: position.toLatLng(), bearing: 0),
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
              target: position?.toLatLng(),
              bearing: bearing.degrees +
                  (geomag.getFromPosition(position)?.dec ?? 0),
            ),
          ).listen(mapAnimation.add);
          break;
        case TrackingMode.free:
      }
    }
  }

  // For the most part this isn't called for moveCamera, but there are cases
  // where it is.
  void updateCameraPosition(CameraPosition newPosition) {
    if (!mounted) return;

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
    } else if (!mapAnimation.isActive) {
      setState(() {
        cameraPosition = newPosition;
        mapAnimation.override(newPosition);
      });
    }

    if (showCurrents) {
      _updateCurrentPolylines(testBounds: true);
    }
  }

  void animateToStation(Station station) {
    if (station.outlines.isEmpty) {
      if (location.isEnabled.value) {
        trackingMode = TrackingMode.free;
        // Don't unlock tracking if location enablement is still pending.
      }
      mapAnimation.set(cameraPosition.copyWith(target: station.marker));
    } else {
      _fitOutlines(station);
    }
  }

  @override
  void initState() {
    super.initState();

    mapAnimation = AnimationCoordinator<CameraPosition, CameraDelta>(
      tickerProvider: this,
      initialState: Map.initialCameraPosition,
      stateSpace: StateSpace<CameraPosition, CameraDelta>(
        applyDelta: (state, delta) => state + delta,
        calculateDelta: (after, before) => after - before,
        scaleDelta: (delta, t) => delta * t,
      ),
      setState: (cameraPosition) async {
        await gmap?.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
        // We need to update this after moveCamera because we may need to deal
        // with a trainwreck of onCameraMove events, for which we want to
        // compare with the previous camera position to determine whether to
        // unlock.
        if (!mounted) return;
        setState(() => this.cameraPosition = cameraPosition);
      },
    );

    if (!kIsWeb) {
      trackingMode = TrackingMode.location;
    }

    _updateTrackPolylines();
    _fitTracks();
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

    _arrowhead = BitmapDescriptor.fromAssetImage(
      defaultConfiguration,
      'assets/arrowhead.png',
    );

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

    if (widget.selectedStation != null &&
        oldWidget.selectedStation == null &&
        gmap != null &&
        (trackingMode == TrackingMode.free || !location.isEnabled.value)) {
      animateToStation(widget.selectedStation!);
    }

    if (widget.tracks != oldWidget.tracks) {
      _updateTrackPolylines();

      Set<String> selectedTrackIds(Iterable<Track> tracks) => {
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

    if (showCurrents) {
      if (widget.timeWindow.t != oldWidget.timeWindow.t) {
        _updateCurrentPolylines();
      }

      if (widget.ofsClient != oldWidget.ofsClient) {
        widget.ofsClient.addListener(_updateCurrentPolylines);
        oldWidget.ofsClient.removeListener(_updateCurrentPolylines);
      }
    }
  }

  @override
  void dispose() {
    mapAnimation.dispose();
    trackingSubscription?.cancel();
    // We mustn't dispose of the maps controller because the widget will do this
    // for us and dispose isn't idempotent on all platforms.
    gmap = null;
    for (final overlay in chartOverlays) {
      overlay.tileProvider.dispose();
    }
    _currentsThrottle.dispose();
    if (showCurrents) {
      widget.ofsClient.removeListener(_updateCurrentPolylines);
    }
    super.dispose();
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
          builder: (context, markerIcons) => StreamBuilder(
            initialData: location.passivePosition.value,
            stream: location.passivePosition.stream,
            builder: (context, position) {
              final markers = <Marker>{};
              final polygons = <Polygon>{};

              if (markerIcons.hasData) {
                if (position.hasData) {
                  const markerId = MarkerId('current location');
                  markers.add(
                    Marker(
                      markerId: markerId,
                      anchor: const Offset(.5, .5),
                      position: position.data!.toLatLng(),
                      icon: markerIcons.requireData.location,
                      // TODO: This text does not update while the info window
                      // is shown.
                      infoWindow: InfoWindow(
                        title: formatPosition(position.data!),
                        onTap: kIsWeb
                            ? null
                            : () => gmap!.hideMarkerInfoWindow(markerId),
                      ),
                      // Take precedence over other markers.
                      zIndex: _ZIndex.currentLocation,
                      consumeTapEvents: true,
                      onTap: () {
                        gmap?.showMarkerInfoWindow(markerId);
                        setState(() => trackingMode = TrackingMode.location);
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
                  final markerId = MarkerId(station.id.toString());

                  final icon = markerIcons.requireData.stations[station.type];
                  if (icon != null) {
                    // tp.js: create_station
                    final visualMinor = [
                          station.isLegacy,
                          station.isSubordinate
                        ].indexOf(true) %
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
                        zIndex: _ZIndex.station(visualMajor, visualMinor),
                        consumeTapEvents: true,
                        onTap: () {
                          gmap?.showMarkerInfoWindow(markerId);
                          animateToStation(station);
                          widget.onStationSelected?.call(station);
                        },
                      ),
                    );
                  }

                  for (int i = 0; i < station.outlines.length; ++i) {
                    polygons.add(
                      Polygon(
                        polygonId: PolygonId('${station.id}-$i'),
                        points: station.outlines[i],
                        fillColor: const Color(0x40ff0000),
                        strokeColor: Colors.red,
                        strokeWidth: 1,
                        zIndex: _ZIndex.nogo,
                        consumeTapEvents: true,
                        onTap: () {
                          gmap?.showMarkerInfoWindow(markerId);
                          animateToStation(station);
                          widget.onStationSelected?.call(station);
                        },
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
                        zIndex: _ZIndex.selection,
                      ),
                    );

                createSelectionMarker(
                  const MarkerId('sel'),
                  markerIcons.requireData.selected,
                  widget.selectedStation?.marker,
                );

                createSelectionMarker(
                  const MarkerId('tc_sel'),
                  markerIcons.requireData.tcSelected,
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
                polylines: {..._trackPolylines, ..._currentPolylines},
                polygons: polygons,
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
                          !location.isEnabled.value)) {
                    animateToStation(widget.selectedStation!);
                  }
                },
              );
            },
          ),
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
                trackingMode: trackingMode,
                showCurrents: showCurrents,
                trackLocation: () =>
                    setState(() => trackingMode = TrackingMode.location),
                trackBearing: () =>
                    setState(() => trackingMode = TrackingMode.bearing),
                resetBearing: () =>
                    mapAnimation.set(cameraPosition.copyWith(bearing: 0)),
                zoomIn: () => mapAnimation.addDelta(CameraDelta(zoom: 1)),
                zoomOut: () => mapAnimation.addDelta(CameraDelta(zoom: -1)),
                setLod: _setLod,
                setShowCurrents: _setShowCurrents,
              ),
            ),
          ),
      ],
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
            logo = 26,
            notices = kIsWeb ? 14 : 0;
        final wrap = constraints.maxHeight <
            7 * buttonHeight + 3 * spacing + logo + 3 * divider;

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
                    if (!wrap) ...[
                      lodControls,
                      layerControls,
                    ]
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
