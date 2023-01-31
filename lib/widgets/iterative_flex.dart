import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class IterativeColumn extends IterativeFlex {
  IterativeColumn({super.key, required super.children})
      : super(direction: Axis.vertical);
}

class IterativeRow extends IterativeFlex {
  IterativeRow({super.key, required super.children})
      : super(direction: Axis.horizontal);
}

/// A column that lays outs its children by giving them constraints based on the
/// remaining size in the layout as calculated between iterative layout passes.
/// Layout pass 0 is based on this widget's constraints.
///
/// To specify a layout pass or to adjust the allotted size constraint, wrap the
/// child in an [IterativeFlexible].
///
/// Once all the sizing passes are complete, all children are positioned in
/// sequence.
class IterativeFlex extends StatelessWidget {
  IterativeFlex({
    super.key,
    required this.direction,
    required List<Widget> children,
  }) {
    for (int i = 0; i < children.length; ++i) {
      _wrappedChildren.add(LayoutId(id: i, child: children[i]));
      if (children[i] is IterativeFlexible) {
        final flexible = children[i] as IterativeFlexible;
        while (_layoutDelegate.layoutPasses.length <= flexible.pass) {
          _layoutDelegate.layoutPasses.add({});
        }
        _layoutDelegate
          ..layoutPasses[flexible.pass][i] = flexible.sizeAllocator
          ..flexIndices.add(i);
      }
    }
  }
  final _wrappedChildren = <Widget>[];
  late final _IterativeColumnLayoutDelegate _layoutDelegate =
      _IterativeColumnLayoutDelegate(direction);

  final Axis direction;

  @override
  Widget build(BuildContext context) => CustomMultiChildLayout(
        delegate: _layoutDelegate,
        children: _wrappedChildren,
      );
}

typedef SizeAllocator = double Function(double availableSize);

class IterativeFlexible extends StatelessWidget {
  const IterativeFlexible({
    super.key,
    required this.pass,
    this.sizeAllocator,
    required this.child,
  });
  final int pass;
  final SizeAllocator? sizeAllocator;
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

class _IterativeColumnLayoutDelegate extends MultiChildLayoutDelegate {
  _IterativeColumnLayoutDelegate(this.direction);

  final Axis direction;
  final layoutPasses = [<int, SizeAllocator?>{}];
  final flexIndices = <int>{};

  Offset offset({required double main, required double cross}) =>
      direction == Axis.vertical ? Offset(cross, main) : Offset(main, cross);

  double main(Size size) =>
      direction == Axis.vertical ? size.height : size.width;
  double cross(Size size) =>
      direction == Axis.vertical ? size.width : size.height;

  BoxConstraints constrain(
    BoxConstraints baseConstraints,
    double availableSize,
  ) =>
      direction == Axis.vertical
          ? baseConstraints.copyWith(maxHeight: availableSize)
          : baseConstraints.copyWith(maxWidth: availableSize);

  @override
  void performLayout(Size size) {
    final baseConstraints = BoxConstraints.loose(size);
    var availableSize = main(size);

    var passSize = 0.0;
    final layouts = <Size>[];
    for (int i = 0; hasChild(i); ++i) {
      if (flexIndices.contains(i)) {
        layouts.add(Size.zero);
      } else {
        final layout = layoutChild(i, baseConstraints);
        passSize += main(layout);
        layouts.add(layout);
      }
    }

    for (final pass in layoutPasses) {
      for (final sizeAllocator in pass.entries) {
        final layout = layoutChild(
          sizeAllocator.key,
          constrain(
            baseConstraints,
            sizeAllocator.value?.call(availableSize) ?? availableSize,
          ),
        );
        passSize += main(layout);
        layouts[sizeAllocator.key] = layout;
      }
      availableSize -= passSize;
      passSize = 0.0;
    }

    var position = 0.0;
    for (int i = 0; hasChild(i); ++i) {
      positionChild(
        i,
        offset(main: position, cross: (cross(size) - cross(layouts[i])) / 2),
      );
      position += main(layouts[i]);
    }
  }

  @override
  bool shouldRelayout(covariant _IterativeColumnLayoutDelegate oldDelegate) {
    if (this == oldDelegate) return false;

    return !const DeepCollectionEquality()
        .equals(layoutPasses, oldDelegate.layoutPasses);
    // flexIndices is cached from layoutPasses
  }
}
