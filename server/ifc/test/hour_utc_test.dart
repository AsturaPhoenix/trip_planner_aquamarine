import 'package:aquamarine_server_interface/types.dart';
import 'package:test/test.dart';

void main() {
  test('comparisons', () {
    final earlier = HourUtc(2023, 03, 26, 22),
        earlier2 = HourUtc(2023, 03, 26, 22),
        later = HourUtc(2023, 03, 27, 01);

    // Caution: lessThanOrEqualTo and similar matchers actually only use <, >,
    // and ==, so they won't catch bugs in operator <= and similar.

    expect(earlier == earlier2, isTrue);
    expect(earlier < later, isTrue);
    expect(earlier <= later, isTrue);
    expect(earlier <= earlier2, isTrue);
    expect(later > earlier, isTrue);
    expect(later >= earlier, isTrue);
    expect(earlier >= earlier2, isTrue);

    expect(earlier == later, isFalse);
    expect(later < earlier, isFalse);
    expect(later <= earlier, isFalse);
    expect(earlier > later, isFalse);
    expect(earlier >= later, isFalse);
  });

  test('arithmetic', () {
    expect(HourUtc(2023, 03, 26, 22) + 3, HourUtc(2023, 03, 27, 01));
    expect(HourUtc(2023, 03, 27, 01) - 3, HourUtc(2023, 03, 26, 22));
  });
}
