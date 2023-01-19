import 'dart:async';

import 'package:mockito/mockito.dart';

extension MockExtensions<T> on PostExpectation<Future<T>> {
  Completer<T> thenComplete() {
    final completer = Completer<T>();
    thenAnswer((_) => completer.future);
    return completer;
  }
}
