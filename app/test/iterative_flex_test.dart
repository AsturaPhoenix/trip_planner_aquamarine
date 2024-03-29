import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_planner_aquamarine/widgets/iterative_flex.dart';

void main() {
  group('row', () {
    testWidgets('each pass is constrained to the remaining size',
        (tester) async {
      tester.binding.window
        ..devicePixelRatioTestValue = 1
        ..physicalSizeTestValue = const Size(3, 1);

      await tester.pumpWidget(IterativeRow(
        children: const [
          IterativeFlexible(pass: 2, child: SizedBox(width: 1, height: 1)),
          IterativeFlexible(pass: 1, child: SizedBox(width: 1, height: 1)),
          SizedBox(width: 1, height: 1),
        ],
      ));

      expect(tester.renderObject(find.byType(SizedBox).at(2)).constraints,
          BoxConstraints.loose(const Size(3, 1)));
      expect(tester.renderObject(find.byType(SizedBox).at(1)).constraints,
          BoxConstraints.loose(const Size(2, 1)));
      expect(tester.renderObject(find.byType(SizedBox).at(0)).constraints,
          BoxConstraints.loose(const Size(1, 1)));
    });
  });

  group('column', () {
    testWidgets('each pass is constrained to the remaining size',
        (tester) async {
      tester.binding.window
        ..devicePixelRatioTestValue = 1
        ..physicalSizeTestValue = const Size(1, 3);

      await tester.pumpWidget(IterativeColumn(
        children: const [
          IterativeFlexible(pass: 2, child: SizedBox(width: 1, height: 1)),
          IterativeFlexible(pass: 1, child: SizedBox(width: 1, height: 1)),
          SizedBox(width: 1, height: 1),
        ],
      ));

      expect(tester.renderObject(find.byType(SizedBox).at(2)).constraints,
          BoxConstraints.loose(const Size(1, 3)));
      expect(tester.renderObject(find.byType(SizedBox).at(1)).constraints,
          BoxConstraints.loose(const Size(1, 2)));
      expect(tester.renderObject(find.byType(SizedBox).at(0)).constraints,
          BoxConstraints.loose(const Size(1, 1)));
    });

    testWidgets('pass 0 omitted', (tester) async {
      await tester.pumpWidget(IterativeColumn(children: const [
        IterativeFlexible(pass: 1, child: SizedBox.expand())
      ]));

      expect(tester.getSize(find.byType(SizedBox)),
          tester.getSize(find.byType(IterativeColumn)));
    });
  });
}
