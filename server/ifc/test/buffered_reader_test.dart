import 'dart:convert';

import 'package:aquamarine_server_interface/src/buffered_reader.dart';
import 'package:test/test.dart';

import '../../test/util/chunker.dart';

void main() {
  group('consumeUntil', () {
    final marker = ascii.encode('BAD WOLF');

    forChunkers('not chunked', (chunker) {
      test('containing only', () async {
        final reader = BufferedReader(chunker([marker]));
        await reader.consumeUntil(marker);
        await reader.requireEnd();
      });

      test('prefix', () async {
        final reader = BufferedReader(chunker([
          marker,
          [0],
        ]));
        await reader.consumeUntil(marker);
        while (await reader.moveNext()) {}
        expect(reader.buffer, hasLength(1));
      });

      test('postfix', () async {
        final reader = BufferedReader(chunker([
          [0],
          marker,
        ]));
        await reader.consumeUntil(marker);
        await reader.requireEnd();
      });

      test('infix', () async {
        final reader = BufferedReader(chunker([
          [0],
          marker,
          [0],
        ]));
        await reader.consumeUntil(marker);
        while (await reader.moveNext()) {}
        expect(reader.buffer, hasLength(1));
      });
    });
  });
}
