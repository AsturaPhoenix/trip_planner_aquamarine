import 'package:flutter/widgets.dart';

/// A scroll controller subordinate to a parent controller, which
/// [createScrollPosition]s via the parent and attaches/detaches its positions
/// from the parent. This is useful for creating nested scroll controllers
/// for widgets with scrollbars that can actuate a parent scroll controller.
class SubordinateScrollController extends ScrollController {
  SubordinateScrollController(
    this.parent, {
    String subordinateDebugLabel = 'subordinate',
  }) : super(
          debugLabel: parent.debugLabel == null
              ? null
              : '${parent.debugLabel}/$subordinateDebugLabel',
          initialScrollOffset: parent.initialScrollOffset,
          keepScrollOffset: parent.keepScrollOffset,
        );
  final ScrollController parent;
  // Although some use cases might seem to be simplified if parent were made
  // settable, we can't really do this because scroll positions are owned by
  // Scrollables rather than the scroll controller, so the scroll view is
  // responsible for transferring positions from one controller to another. If
  // we were to try to do the transfer here, we would end up trying to dispose
  // of positions that Scrollables may still be holding on to.

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) =>
      parent.createScrollPosition(physics, context, oldPosition);

  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    parent.attach(position);
  }

  @override
  void detach(ScrollPosition position) {
    parent.detach(position);
    super.detach(position);
  }

  // Don't detach positions from the parent on dispose as that remains the
  // Scrollable's responsibility. Related, Scrollable tends to detach positions
  // in didUpdateWidget, which may actually happen after this was disposed.
}

abstract class ScrollControllerProvider extends StatefulWidget {
  const ScrollControllerProvider._();
  ScrollController? get scrollController;
}

mixin SubordinateScrollControllerStateMixin<T extends ScrollControllerProvider>
    on State<T> {
  ScrollController? get scrollController => _scrollController;
  ScrollController? _scrollController;

  @protected
  ScrollController? wrapScrollController(ScrollController? controller) =>
      controller == null ? null : SubordinateScrollController(controller);

  @override
  void initState() {
    super.initState();
    _scrollController = wrapScrollController(widget.scrollController);
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      _scrollController?.dispose();
      _scrollController = wrapScrollController(widget.scrollController);
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }
}

mixin WithFallback<T extends ScrollControllerProvider>
    on SubordinateScrollControllerStateMixin<T> {
  @override
  ScrollController get scrollController => super.scrollController!;

  @override
  ScrollController wrapScrollController(ScrollController? controller) =>
      super.wrapScrollController(controller) ?? ScrollController();
}
