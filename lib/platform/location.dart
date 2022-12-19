import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/value_stream.dart';

/// Most browsers won't surface a location permission request unless we're using
/// https.
final bool canRequestLocation =
    !kIsWeb || Uri.base.scheme == 'https' || Uri.base.host == 'localhost';

Future<bool> requestPermission() => _permissionRequest.fetch(
      () async {
        final wasEnabled = isEnabled.value;
        if (kIsWeb) {
          _isEnabled.add(true);
        } else {
          _permissionStatus.add(await Permission.locationWhenInUse.request());
          _isEnabled.add(permissionStatus.value!.isGranted);
        }

        if (_passivePosition.streamController.hasListener &&
            wasEnabled != isEnabled.value) {
          if (isEnabled.value) {
            _subscribePassivePosition();
          } else {
            _passivePositionSubscription!.cancel();
            _passivePosition.add(null);
          }
        }
        return isEnabled.value;
      },
    );
final _permissionRequest = AsyncCache<bool>.ephemeral();

final isEnabled = _isEnabled.valueStream;
final _isEnabled =
    InitializedValueStreamController<bool>(StreamController.broadcast(), false);
final permissionStatus = _permissionStatus.valueStream;
final _permissionStatus =
    ValueStreamController<PermissionStatus>(StreamController.broadcast());

final Stream<Position?> requestedPosition = Stream.multi(
  (controller) async => controller.addStream(
    await requestPermission()
        ? passivePosition.seededStream.skipWhile((position) => position == null)
        : passivePosition.seededStream,
  ),
);

final passivePosition =
    _passivePosition.valueStream.transform((s, _) => s.refCount());

StreamSubscription? _passivePositionSubscription;
final _passivePosition = ValueStreamController<Position?>(
  StreamController.broadcast(
    onListen: () {
      if (isEnabled.value) {
        _subscribePassivePosition();
      }
    },
    onCancel: () {
      if (isEnabled.value) {
        _passivePositionSubscription!.cancel();
      }
    },
  ),
);

void _subscribePassivePosition() {
  _passivePositionSubscription =
      Geolocator.getPositionStream().listen(_passivePosition.add);
}

abstract class Distance {
  static const zero = Meters(0);

  const Distance();
  double get kilometers;
  double get meters;
  double get miles;
  double get feet;
  double get nauticalMiles;
  Distance operator -();
  Distance operator +(Distance other);
  Distance operator -(Distance other) => this + -other;
  Distance operator *(double factor);
}

class Meters extends Distance {
  const Meters(this.meters);
  @override
  double get kilometers => meters / 1000;
  @override
  final double meters;
  @override
  get miles => kilometers * 0.621371;
  @override
  get feet => miles * 5280;
  @override
  get nauticalMiles => miles * 0.868976;
  @override
  Distance operator -() => Meters(-meters);
  @override
  Distance operator +(Distance other) => Meters(meters + other.meters);
  @override
  Distance operator *(double factor) => Meters(meters * factor);
}
