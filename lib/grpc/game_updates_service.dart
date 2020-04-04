import 'dart:async';

import 'package:batufo/generated/message_bus.pbgrpc.dart';
import 'package:batufo/grpc/message_types/game_state_event.dart';
import 'package:batufo/grpc/server_game/arena.dart';
import 'package:batufo/grpc/server_game/server_game.dart';
import 'package:batufo/utils/ids.dart';
import 'package:grpc/grpc.dart';

class GameUpdatesService extends GameUpdatesServiceBase {
  int _currentGameID;
  final Map<int, ServerGame> _games;

  GameUpdatesService() : _games = <int, ServerGame>{};

  final _gameStateEvent$ = StreamController<GameStateEvent>.broadcast();
  Stream<GameStateEvent> get gameStateEvent$ => _gameStateEvent$.stream;

  Future<PlayingClient> play(ServiceCall call, PlayRequest request) {
    final arena = Arena.forLevel(request.levelName);
    final game = _getOrCreateCurrentGame(arena);

    final clientID = getRandomInt();
    final playingClient = PlayingClient()
      ..gameID = game.id
      ..clientID = clientID
      ..arena = arena.pack();

    game
      ..addClient(playingClient)
      ..tryStart();
    return Future.value(playingClient);
  }

  Stream<GameStateEvent> subscribeGameStates(
    ServiceCall call,
    PlayingClient request,
  ) {
    final game = _games[request.gameID];
    assert(game != null, 'cannot find game ${request.gameID}');
    return game.gameState$.map((gs) {
      final event = GameStateEvent()..gameState = gs.pack();
      return event;
    });
  }

  Future<Empty> playingClientSync(
    ServiceCall call,
    Stream<PlayingClientEvent> request,
  ) {
    StreamSubscription<PlayingClientEvent> sub;
    sub = request.listen(
      _processPlayingClientEvent,
      onDone: () => sub.cancel(),
      onError: print,
      cancelOnError: true,
    );
    return Future.value(Empty());
  }

  void _processPlayingClientEvent(PlayingClientEvent event) {
    final client = event.client;
    final game = _games[client.gameID];
    assert(game != null, 'cannot find game with id ${client.gameID}');
    // TODO: tell the game about the player input
  }

  ServerGame _getOrCreateCurrentGame(Arena arena) {
    ServerGame game;
    if (_games.isEmpty || _games[_currentGameID].isFull) {
      _currentGameID = getRandomInt();
      final gameState = GameState();
      game = ServerGame(_currentGameID, gameState: gameState, arena: arena);
      _games[_currentGameID] = game;
    } else {
      game = _games[_currentGameID];
    }
    return game;
  }

  void dispose() {
    if (!_gameStateEvent$.isClosed) _gameStateEvent$?.close();
    for (final game in _games.values) game.dispose();
  }
}
