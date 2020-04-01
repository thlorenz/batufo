import 'package:batufo/generated/message_bus.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class Client {
  ClientChannel channel;
  GameUpdatesClient updatesClient;

  void init(List<String> args) {
    _createClient();
  }

  ResponseFuture<PlayingClient> requestToPlay() {
    return updatesClient.play(Empty());
  }

  void _createClient() {
    final channelOpts =
        ChannelOptions(credentials: ChannelCredentials.insecure());
    channel = ClientChannel('localhost', port: 8080, options: channelOpts);
    final clientOpts = CallOptions(timeout: null);
    updatesClient = GameUpdatesClient(channel, options: clientOpts);
  }
}

void main(List<String> args) async {
  final client = Client()..init(args);
  final playingClient = await client.requestToPlay();
  print('playing with $playingClient');
}
