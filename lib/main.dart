import 'package:flutter/material.dart';
import 'widgets/map.dart';

void main() {
  runApp(const TripPlanner());
}

class TripPlanner extends StatelessWidget {
  const TripPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASK Trip Planner',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(0xff, 0xc9, 0xd3, 0xdc),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BASK Trip Planner'),
        ),
        body: const Map(),
      ),
    );
  }
}
