import 'package:aquamarine_server_interface/types.dart';
import 'package:test/test.dart';

void main() {
  group('from int', () {
    test('truncates sign', () {
      expect(Hex32(-1), Hex32(0xffffffff));
    });

    test('not equals', () {
      expect(Hex32(0), isNot(Hex32(1)));
    });

    test('toString', () {
      expect(Hex32(0x0).toString(), '00000000');
      expect(Hex32(0xf).toString(), '0000000f');
      expect(Hex32(-1).toString(), 'ffffffff');
    });
  });

  group('from string', () {
    test('parses ffffffff', () {
      expect(Hex32.parse('ffffffff'), Hex32(0xffffffff));
    });

    test('throws on bad suffix', () {
      expect(() => Hex32.parse('0u'), throwsA(isA<FormatException>()));
      expect(() => Hex32.parse('0.'), throwsA(isA<FormatException>()));
    });

    test('throws on bad prefix', () {
      expect(() => Hex32.parse('0x0'), throwsA(isA<FormatException>()));
    });

    test('throws on negative', () {
      expect(() => Hex32.parse('-1'), throwsA(isA<FormatException>()));
    });
  });
}
