import 'dart:async';

import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart'
    show
        GameStateEvent,
        PlayRequest,
        PlayerInputs,
        PlayingClient,
        PlayingClientEvent;
import 'package:batufo/shared/generated/message_bus.pbgrpc.dart'
    show GameClient;
import 'package:batufo/shared/models/player_model.dart';
import 'package:grpc/grpc.dart';

class Client {
  String serverHost;
  ClientChannel _channel;
  GameClient _updatesClient;
  PlayingClient _playingClient;
  Arena _arena;

  final _inputEvent$ = StreamController<PlayingClientEvent>();
  ResponseStream<GameStateEvent> _gameStateEvent$;

  Arena get arena => _arena;
  ResponseStream<GameStateEvent> get gameStateEvent$ => _gameStateEvent$;

  int get clientID => _playingClient.clientID;

  void submitPlayerInputs(PlayerInputs playerInputs) {
    _inputEvent$.add(PlayingClientEvent()..playerInputs = playerInputs);
  }

  void _init(String serverURL) {
    serverHost = serverURL;
    _createClient();
  }

  Future<void> _requestToPlay(String levelName) async {
    final request = PlayRequest()..levelName = levelName;
    _playingClient = await _updatesClient.play(request);
    _arena = Arena.unpack(_playingClient.arena);
    await _updatesClient.clientStates(_inputEvent$.stream);
    _gameStateEvent$ = _updatesClient.subscribeGameStates(_playingClient);
  }

  void _createClient() {
    final channelOpts =
        ChannelOptions(credentials: ChannelCredentials.insecure());
    _channel = ClientChannel(serverHost, port: 8080, options: channelOpts);
    final clientOpts = CallOptions(timeout: null);
    _updatesClient = GameClient(_channel, options: clientOpts);
  }

  void dispose() {
    if (!_inputEvent$.isClosed) _inputEvent$?.close();
  }

  static Future<Client> create(String levelName, String serverHost) async {
    final client = Client().._init(serverHost);
    await client._requestToPlay(levelName);
    return client;
  }
}

Future<void> main(List<String> args) async {
  final client = await Client.create('simple', 'localhost');
  client.gameStateEvent$.listen(_onGameStateEvent);
}

void _onGameStateEvent(GameStateEvent event) {
  final infos = event.gameState.players.map((x) {
    final player = PlayerModel.unpack(x);
    return 'id: ${player.id} => ${player.angle}';
  });
  print('\n-------------------------\n');
  print(infos.join('\n'));
}