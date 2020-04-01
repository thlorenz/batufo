import 'dart:async';

import 'package:batufo/generated/message_bus.pbgrpc.dart';
import 'package:batufo/models/player_model.dart';
import 'package:grpc/grpc.dart';

class Client {
  ClientChannel channel;
  GameUpdatesClient updatesClient;
  PlayingClient playingClient;

  final _inputEvent$ = StreamController<PlayingClientEvent>();

  void init(List<String> args) {
    _createClient();
  }

  Future<Stream<GameStateEvent>> requestToPlay() async {
    playingClient = await updatesClient.play(Empty());
    await updatesClient.playingClientSync(_inputEvent$.stream);
    return updatesClient.subscribeGameStates(playingClient);
  }

  void submitPlayerInputs(PlayerInputs playerInputs) {
    _inputEvent$.add(PlayingClientEvent()..playerInputs = playerInputs);
  }

  void _createClient() {
    final channelOpts =
        ChannelOptions(credentials: ChannelCredentials.insecure());
    channel = ClientChannel('localhost', port: 8080, options: channelOpts);
    final clientOpts = CallOptions(timeout: null);
    updatesClient = GameUpdatesClient(channel, options: clientOpts);
  }

  void dispose() {
    if (!_inputEvent$.isClosed) _inputEvent$?.close();
  }
}

void main(List<String> args) async {
  final client = Client()..init(args);
  final event$ = await client.requestToPlay();
  print('playing with ${client.playingClient}');
  event$.listen(_onGameStateEvent);
}

void _onGameStateEvent(GameStateEvent event) {
  final infos = event.gameState.players.map((x) {
    final player = PlayerModel.unpack(x);
    return 'id: ${player.id} => ${player.angle}';
  });
  print('\n-------------------------\n');
  print(infos.join('\n'));
}
