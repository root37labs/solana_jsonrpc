<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

### A HTTP and Websocket client for Solana's [JSON RPC API](https://docs.solana.com/developing/clients/jsonrpc-api) methods.

```dart
import 'dart:convert' show jsonEncode;
import 'package:solana_jsonrpc/jsonrpc.dart';

void main() async {
  final client = JsonRpcHttpClient(Cluster.devnet.uri);
  final method = GetBalance('83astBRguLMdt2h5U1Tpdq5tjFoJ6noeGwaY3mDLVcri');
  final response = await client.send(method.request(), method.response);
  print(jsonEncode(response)); // {"jsonrpc":"2.0","result":{"context":{"slot":1},"value":0},"id":1}
}

class GetBalance extends JsonRpcContextMethod<int, int> {
  GetBalance(final String pubkey): super('getBalance', values: [pubkey]);
  @override int valueDecoder(final int value) => value;
}
```