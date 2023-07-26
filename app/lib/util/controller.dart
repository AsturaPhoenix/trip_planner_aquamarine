import 'package:flutter/foundation.dart';

class Controller extends ChangeNotifier {
  int _depth = 0;

  @override
  @protected
  void notifyListeners() {
    if (_depth == 0) super.notifyListeners();
  }

  /// Sets state and notifies listeners. This method may be called re-entrantly,
  /// and will suppress any calls to [notifyListeners] until all nested calls
  /// have completed.
  @protected
  void setState(VoidCallback fn) {
    ++_depth;
    try {
      fn();
    } finally {
      --_depth;
    }
    notifyListeners();
  }
}
