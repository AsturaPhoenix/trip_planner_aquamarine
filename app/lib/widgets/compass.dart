import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:rxdart/rxdart.dart' hide ValueStream;
import 'package:vector_math/vector_math_64.dart' hide Colors;

import '../main.dart' show sharedPreferences;
import '../platform/camera.dart';
import '../platform/location.dart' as location;
import '../platform/orientation.dart' as orientation;
import '../providers/trip_planner_client.dart';
import '../util/angle.dart';
import '../util/animation_coordinator.dart';
import '../util/distance.dart';
import '../util/upsample_stream.dart';
import '../util/value_stream.dart';
import 'blinking_icon.dart';
import 'compass_classic.dart';
import 'compass_nautical.dart';
import 'map.dart';

final quaternionNlerp = StateSpace<Quaternion, Quaternion>(
  applyDelta: (state, delta) => (state + delta)..normalize(),
  calculateDelta: (after, before) {
    // Pick the shortest of two possible deltas.
    // TODO: google/vector_math.dart#276
    final a = after - before, b = (after + before)..scale(-1);
    return a.length2 <= b.length2 ? a : b;
  },
  scaleDelta: (delta, t) => delta.scaled(t),
);

final polarSpace = StateSpace<Angle, Angle>(
  applyDelta: (orientation, delta) => (orientation + delta).norm180,
  calculateDelta: (after, before) => (after - before).norm180,
  scaleDelta: (delta, t) => delta * t,
);

// We don't need a high-fidelity lerp for GPS upsampling.
final mercatorSpace = StateSpace<LatLng, Offset>(
  applyDelta: (state, delta) =>
      LatLng(state.latitude + delta.dy, state.longitude + delta.dx),
  calculateDelta: (after, before) => Offset(
    Degrees(after.longitude - before.longitude).norm180.degrees,
    after.latitude - before.latitude,
  ),
  scaleDelta: (delta, t) => delta * t,
);

class QuaternionDecomposition {
  static const planarDeviationCurve = Interval(.2, .8);

  QuaternionDecomposition(Quaternion? q) : q = q ?? Quaternion.identity();
  final Quaternion q;

  // This is used to transition between flat and AR modes.
  late final planarDeviation = planarDeviationCurve.transform(
    (asin(-_background.x * (_background.w > 0 ? 1 : -1)) * 4 / pi).clamp(0, 1),
  );

  // Device orientation is y-up/z-out while Flutter orientation is y-down/z-in,
  // so this needs to be flipped about the x axis, i.e. x/w or y/z need to be
  // negated. Taken with the conjugate to invert the rotation, this is
  // equivalent to negating x.
  late final _background = (q.clone()..x *= -1) * foreground.conjugated();

  /// The pitch/roll components of device orientation (adjusted for screen
  /// rotation). This is used to apply AR effects to device-relative UI.
  late final background =
      quaternionNlerp.lerp(Quaternion.identity(), _background, planarDeviation);

  /// The yaw component of the device orientation (adjusted for screen
  /// rotation).
  late final foreground = () {
    final tx = 1 - 2 * (q.y * q.y + q.z * q.z),
        ty = 2 * (q.w * q.z + q.x * q.y);
    final cos = tx / sqrt(tx * tx + ty * ty);
    return Quaternion(0, 0, ty.sign * sqrt((1 - cos) / 2), sqrt((1 + cos) / 2));
  }();
}

class Compass extends StatefulWidget {
  static const lineHeight = 28.0;
  static const defaultShadows = [Shadow(blurRadius: 4.0)];
  static const defaultTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    shadows: defaultShadows,
  );

  const Compass({super.key, this.waypoint, required this.distanceSystem});
  final Station? waypoint;
  final ValueNotifier<DistanceSystem> distanceSystem;

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

