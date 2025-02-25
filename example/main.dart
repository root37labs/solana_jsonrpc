import 'dart:convert' show jsonEncode;
import 'package:solana_jsonrpc/jsonrpc.dart';

void main() async {
  final client = JsonRpcHttpClient(Cluster.devnet.uri);
  final method = GetBalance('83astBRguLMdt2h5U1Tpdq5tjFoJ6noeGwaY3mDLVcri');
  final response = await client.send(method.request(), method.response);
  print(jsonEncode(response)); // {"jsonrpc":"2.0","result":{"context":{"slot":1},"value":0},"id":1}
}

class GetBalance extends JsonRpcContextMethod<int, int> {
  GetBalance(this.pubkey): super('getBalance');
  final String pubkey;
  @override int valueDecoder(final int value) => value;
  @override Object? params([final Commitment? commitment]) => [pubkey];
}