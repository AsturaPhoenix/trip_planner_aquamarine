import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart' hide ValueStream;
import 'package:vector_math/vector_math_64.dart' hide Colors;

import '../main.dart' show sharedPreferences;
import '../platform/location.dart' as location;
import '../platform/location.dart' show Distance, Meters;
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

final quaternionNlerp = StateSpace<Quaternion, Quaternion>(
  applyDelta: (state, delta) => (state + delta)..normalize(),
  calculateDelta: (after, before) => after - before,
  lerp: (delta, t) => delta.scaled(t),
);

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

// We don't need a high-fidelity lerp for GPS upsampling.
final mercatorSpace = StateSpace<LatLng, Offset>(
  applyDelta: (state, delta) =>
      LatLng(state.latitude + delta.dy, state.longitude + delta.dx),
  calculateDelta: (after, before) => Offset(
    Degrees(after.longitude - before.longitude).norm180.degrees,
    after.latitude - before.latitude,
  ),
  lerp: (delta, t) => delta * t,
);

class QuaternionDecomposition {
  QuaternionDecomposition(Quaternion? q) : q = q ?? Quaternion.identity();
  final Quaternion q;

  // Device orientation is y-up/z-out while Flutter orientation is y-down/z-in,
  // so this needs to be flipped about the x axis, i.e. x/w or y/z need to be
  // negated. Taken with the conjugate to invert the rotation, this is
  // equivalent to negating x.
  late Quaternion background = (q.clone()..x *= -1) * foreground.conjugated();
  late Quaternion foreground =
      // TODO: this seems like it should simplify
      Quaternion.axisAngle(Vector3(0, 0, 1), orientation.yaw(q).radians);
}

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
    required Quaternion magnetic,
    Widget? background,
    Widget? child,
  }) builder;
}

class CompassState extends State<Compass> with TickerProviderStateMixin {
  static const compassTypeSettingKey = 'compass/compassType',
      distanceSystemSettingKey = 'distanceSystem';

  static CompassMarker<LatLng> toWaypoint(Station station) => CompassMarker(
        color: const {
          StationType.current: Color(0xff5959ff),
          StationType.tide: Color(0xff62d962),
          StationType.destination: Color(0xffff4050),
          StationType.launch: Color(0xfff2f261),
          StationType.meeting: Color(0xffd239cd),
          StationType.nogo: Color(0xff363636),
        }[station.type]!,
        location: station.marker,
      );

  late final ValueStream<Position?> devicePosition;
  late final ValueStream<LatLng?> animatedDevicePosition;
  late final ValueStream<Angle> magneticCorrection,
      trueBearing,
      animatedMagneticCorrection;
  late final ValueStream<Quaternion> animatedOrientation;
  late final InitializedValueStream<Angle> animatedAccuracy;
  // rxdart CompositeSubscription is backed by a list. Let's not risk unbounded
  // growth.
  final broadcastSubscriptions = <StreamSubscription>{};

  var compassType =
      CompassType.values[sharedPreferences.getInt(compassTypeSettingKey) ?? 0];
  var distanceSystem = DistanceSystem
      .values[sharedPreferences.getInt(distanceSystemSettingKey) ?? 0];