class CompassState extends State<Compass>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static const compassTypeSettingKey = 'compass/compassType';

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

  late final CameraManager camera;

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
              .upsample(tickerProvider: this, initialState: v)
              .asBroadcastStream(onListen: broadcastSubscriptions.add),
        );

    camera = CameraManager(
      (() async => (await availableCameras()).firstWhereOrNull(
            (c) => c.lensDirection == CameraLensDirection.back,
          ))(),
      ResolutionPreset.max,
    );

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) =>
      camera.didChangeAppLifecycleState(state);

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final subscription in broadcastSubscriptions) {
      subscription.cancel();
    }
    camera.dispose();
    // This needs to happen after the subscription cancellations or the ticker
    // provider mixin will complain about leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget locationInfo(CrossAxisAlignment crossAxisAlignment) =>
        LocationInfo(
          waypoint: widget.waypoint,
          bearing: trueBearing,
          distanceSystem: widget.distanceSystem,
          crossAxisAlignment: crossAxisAlignment,
        );

    Widget compass(QuaternionDecomposition orientation) => CompassViewport(
          orientation: orientation,
          builder: (context, magnetic) => compassType.builder(
            compass: this,
            magnetic: magnetic,
            background: _BackgroundOverlay(accuracy: animatedAccuracy),
            child: GeoOverlay(
              waypoints: [
                if (widget.waypoint != null) toWaypoint(widget.waypoint!)
              ],
              position: animatedDevicePosition,
              accuracy: animatedAccuracy,
            ),
          ),
        );

    PreferredSizeWidget bearingInfo(CrossAxisAlignment crossAxisAlignment) =>
        BearingInfo(
          trueBearing: trueBearing,
          magnetic: orientation.bearing,
          crossAxisAlignment: crossAxisAlignment,
        );

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black45,
          brightness: Brightness.dark,
          primary: Colors.black45,
          surface: const Color(0x60606060),
        ),
        scaffoldBackgroundColor: Colors.black,
        dividerColor: const Color(0xc0808080),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white60),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                  widget.distanceSystem.value = value;
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
                for (final value in DistanceSystem.values)
                  CheckedPopupMenuItem(
                    value: value,
                    checked: widget.distanceSystem.value == value,
                    child: Text(value.description),
                  )
              ],
            )
          ],
        ),
        body: DefaultTextStyle(
          style: Compass.defaultTextStyle,
          child: IconTheme(
            data: const IconThemeData(
              color: Colors.white,
              shadows: Compass.defaultShadows,
            ),
            child: OrientationBuilder(
              builder: (context, screenOrientation) => StreamBuilder(
                initialData: animatedOrientation.value,
                stream: animatedOrientation.stream,
                builder: (context, animatedOrientation) {
                  final decomposition =
                      QuaternionDecomposition(animatedOrientation.data);

                  // Planar deviation at which to enable the camera.
                  const arThreshold = .5;

                  if (decomposition.planarDeviation > arThreshold) {
                    camera.start();
                  } else {
                    camera.stop();
                  }

                  return ListenableBuilder(
                    listenable: camera,
                    builder: (context, _) {
                      final cameraController = camera.controller;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          // Don't show the camera UI at all if we know there's
                          // no camera.
                          if (camera.connectionState ==
                                  ConnectionState.waiting ||
                              cameraController != null)
                            Opacity(
                              opacity: const Interval(arThreshold, 1)
                                  .transform(decomposition.planarDeviation),
                              child: cameraController == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : () {
                                      // CameraPreview uses an AspectRatio, which
                                      // bases its layout on max size and cannot
                                      // acheive a "cover" effect.
                                      var size =
                                          cameraController.value.previewSize!;
                                      if (const [
                                        DeviceOrientation.portraitUp,
                                        DeviceOrientation.portraitDown
                                      ].contains(
                                        cameraController
                                            .value.deviceOrientation,
                                      )) {
                                        size = size.flipped;
                                      }
                                      return FittedBox(
                                        fit: BoxFit.cover,
                                        clipBehavior: Clip.hardEdge,
                                        child: SizedBox(
                                          width: size.width,
                                          height: size.height,
                                          child: CameraPreview(
                                            cameraController,
                                          ),
                                        ),
                                      );
                                    }(),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: Scaffold.of(context).appBarMaxHeight!,
                            ),
                            child: screenOrientation == Orientation.portrait
                                ? CompassPortraitLayout(
                                    arLayout: decomposition.planarDeviation,
                                    locationInfo:
                                        locationInfo(CrossAxisAlignment.center),
                                    compass: compass(decomposition),
                                    bearingInfo:
                                        bearingInfo(CrossAxisAlignment.center),
                                  )
                                : CompassLandscapeLayout(
                                    arLayout:
                                        decomposition.planarDeviation > .75,
                                    locationInfo:
                                        locationInfo(CrossAxisAlignment.start),
                                    compass: compass(decomposition),
                                    bearingInfo:
                                        bearingInfo(CrossAxisAlignment.start),
                                  ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompassPortraitLayout extends StatelessWidget {
  static int flex(double factor) => max((factor * 0x10000).ceil(), 1);

  const CompassPortraitLayout({
    super.key,
    this.arLayout = 0,
    required this.locationInfo,
    required this.bearingInfo,
    required this.compass,
  });
  final double arLayout;
  final PreferredSizeWidget locationInfo, bearingInfo;
  final Widget compass;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Spacer(flex: flex(1 - arLayout / 2)),
            locationInfo,
            Spacer(flex: flex(arLayout)),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: compass,
            ),
            bearingInfo,
            Spacer(flex: flex(1 - arLayout / 2))
          ],
        ),
      );
}

class CompassLandscapeLayout extends StatefulWidget {
  const CompassLandscapeLayout({
    super.key,
    this.arLayout = false,
    required this.locationInfo,
    required this.bearingInfo,
    required this.compass,
  });
  final bool arLayout;
  final PreferredSizeWidget locationInfo, bearingInfo;
  final Widget compass;
  @override
  State<StatefulWidget> createState() => CompassLandscapeLayoutState();
}

class CompassLandscapeLayoutState extends State<CompassLandscapeLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  late final transition =
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.arLayout ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(covariant CompassLandscapeLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.arLayout) {
      animation.forward();
    } else {
      animation.reverse();
    }
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final center = constraints.biggest.center(Offset.zero);

          final columnDivider = center.dy +
              (widget.locationInfo.preferredSize.height -
                      widget.bearingInfo.preferredSize.height) /
                  2;
          final rowDivider = min(
            center.dx +
                (widget.locationInfo.preferredSize.width -
                        widget.bearingInfo.preferredSize.width) /
                    2,
            constraints.maxWidth - widget.bearingInfo.preferredSize.width - 16,
          );
          final rowHeight = max(
            widget.locationInfo.preferredSize.height,
            widget.bearingInfo.preferredSize.height,
          );

          return Stack(
            children: [
              PositionedTransition(
                rect: transition.drive(
                  RelativeRectTween(
                    begin: RelativeRect.fromLTRB(8, 4, center.dx + 8, 4),
                    end: const RelativeRect.fromLTRB(8, 4, 8, 4),
                  ),
                ),
                child: AlignTransition(
                  alignment: transition.drive(
                    Tween(
                      begin: Alignment.centerRight,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: widget.compass,
                ),
              ),
              Positioned(
                left: center.dx,
                top: columnDivider - 8,
                right: 8,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizeTransition(
                    axis: Axis.horizontal,
                    axisAlignment: -1.0,
                    sizeFactor: transition.drive(Tween(begin: 1, end: 0)),
                    child: const Divider(),
                  ),
                ),
              ),
              Positioned(
                left: rowDivider - 8,
                top: 8,
                height: rowHeight,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizeTransition(
                    sizeFactor: transition,
                    axisAlignment: 1.0,
                    child: const VerticalDivider(),
                  ),
                ),
              ),
              PositionedTransition(
                rect: transition.drive(
                  RelativeRectTween(
                    begin: RelativeRect.fromLTRB(
                      center.dx,
                      8,
                      8,
                      constraints.maxHeight - columnDivider + 8,
                    ),
                    end: RelativeRect.fromLTRB(
                      8,
                      8,
                      constraints.maxWidth - rowDivider + 8,
                      8,
                    ),
                  ),
                ),
                child: AlignTransition(
                  alignment: transition.drive(
                    Tween(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: widget.locationInfo,
                ),
              ),
              PositionedTransition(
                rect: transition.drive(
                  RelativeRectTween(
                    begin: RelativeRect.fromLTRB(
                      center.dx,
                      columnDivider + 8,
                      8,
                      8,
                    ),
                    end: RelativeRect.fromLTRB(rowDivider + 8, 8, 8, 8),
                  ),
                ),
                child: widget.bearingInfo,
              )
            ],
          );
        },
      );
}

class CompassViewport extends StatelessWidget {
  static final _projection = Matrix4.identity()..setEntry(3, 2, .002);

  const CompassViewport({super.key, required this.orientation, this.builder});
  final QuaternionDecomposition orientation;
  final Widget? Function(BuildContext context, Quaternion magnetic)? builder;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final center = constraints.biggest.center(Offset.zero);

            final transform =
                _projection * orientation.background.asTransform() as Matrix4;

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
              child: builder?.call(context, orientation.foreground),
            );
          },
        ),
      );
}

