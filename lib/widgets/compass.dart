import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart' hide ValueStream;

import '../main.dart' show sharedPreferences;
import '../platform/location.dart' as location;
import '../platform/orientation.dart' as orientation;
import '../util/upsample_stream.dart';
import '../util/value_stream.dart';
import 'blinking_icon.dart';
import 'compass_classic.dart';
import 'compass_nautical.dart';
import 'map.dart';

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => CompassState();
}

enum CompassType {
  classic('Classic', ClassicCompass.new),
  nautical('Nautical', NauticalCompass.new);

  const CompassType(this.description, this.builder);

  final String description;
  final Widget Function({required CompassState compass}) builder;
}

class CompassState extends State<Compass> with TickerProviderStateMixin {
  static const compassTypeSettingKey = 'compass/compassType';

  late final ValueStream<Position?> devicePosition;
  late final ValueStream<double> geomagneticCorrection,
      upsampledOrientation,
      upsampledGeomag;
  StreamSubscription? orientationBroadcastSubscription,
      geomagBroadcastSubscription;

  var compassType =
      CompassType.values[sharedPreferences.getInt(compassTypeSettingKey) ?? 0];

  @override
  void initState() {
    super.initState();

    location.requestPermission();
    devicePosition = location.passivePosition;

    double polar(double radians) => (radians + pi) % (2 * pi) - pi;

    orientation.updateInterval = const Duration(microseconds: 100000 ~/ 6);
    upsampledOrientation = orientation.bearing
        .map((bearing) => orientation.radians(bearing))
        .transform(
          // We unsubscribe from the orientation sensors while they're not
          // needed, which seems to cause the platform channel to buffer some
          // events. We need to skip these buffered events to animate properly
          // between the last cached state and the first updated state. If we
          // don't skip the buffered events, the upsampler treats all but the
          // first event as an immediate series of movements that causes the
          // animation to skip.
          //
          // Unfortunately there doesn't seem to be a great way to reliably skip
          // all buffered events, so at some point we might want to explore
          // limiting the deltas instead.
          (s, v) => s
              .skipBuffered()
              .upsample(
                tickerProvider: this,
                initialState: polar(v ?? 0),
                applyDelta: (orientation, delta) => polar(orientation + delta),
                calculateDelta: (after, before) => polar(after - before),
                lerp: (delta, t) => delta * t,
              )
              .asBroadcastStream(
                onListen: (subscription) =>
                    orientationBroadcastSubscription = subscription,
              ),
        );
    geomagneticCorrection = devicePosition
        .map(orientation.CachingGeoMag().getFromPosition)
        .transform((s, _) => s.whereNotNull())
        .map((r) => r.dec);
    upsampledGeomag = geomagneticCorrection
        .map((dec) => orientation.radians(dec))
        .transform(
          (s, v) => s
              .skipBuffered()
              .upsample(
                tickerProvider: this,
                initialState: polar(v ?? 0),
                applyDelta: (correction, delta) => polar(correction + delta),
                calculateDelta: (after, before) => polar(after - before),
                lerp: (delta, t) => delta * t,
              )
              .asBroadcastStream(
                onListen: (subscription) =>
                    geomagBroadcastSubscription = subscription,
              ),
        );
  }

  @override
  void dispose() {
    orientationBroadcastSubscription?.cancel();
    geomagBroadcastSubscription?.cancel();
    // This needs to happen after the subscription cancellations or the ticker
    // provider mixin will complain about leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black45,
            brightness: Brightness.dark,
            primary: Colors.black45,
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Compass style',
                initialValue: compassType,
                onSelected: (value) => setState(() {
                  compassType = value;
                  sharedPreferences.setInt(compassTypeSettingKey, value.index);
                }),
                itemBuilder: (context) => [
                  for (final compassType in CompassType.values)
                    PopupMenuItem(
                      value: compassType,
                      child: Text(compassType.description),
                    ),
                ],
              )
            ],
          ),
          body: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            child: OrientationBuilder(
              builder: (context, screenOrientation) => screenOrientation ==
                      Orientation.portrait
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const LocationInfo(),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: compassType.builder(compass: this),
                            ),
                          ),
                          BearingInfo(
                            magnetic: orientation.bearing,
                            magneticCorrection: geomagneticCorrection,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          )
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: compassType.builder(compass: this),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LocationInfo(),
                              BearingInfo(
                                magnetic: orientation.bearing,
                                magneticCorrection: geomagneticCorrection,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: location.isEnabled.value,
        stream: location.isEnabled.stream,
        builder: (context, isEnabled) => StreamBuilder(
          initialData: location.passivePosition.value,
          stream: location.passivePosition.stream,
          builder: (context, position) {
            final gpsState = [
                  position.hasData,
                  position.hasError,
                  isEnabled.data,
                ].indexOf(true) %
                4;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const [
                  Icon(Icons.my_location),
                  Icon(Icons.location_disabled),
                  BlinkingIcon(
                    icons: [Icons.my_location, Icons.location_searching],
                  ),
                  Icon(Icons.location_disabled)
                ][gpsState],
                const SizedBox(width: 8),
                AnimatedSize(
                  alignment: Alignment.centerLeft,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  child: [
                    () => Text(formatPosition(position.data!)),
                    () => const Text('could not acquire gps'),
                    () => const Text('acquiring GPS...'),
                    () => const Text('GPS disabled'),
                  ][gpsState](),
                ),
              ],
            );
          },
        ),
      );
}

class BearingInfo extends StatelessWidget {
  const BearingInfo({
    super.key,
    required this.magnetic,
    required this.magneticCorrection,
    required this.crossAxisAlignment,
  });
  final ValueStream<double> magnetic, magneticCorrection;
  final CrossAxisAlignment crossAxisAlignment;

  static String formatBearing(double degrees, String suffix) =>
      '${degrees.round() % 360}° $suffix';

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: magnetic.value,
        stream: magnetic.stream,
        builder: (context, magnetic) => magnetic.hasData
            ? StreamBuilder(
                initialData: magneticCorrection.value,
                stream: magneticCorrection.stream,
                builder: (context, correction) => Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    if (correction.hasData)
                      Text(
                        formatBearing(
                          magnetic.data! + correction.data!,
                          'true',
                        ),
                      ),
                    Text(formatBearing(magnetic.data!, 'magnetic')),
                  ],
                ),
              )
            : magnetic.hasError
                ? const Text('Could not acquire compass.')
                : const CircularProgressIndicator(),
      );
}

class RingStack extends StatelessWidget {
  const RingStack({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          ...children.mapIndexed(
            (index, child) => Transform.rotate(
              angle: index / children.length * 2 * pi,
              child: child,
            ),
          )
        ],
      );
}