  @override
  void initState() {
    super.initState();

    location.requestPermission();
    devicePosition = location.passivePosition;
    animatedDevicePosition =
        devicePosition.map((position) => position?.toLatLng()).transform(
              (s, v) => s
                  .skipBuffered()
                  .upsample(
                    tickerProvider: this,
                    initialState: v,
                    stateSpace: mercatorSpace.sharpNulls(),
                  )
                  .asBroadcastStream(onListen: broadcastSubscriptions.add),
            );

    orientation.updateInterval = const Duration(microseconds: 100000 ~/ 6);
    animatedOrientation = orientation.canonicalOrientation.transform(
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
            initialState: v ?? Quaternion.identity(),
            stateSpace: quaternionNlerp,
          )
          .asBroadcastStream(onListen: broadcastSubscriptions.add),
    );
    magneticCorrection = devicePosition
        .map(orientation.CachingGeoMag().getFromPosition)
        .transform((s, _) => s.whereNotNull())
        .map((r) => Degrees(r.dec));
    trueBearing = CombinedValueStream(
      orientation.bearing,
      magneticCorrection,
      (a, b) => a + b,
    );
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
    final compass = CompassViewport(
      orientation: animatedOrientation,
      builder: (context, magnetic) => compassType.builder(
        compass: this,
        magnetic: magnetic,
        background: _BackgroundOverlay(accuracy: animatedAccuracy),
        child: GeoOverlay(
          waypoints: [
            if (widget.waypoint != null) toWaypoint(widget.waypoint!)
          ],
          position: animatedDevicePosition,
        ),
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
        dividerColor: const Color(0xc0808080),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<Object>(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onSelected: (value) {
                if (value is CompassType) {
                  setState(() => compassType = value);
                  sharedPreferences.setInt(compassTypeSettingKey, value.index);
                } else if (value is DistanceSystem) {
                  setState(() => distanceSystem = value);
                  sharedPreferences.setInt(
                    distanceSystemSettingKey,
                    value.index,
                  );
                }
              },
              itemBuilder: (context) => [
                for (final compassType in CompassType.values)
                  CheckedPopupMenuItem(
                    value: compassType,
                    checked: this.compassType == compassType,
                    child: Text(compassType.description),
                  ),
                const PopupMenuDivider(),
                for (final distanceSystem in DistanceSystem.values)
                  CheckedPopupMenuItem(
                    value: distanceSystem,
                    checked: this.distanceSystem == distanceSystem,
                    child: Text(distanceSystem.description),
                  )
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
                            bearing: trueBearing,
                            distanceSystem: distanceSystem,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: compass,
                            ),
                          ),
                          BearingInfo(
                            trueBearing: trueBearing,
                            magnetic: orientation.bearing,
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
                                  bearing: trueBearing,
                                  distanceSystem: distanceSystem,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                const Divider(),
                                BearingInfo(
                                  trueBearing: trueBearing,
                                  magnetic: orientation.bearing,
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

class CompassViewport extends StatelessWidget {
  static final _projection = Matrix4.identity()..setEntry(3, 2, .002);

  const CompassViewport({super.key, required this.orientation, this.builder});
  final ValueStream<Quaternion> orientation;
  final Widget? Function(BuildContext context, Quaternion magnetic)? builder;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(
          builder: (context, constraints) => StreamBuilder(
            initialData: orientation.value,
            stream: orientation.stream,
            builder: (context, orientation) {
              final center = constraints.biggest.center(Offset.zero);

              final decomposition = QuaternionDecomposition(orientation.data);
              final transform = _projection *
                  decomposition.background.asTransform() as Matrix4;

              // Base the reference vector for the bounding box estimation on
              // the x unit vector.
              // We won't use the z component.
              final px = transform.perspectiveTransform(Vector3(1, 0, 0))
                ..z = 0
                ..normalize();

              // Blend the y and x axes of the reference vector based on the
              // transformed x unit vector above.
              final ref = Vector4(
                px.y * center.dx,
                px.x * center.dy,
                0,
                1,
              );

              // Translate the projection by the homogenized y component of the
              // projected reference vector. It would also be conceivable to
              // translate the camera instead, so that the perspective origin
              // moved to the bottom of the screen. This is easier to size but
              // produces a less natural effect. It would also be conceivable to
              // translate the compass, but that would be more complex.
              //
              // Since we moved the compass, we'd need to do more layout passes.
              // Since we simplified our translation, this is a geometric
              // series derived from t += cy - (Ty . v) / (Tw . v)
              transform.storage[13] = center.dy * transform.row3.dot(ref) -
                  transform.entry(1, 0) * ref.x -
                  transform.entry(1, 1) * ref.y;

              return Transform(
                transform: transform,
                alignment: Alignment.center,
                child: builder?.call(context, decomposition.foreground),
              );
            },
          ),
        ),
      );
}

enum DistanceSystem {
  miles('mi'),
  kilometers('km'),
  nauticalMiles('nm');

  const DistanceSystem(this.description);
  final String description;
}

class LocationInfo extends StatelessWidget {
  static String formatDistance(Distance distance, DistanceSystem system) {
    switch (system) {
      case DistanceSystem.miles:
        final feet = distance.feet.truncate();
        return feet <= 500
            ? '$feet ft'
            : '${distance.miles.toStringAsFixed(1)} mi';
      case DistanceSystem.kilometers:
        final meters = distance.meters.truncate();
        return meters <= 100
            ? '$meters m'
            : '${distance.kilometers.toStringAsFixed(1)} km';
      case DistanceSystem.nauticalMiles:
        final feet = distance.feet.truncate();
        return feet <= 500
            ? '$feet ft'
            : '${distance.nauticalMiles.toStringAsFixed(1)} nm';
    }
  }

  static String formatHeading(
    Heading heading,
    Angle? bearing,
    DistanceSystem system,
  ) {
    final String formattedBearing;
    if (bearing == null) {
      formattedBearing = '${heading.angle.degrees.round() % 360}°';
    } else {
      final degrees = (heading.angle - bearing).norm180.degrees;
      formattedBearing = degrees < 0
          ? '${-degrees.round()}° port'
          : '${degrees.round()}° starboard';
    }

    return heading.distance == null
        ? formattedBearing
        : '${formatDistance(heading.distance!, system)} @ $formattedBearing';
  }

  const LocationInfo({
    super.key,
    this.waypoint,
    required this.bearing,
    required this.distanceSystem,
    required this.crossAxisAlignment,
  });
  final Station? waypoint;
  final ValueStream<Angle> bearing;
  final DistanceSystem distanceSystem;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: location.passivePosition.value,
        stream: location.passivePosition.stream,
        builder: (context, position) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            StreamBuilder(
              initialData: location.isEnabled.value,
              stream: location.isEnabled.stream,
              builder: (context, isEnabled) {
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
            if (waypoint != null && position.hasData)
              StreamBuilder(
                initialData: bearing.value,
                stream: bearing.stream,
                builder: (context, bearing) {
                  return Text(
                    formatHeading(
                      waypoint!.marker.toHeading(position.data!.toLatLng()),
                      bearing.data,
                      distanceSystem,
                    ),
                  );
                },
              )
          ],
        ),
      );
}

class BearingInfo extends StatelessWidget {
  const BearingInfo({
    super.key,
    required this.trueBearing,
    required this.magnetic,
    required this.crossAxisAlignment,
  });
  final ValueStream<Angle> trueBearing, magnetic;
  final CrossAxisAlignment crossAxisAlignment;

  static String formatBearing(Angle bearing, String suffix) =>
      '${bearing.degrees.round() % 360}° $suffix';

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: magnetic.value,
        stream: magnetic.stream,
        builder: (context, magnetic) => magnetic.hasData
            ? StreamBuilder(
                initialData: trueBearing.value,
                stream: trueBearing.stream,
                builder: (context, trueBearing) => Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    if (trueBearing.hasData)
                      Text(formatBearing(trueBearing.data!, 'true')),
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

class GeoOverlay extends StatelessWidget {
  const GeoOverlay({
    super.key,
    required this.waypoints,
    required this.position,
  });
  final List<CompassMarker<LatLng>> waypoints;
  final ValueStream<LatLng?> position;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: position.value,
        stream: position.stream,
        builder: (context, position) => CustomPaint(
          size: Size.infinite,
          painter: _HeadingsPainter(
            headings: [
              if (position.hasData)
                for (final waypoint in waypoints)
                  waypoint.map((location) => location.toHeading(position.data!))
            ],
          ),
        ),
      );
}

class Heading extends Equatable {
  const Heading({required this.angle, this.distance});
  final Angle angle;
  final Distance? distance;
  @override
  List<Object?> get props => [angle, distance];
}

extension on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension on LatLng {
  Heading toHeading(LatLng from) => Heading(
        angle: Degrees(
          Geolocator.bearingBetween(
            from.latitude,
            from.longitude,
            latitude,
            longitude,
          ),
        ),
        distance: Meters(
          Geolocator.distanceBetween(
            from.latitude,
            from.longitude,
            latitude,
            longitude,
          ),
        ),
      );
}

class CompassMarker<T> extends Equatable {
  const CompassMarker({required this.color, required this.location});
  final Color color;
  final T location;
  @override
  List<Object?> get props => [color, location];

  CompassMarker<U> map<U>(U Function(T) f) =>
      CompassMarker(color: color, location: f(location));
}

class _HeadingsPainter extends CustomPainter {
  static const outlineColor = Color(0xff404040);
  static const markerRadius = 4.0;

  _HeadingsPainter({required this.headings});
  final List<CompassMarker<Heading>> headings;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    canvas.translate(center.dx, center.dy);

    for (final heading in headings) {
      final markerCenter = Offset(0, markerRadius - center.dy);

      canvas
        ..save()
        ..rotate(heading.location.angle.radians)
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