class LocationInfo extends StatelessWidget implements PreferredSizeWidget {
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

  static double estimateTextWidth(String text) => ((ParagraphBuilder(
        Compass.defaultTextStyle.getParagraphStyle(),
      )..addText(text))
              .build()
            ..layout(const ParagraphConstraints(width: double.infinity)))
          .maxIntrinsicWidth;

  LocationInfo({
    super.key,
    this.waypoint,
    required this.bearing,
    required this.distanceSystem,
    required this.crossAxisAlignment,
  });
  final Station? waypoint;
  final ValueStream<Angle> bearing;
  final ValueListenable<DistanceSystem> distanceSystem;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  late final preferredSize = Size(
    max(
      326,
      waypoint == null
          ? 0.0
          : 14.4 + 4 + estimateTextWidth(waypoint!.shortTitle),
    ),
    Compass.lineHeight * (waypoint == null ? 1 : 3),
  );

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
                    height: Compass.defaultTextStyle.fontSize,
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
              ValueListenableBuilder(
                valueListenable: distanceSystem,
                builder: (context, distanceSystem, _) => StreamBuilder(
                  initialData: bearing.value,
                  stream: bearing.stream,
                  builder: (context, bearing) => Text(
                    formatHeading(
                      waypoint!.marker.toHeading(position.data!.toLatLng()),
                      bearing.data,
                      distanceSystem,
                    ),
                  ),
                ),
              )
          ],
        ),
      );
}

