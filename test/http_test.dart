/// Imports
/// ------------------------------------------------------------------------------------------------

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana_jsonrpc/jsonrpc.dart';


/// JSON RPC HTTP Tests
/// ------------------------------------------------------------------------------------------------

/// Method Definition.
class GetBlockHeight extends JsonRpcMethod<int, int> {
  GetBlockHeight(): super('getBlockHeight');
  @override int decoder(final int value) => value;
  @override Object? params([Commitment? commitment]) => null;
}

/// Context Method Definition.
class GetBalance extends JsonRpcContextMethod<int, int> {
  GetBalance(this.pubkey): super('getBalance');
  final String pubkey;
  @override int valueDecoder(final int value) => value;
  @override Object? params([final Commitment? commitment]) => [pubkey];
}

void main() {
   
  final client = JsonRpcHttpClient(Cluster.devnet.uri);

  test('get block height (no context)', () async {
    final method = GetBlockHeight();
    final response = await client.send(method.request(), method.response);
    print(jsonEncode(response)); // {"jsonrpc":"2.0","result":197469478,"id":1}
  });
  
  test('get balance (with context)', () async {
    final method = GetBalance('83astBRguLMdt2h5U1Tpdq5tjFoJ6noeGwaY3mDLVcri');
    final response = await client.send(method.request(), method.response);
    print(jsonEncode(response)); // {"jsonrpc":"2.0","result":{"context":{"slot":1},"value":0},"id":1}
  });

  test('batch request', () async {
    final method = JsonRpcMethodBuilder<dynamic, dynamic>([
      GetBlockHeight(),
      GetBalance('83astBRguLMdt2h5U1Tpdq5tjFoJ6noeGwaY3mDLVcri')
    ]);
    final response = await client.sendAll(method.request(), method.response);
    print(jsonEncode(response)); // [{"jsonrpc":"2.0","result":1,"id":1},{"jsonrpc":"2.0","result":{"context":{"slot":1},"value":0},"id":1}]
  });
}