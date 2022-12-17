import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart' hide ValueStream;

import '../main.dart' show sharedPreferences;
import '../platform/location.dart' as location;
import '../platform/orientation.dart' show Angle, Degrees;
import '../platform/orientation.dart' as orientation;
import '../providers/trip_planner_client.dart';
import '../util/animation_coordinator.dart';
import '../util/upsample_stream.dart';
import '../util/value_stream.dart';
import 'blinking_icon.dart';
import 'compass_classic.dart';
import 'compass_nautical.dart';
import 'map.dart';

final scalarSpace = StateSpace<Angle, Angle>(
  applyDelta: (state, delta) => state + delta,
  calculateDelta: (after, before) => after - before,
  lerp: (delta, t) => delta * t,
);

final polarSpace = StateSpace<Angle, Angle>(
  applyDelta: (orientation, delta) => (orientation + delta).norm180,
  calculateDelta: (after, before) => (after - before).norm180,
  lerp: (delta, t) => delta * t,
);

class Compass extends StatefulWidget {
  static const defaultTextSize = 24.0;

  const Compass({super.key, this.waypoint});
  final Station? waypoint;

  @override
  State<Compass> createState() => CompassState();
}

enum CompassType {
  classic('Classic', ClassicCompass.new),
  nautical('Nautical', NauticalCompass.new);

  const CompassType(this.description, this.builder);

  final String description;
  final Widget Function({
    required CompassState compass,
    Widget? background,
    Widget? child,
  }) builder;
}

class CompassState extends State<Compass> with TickerProviderStateMixin {
  static const compassTypeSettingKey = 'compass/compassType';

  late final ValueStream<Position?> devicePosition;
  late final ValueStream<Angle> magneticCorrection,
      animatedOrientation,
      animatedMagneticCorrection;
  late final InitializedValueStream<Angle> animatedAccuracy;
  // rxdart CompositeSubscription is backed by a list. Let's not risk unbounded
  // growth.
  final broadcastSubscriptions = <StreamSubscription>{};

  var compassType =
      CompassType.values[sharedPreferences.getInt(compassTypeSettingKey) ?? 0];

  @override
  void initState() {
    super.initState();

    location.requestPermission();
    devicePosition = location.passivePosition;

    orientation.updateInterval = const Duration(microseconds: 100000 ~/ 6);
    animatedOrientation = orientation.bearing.transform(
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
            initialState: v?.norm180 ?? Angle.zero,
            stateSpace: polarSpace,
          )
          .asBroadcastStream(onListen: broadcastSubscriptions.add),
    );
    magneticCorrection = devicePosition
        .map(orientation.CachingGeoMag().getFromPosition)
        .transform((s, _) => s.whereNotNull())
        .map((r) => Degrees(r.dec));
    animatedMagneticCorrection = magneticCorrection.transform(
      (s, v) => s
          .skipBuffered()
          .upsample(
            tickerProvider: this,
            initialState: v?.norm180 ?? Angle.zero,
            stateSpace: polarSpace,
          )
          .asBroadcastStream(onListen: broadcastSubscriptions.add),
    );
    animatedAccuracy = orientation.accuracy
        .map((accuracy) => accuracy ?? const Degrees(180))
        .transform(
          (s, v) => s
              .skipBuffered()
              .upsample(
                tickerProvider: this,
                initialState: v,
                stateSpace: scalarSpace,
              )
              .asBroadcastStream(onListen: broadcastSubscriptions.add),
        );
  }

  @override
  void dispose() {
    for (final subscription in broadcastSubscriptions) {
      subscription.cancel();
    }
    // This needs to happen after the subscription cancellations or the ticker
    // provider mixin will complain about leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const waypointColors = {
      StationType.current: Color(0xff5959ff),
      StationType.tide: Color(0xff62d962),
      StationType.destination: Color(0xffff4050),
      StationType.launch: Color(0xfff2f261),
      StationType.meeting: Color(0xffd239cd),
      StationType.nogo: Color(0xff363636),
    };

    final compass = compassType.builder(
      compass: this,
      background: _BackgroundOverlay(accuracy: animatedAccuracy),
      child: GeoOverlay(
        waypoints: [
          if (widget.waypoint != null)
            Waypoint(
              coordinate: widget.waypoint!.marker,
              color: waypointColors[widget.waypoint!.type]!,
            )
        ],
      ),
    );

    return Theme(
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
            fontSize: Compass.defaultTextSize,
            fontWeight: FontWeight.bold,
          ),
          child: OrientationBuilder(
            builder: (context, screenOrientation) =>
                screenOrientation == Orientation.portrait
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocationInfo(
                            waypoint: widget.waypoint,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: compass,
                            ),
                          ),
                          BearingInfo(
                            magnetic: orientation.bearing,
                            magneticCorrection: magneticCorrection,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.all(4),
                              child: compass,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LocationInfo(
                                  waypoint: widget.waypoint,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                BearingInfo(
                                  magnetic: orientation.bearing,
                                  magneticCorrection: magneticCorrection,
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
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    super.key,
    this.waypoint,
    required this.crossAxisAlignment,
  });
  final Station? waypoint;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          StreamBuilder(
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
          ),
          if (waypoint != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/markers/${waypoint!.type.name}-grey-outline.png',
                  height: Compass.defaultTextSize,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    waypoint!.shortTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
        ],
      );
}

