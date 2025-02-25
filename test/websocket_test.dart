/// Imports
/// ------------------------------------------------------------------------------------------------

import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana_jsonrpc/jsonrpc.dart';


/// JSON RPC Websocket Tests
/// ------------------------------------------------------------------------------------------------

void main() {
   
   final client = JsonRpcWebsocketClient.withStringDecoder(
    Cluster.localhost.toWebsocket(8900).uri,
  );

  test('get epoch info', () async {
    await client.send(
      const JsonRpcRequest(
        id: 1,
        method: 'accountSubscribe',
        params: ['917CtDaNoMK7hAqhhoSGUbvvW38TCv5Zf4k2zTXxNf1m']
      ),
      (input) {
        print('WS RESPONSE DECODER $input');
        final x = JsonRpcSuccessResponse.fromJson(input);
        return x;
      });
      await Future.delayed(const Duration(seconds: 30));
  });

  test('web socket connection failed', () async {
    final JsonRpcWebsocketClient socket = JsonRpcWebsocketClient.withByteDecoder(
        Uri.parse('wss://example_server'), 
        maxAttempts: 3, 
        backoffSchedule: [0, 1000], 
    );
    try {
      await socket.connect();
      throw Exception('Expected connection failure');
    } on WebSocketException catch (_) {
      // print(error);
    }
  });

  test('web socket timed out', () async {
    final JsonRpcWebsocketClient socket = JsonRpcWebsocketClient.withByteDecoder(
      Uri.parse('wss://example_server'), 
      maxAttempts: 30, 
      backoffSchedule: [0, 1000], 
      timeLimit: const Duration(seconds: 5),
    );
    try {
      await socket.connect();
      throw Exception('Expected connection timed out');
    } on TimeoutException catch (_) {
      // print(error);
    }
  });
}