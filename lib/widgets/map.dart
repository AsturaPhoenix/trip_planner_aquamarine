import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../providers/wms_tile_provider.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  MapState createState() {
    return MapState();
  }
}

class _TileOverlayConfiguration<T extends TileProvider> {
  final TileOverlayId id;
  final T tileProvider;
  _TileOverlayConfiguration(String id, this.tileProvider)
      : id = TileOverlayId(id);
}

class MapState extends State<Map> {
  static const initialCameraPosition = CameraPosition(
    target: LatLng(37.7717, -122.2983), // Center on Alameda shoreline.
    zoom: 12,
  );

  final _chartOverlays = [
    _TileOverlayConfiguration(
        'nautical',
        WmsTileProvider(
            url: Uri.parse(
                'https://gis.charttools.noaa.gov/arcgis/rest/services/MCS/NOAAChartDisplay/MapServer/exts/MaritimeChartService/WMSServer'),
            fetchLod: 1,
            params: WmsParams()
              ..version = '1.3.0'
              ..layers = '0,1,2,3,4,5,6,7'))
  ];
  GoogleMapController? _gmap;
  int zoom = initialCameraPosition.zoom.toInt();

  void _changeLod(int Function(WmsTileProvider) newLod) => setState(() {
        for (final overlay in _chartOverlays) {
          overlay.tileProvider.levelOfDetail = newLod(overlay.tileProvider);
          // TODO: This does not cancel inflight requests, which can leave stale tiles.
          _gmap!.clearTileCache(overlay.id);
        }
      });

  void _decreaseLod() =>
      _changeLod((tp) => min(tp.levelOfDetail, zoom + tp.maxOversample) - 1);
  void _resetLod() => _changeLod((_) => 0);
  void _lockLod() => _changeLod((_) => zoom);
  void _increaseLod() => _changeLod((tp) => max(tp.levelOfDetail, zoom) + 1);

  @override
  Widget build(BuildContext context) {
    final tileSize = (MediaQuery.of(context).devicePixelRatio *
            WmsTileProvider.logicalTileSize)
        .ceil();

    for (final overlay in _chartOverlays) {
      overlay.tileProvider.preferredTileSize = tileSize;
    }

    final chartOverlay = _chartOverlays.first;

    return Stack(children: [
      GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        tileOverlays: {
          TileOverlay(
              tileOverlayId: chartOverlay.id,
              tileProvider: chartOverlay.tileProvider,
              tileSize: tileSize),
        },
        onCameraMove: (position) =>
            setState(() => zoom = position.zoom.toInt()),
        onMapCreated: (controller) async {
          setState(() => _gmap = controller);
          controller.setMapStyle(await DefaultAssetBundle.of(context)
              .loadString('assets/nautical-style.json'));
        },
      ),
      if (_gmap != null)
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 115),
          child: Theme(
              data: ThemeData(
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          foregroundColor: const Color(0xff666666),
                          fixedSize: const Size.square(40),
                          minimumSize: const Size.square(40),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero)),
                  dividerTheme: const DividerThemeData(
                      color: Color(0xffe6e6e6),
                      space: 1,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5)),
              child: PointerInterceptor(
                  child: Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      child: SizedBox(
                          width: 40,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            TextButton(
                                onPressed:
                                    chartOverlay.tileProvider.levelOfDetail <
                                            zoom +
                                                chartOverlay
                                                    .tileProvider.maxOversample
                                        ? _increaseLod
                                        : null,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset('assets/lodinc.png'),
                                      const Icon(Icons.add)
                                    ])),
                            const Divider(),
                            TextButton(
                                onPressed:
                                    chartOverlay.tileProvider.levelOfDetail == 0
                                        ? _lockLod
                                        : _resetLod,
                                child: Icon(
                                    chartOverlay.tileProvider.levelOfDetail == 0
                                        ? Icons.lock_open
                                        : Icons.sync)),
                            const Divider(),
                            TextButton(
                                onPressed:
                                    chartOverlay.tileProvider.levelOfDetail >
                                            zoom
                                        ? _decreaseLod
                                        : null,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset('assets/loddec.png'),
                                      const Icon(Icons.remove)
                                    ])),
                          ]))))),
        ),
    ]);
  }

  @override
  void dispose() {
    _gmap?.dispose();
    for (final overlay in _chartOverlays) {
      overlay.tileProvider.dispose();
    }
    super.dispose();
  }
}
