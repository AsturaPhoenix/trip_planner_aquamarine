import 'dart:async';

import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/util/value_stream.dart';

void main() {
  test('refCount', () async {
    MultiStreamController<Object>? controller;
    final source = Stream<Object>.multi((newController) {
      expect(controller, null);
      controller = newController;
      newController.onCancel = () => controller = null;
    });

    final dest = source.refCount();
    expect(controller, null);

    var val1 = Completer<Object>();
    final sub1 = dest.listen((event) => val1.complete(event));
    expect(controller, isNotNull);

    final event1 = Object();
    controller!.add(event1);
    expect(await val1.future, event1);

    val1 = Completer();
    var val2 = Completer<Object>();
    final sub2 = dest.listen((event) => val2.complete(event));

    final event2 = Object();
    controller!.add(event2);
    expect(await val1.future, event2);
    expect(await val2.future, event2);

    await sub2.cancel();
    expect(controller, isNotNull);
    await sub1.cancel();
    expect(controller, null);

    dest.listen((_) {});
    expect(controller, isNotNull);
  });
}
