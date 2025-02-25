
/// Imports
/// ------------------------------------------------------------------------------------------------

import 'package:flutter_test/flutter_test.dart';
import 'package:solana_jsonrpc/jsonrpc.dart';


/// JSON RPC Cluster Tests
/// ------------------------------------------------------------------------------------------------

void main() {

  test('cluster', () {
    const String devhost = 'api.devnet.solana.com';
    final Cluster devCluster = Cluster.https(devhost);         
    expect(devCluster.uri.toString(), 'https://api.devnet.solana.com');

    const String localhost = '127.0.0.1';
    final Cluster localCluster = Cluster.http(localhost, port: 8899);         
    expect(localCluster.uri.toString(), 'http://127.0.0.1:8899');
    final Cluster wsLocalCluster = Cluster.ws(localhost, port: 8900);         
    expect(wsLocalCluster.uri.toString(), 'ws://127.0.0.1:8900');
    
    expect(devCluster.uri.toString(), 'https://api.devnet.solana.com');
    expect(localCluster.uri.toString(), 'http://127.0.0.1:8899');
    expect(wsLocalCluster.uri.toString(), 'ws://127.0.0.1:8900');
  });

  test('cluster toWebsocket', () {
    final Cluster devCluster = Cluster.devnet;
    expect(devCluster.toWebsocket().uri.toString(), 'wss://api.devnet.solana.com');

    final Cluster localCluster = Cluster.localhost;
    final Cluster wsCluster = localCluster.toWebsocket();     
    expect(wsCluster.uri.toString(), 'ws://127.0.0.1:8899');
    expect(wsCluster.toWebsocket(8900).uri.toString(), 'ws://127.0.0.1:8900');

    expect(devCluster.uri.toString(), 'https://api.devnet.solana.com');
    expect(devCluster.toWebsocket().uri.toString(), 'wss://api.devnet.solana.com');
    expect(localCluster.uri.toString(), 'http://127.0.0.1:8899');
    expect(wsCluster.uri.toString(), 'ws://127.0.0.1:8899');
    expect(wsCluster.toWebsocket(8900).uri.toString(), 'ws://127.0.0.1:8900');
  });

  test('cluster uri', () {
    final Cluster cluster = Cluster.devnet;
    expect(cluster.uri.toString(), 'https://api.devnet.solana.com');
    expect(cluster.uri.replace(path: 'api/path').toString(), 'https://api.devnet.solana.com/api/path');
    expect(cluster.uri.toString(), 'https://api.devnet.solana.com');
    expect(cluster.uri.replace(path: 'api/path').toString(), 'https://api.devnet.solana.com/api/path');
  });
}
