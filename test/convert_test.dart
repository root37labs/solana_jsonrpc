/// Imports
/// ------------------------------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana_jsonrpc/src/converters/json_to_bytes_codec.dart';


/// Convert Test
/// ------------------------------------------------------------------------------------------------

void main() {

  test('json', () {
    const codec = JsonToBytesCodec();
    final jsonData = { "a": 0 };
    final byteData = codec.encode(jsonData);
    expect(mapEquals(jsonData, codec.decode(byteData) as Map), true); // { a: 0 };
  });

  test('json to bytes', () async {
    const Map<String, dynamic> value = { "a": 0, "b": 1, "c": 2 };
    const jsonToBytes = JsonToBytesCodec();
    final List<int> encoded = jsonToBytes.encode(value);
    expect(value, jsonToBytes.decode(encoded));
  });
}