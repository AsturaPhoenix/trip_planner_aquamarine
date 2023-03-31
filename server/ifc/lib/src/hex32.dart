import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Hex32 extends Equatable {
  static const zero = Hex32(0);

  /// Truncates [uint32] appropriately.
  const Hex32(int uint32) : value = uint32 & 0xffffffff;

  /// Truncates to the first four bytes of [bytes]. The `uint32` [value] is big
  /// endian.
  Hex32.fromBytes(List<int> bytes)
      : value = ByteData.sublistView(Uint8List.fromList(bytes)).getUint32(0);

  /// Parses a uint32 from a hexadecimal string literal. Does not make an effort
  /// to sanitize quirks of [int.parse]; leading and trailing whitespace is
  /// allowed, as is a leading '+'.
  Hex32.parse(String hex32) : value = int.parse(hex32, radix: 16) {
    if (value < 0) {
      throw FormatException(
        'Hex string must be nonnegative.',
        hex32,
        hex32.indexOf('-'),
      );
    }
  }
  final int value;

  @override
  get props => [value];

  @override
  String toString() => value.toRadixString(16).padLeft(8, '0');

  // Big endian bytes.
  List<int> toBytes() =>
      (ByteData(4)..setUint32(0, value)).buffer.asUint8List();
}