class BearingInfo extends StatelessWidget {
  const BearingInfo({
    super.key,
    required this.magnetic,
    required this.magneticCorrection,
    required this.crossAxisAlignment,
  });
  final ValueStream<Angle> magnetic, magneticCorrection;
  final CrossAxisAlignment crossAxisAlignment;

  static String formatBearing(Angle bearing, String suffix) =>
      '${bearing.degrees.round() % 360}° $suffix';

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

class _BackgroundOverlay extends StatelessWidget {
  const _BackgroundOverlay({required this.accuracy});
  final InitializedValueStream<Angle> accuracy;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: accuracy.value,
        stream: accuracy.stream,
        builder: (context, accuracy) => CustomPaint(
          size: Size.infinite,
          painter: _AccuracyPainter(accuracy: accuracy.data!.radians),
        ),
      );
}

class _AccuracyPainter extends CustomPainter {
  _AccuracyPainter({required this.accuracy});
  final double accuracy;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    const heading = Color(0xff801010), highlight = Color(0xff303030);

    // Gradient.sweep has trouble blending across 0, so rotate away from that.
    canvas
      ..translate(center.dx, center.dy)
      ..rotate(pi / 2)
      ..drawArc(
        -center & size,
        pi - accuracy,
        2 * accuracy,
        true,
        Paint()
          ..shader = Gradient.sweep(
            Offset.zero,
            [heading, highlight, highlight.withAlpha(0)],
            [0, .2, 1],
            TileMode.mirror,
            pi,
            pi + accuracy,
          )
          ..blendMode = BlendMode.plus,
      )
      ..drawLine(
        Offset.zero,
        Offset(-center.dx, 0),
        Paint()
          ..color = heading
          ..strokeWidth = 1.5,
      );
  }

  @override
  bool shouldRepaint(covariant _AccuracyPainter oldDelegate) =>
      accuracy != oldDelegate.accuracy;
}

class Waypoint {
  const Waypoint({required this.coordinate, required this.color});
  final LatLng coordinate;
  final Color color;

  HeadingMark toHeading(Position from) => HeadingMark(
        angle: Degrees(
          Geolocator.bearingBetween(
            from.latitude,
            from.longitude,
            coordinate.latitude,
            coordinate.longitude,
          ),
        ),
        color: color,
      );
}

class GeoOverlay extends StatelessWidget {
  const GeoOverlay({
    super.key,
    this.waypoints = const [],
    this.headings = const [],
  });
  final List<Waypoint> waypoints;
  final List<HeadingMark> headings;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: location.passivePosition.value,
        stream: location.passivePosition.stream,
        builder: (context, position) {
          return CustomPaint(
            size: Size.infinite,
            painter: _HeadingsPainter(
              headings: [
                if (position.hasData)
                  for (final waypoint in waypoints)
                    waypoint.toHeading(position.data!),
                ...headings
              ],
            ),
          );
        },
      );
}

class HeadingMark extends Equatable {
  const HeadingMark({required this.angle, required this.color});
  final Angle angle;
  final Color color;
  @override
  List<Object?> get props => [angle, color];
}

class _HeadingsPainter extends CustomPainter {
  static const outlineColor = Color(0xff404040);
  static const markerRadius = 4.0;

  _HeadingsPainter({required this.headings});
  final List<HeadingMark> headings;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    canvas.translate(center.dx, center.dy);

    for (final heading in headings) {
      final markerCenter = Offset(0, markerRadius - center.dy);

      canvas
        ..save()
        ..rotate(heading.angle.radians)
        ..drawLine(
          Offset.zero,
          Offset(0, -center.dy),
          Paint()
            ..color = heading.color
            ..strokeWidth = 1.5,
        )
        ..drawCircle(
          markerCenter,
          markerRadius,
          Paint()
            ..color = heading.color
            ..style = PaintingStyle.fill,
        )
        ..drawCircle(
          markerCenter,
          markerRadius,
          Paint()
            ..color = outlineColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(covariant _HeadingsPainter oldDelegate) =>
      const ListEquality().equals(headings, oldDelegate.headings);
}
