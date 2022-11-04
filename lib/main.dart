import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASK Trip Planner',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(0xff, 0xc9, 0xd3, 0xdc),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BASK Trip Planner"),
        ),
        body: const GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(37.7717, -122.2983), // Center on Alameda shoreline.
            zoom: 12,
          ),
        ),
      ),
    );
  }
}