class BearingInfo extends StatelessWidget implements PreferredSizeWidget {
  const BearingInfo({
    super.key,
    required this.trueBearing,
    required this.magnetic,
    required this.crossAxisAlignment,
  });
  final ValueStream<Angle> trueBearing, magnetic;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  get preferredSize => const Size(158, Compass.lineHeight * 2);

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
                  mainAxisSize: MainAxisSize.min,
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
      ..rotate(pi / 2);

    if (accuracy > 0) {
      // Gradient.sweep cannot paint accuracy 0.
      canvas.drawArc(
        Offset(-center.dy, -center.dx) & size,
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
      );
    }

    canvas.drawLine(
      Offset.zero,
      Offset(-center.dy, 0),
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
    required this.accuracy,
  });
  final List<CompassMarker<LatLng>> waypoints;
  final ValueStream<LatLng?> position;
  final InitializedValueStream<Angle> accuracy;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: accuracy.value,
        stream: accuracy.stream,
        builder: (context, accuracy) => StreamBuilder(
          initialData: position.value,
          stream: position.stream,
          builder: (context, position) => CustomPaint(
            size: Size.infinite,
            painter: _HeadingsPainter(
              headings: [
                if (position.hasData)
                  for (final waypoint in waypoints)
                    waypoint
                        .map((location) => location.toHeading(position.data!))
              ],
              accuracy: accuracy.data!.radians,
            ),
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

  _HeadingsPainter({required this.headings, required this.accuracy});
  final List<CompassMarker<Heading>> headings;
  final double accuracy;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(center.dx, center.dy);

    canvas.translate(center.dx, center.dy);
    final accuracyArcClip = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Rect.fromCircle(center: Offset.zero, radius: radius))
      ..addOval(
        Rect.fromCircle(
          center: Offset.zero,
          radius: radius - 2 * markerRadius,
        ),
      );

    for (final heading in headings) {
      final markerCenter = Offset(markerRadius - radius, 0);

      canvas
        ..save()
        // Gradient.sweep has trouble blending across 0, so paint about pi.
        ..rotate(heading.location.angle.radians + pi / 2);

      if (accuracy > 0) {
        // Gradient.sweep cannot paint accuracy 0.
        canvas
          ..save()
          ..clipPath(accuracyArcClip)
          ..drawArc(
            Offset(-radius, -radius) & size,
            pi - accuracy,
            2 * accuracy,
            true,
            Paint()
              ..shader = Gradient.sweep(
                Offset.zero,
                [heading.color, heading.color.withAlpha(0)],
                null,
                TileMode.mirror,
                pi,
                pi + accuracy,
              )
              ..blendMode = BlendMode.plus,
          )
          ..restore();
      }

      canvas
        ..drawLine(
          Offset.zero,
          Offset(-radius, 0),
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
      !const ListEquality().equals(headings, oldDelegate.headings) ||
      accuracy != oldDelegate.accuracy;
}
