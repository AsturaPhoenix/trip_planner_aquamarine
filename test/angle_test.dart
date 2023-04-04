import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/util/angle.dart';

void main() {
  test('equals and hashCode', () {
    expect(const Radians(0) == Angle.zero, true);
    expect(const Radians(0).hashCode, Angle.zero.hashCode);
  });
}
