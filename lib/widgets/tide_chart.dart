import 'package:flutter/material.dart';

import '../providers/trip_planner_client.dart';

class TideChart extends StatelessWidget {
  const TideChart({
    super.key,
    required this.client,
    required this.station,
    required this.t,
  });

  final TripPlannerClient client;
  final Station station;
  final DateTime t;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 455,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: theme.colorScheme.secondaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${station.type == 'tide' ? 'Tide Height' : 'Currents'}: ${station.shortTitle}',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            SizedBox(
              height: 233,
              child: Stack(
                children: [
                  Positioned(
                    top: -36,
                    child: Image.network(
                      TripPlannerClient.tideGraphUrl(
                        client.endpoints,
                        station,
                        1,
                        455,
                        312,
                        t,
                      ).toString(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
