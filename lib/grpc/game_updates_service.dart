import 'dart:async';

import 'package:batufo/generated/message_bus.pbgrpc.dart';
import 'package:batufo/grpc/game_loop.dart';
import 'package:batufo/grpc/message_types/game_state_event.dart';
import 'package:batufo/utils/ids.dart';
import 'package:grpc/grpc.dart';

class Game {
  final int id;
  final List<PlayingClient> clients;
  final GameLoop _gameLoop;

  Game(this.id, GameState gameState, {List<PlayingClient> clients})
      : this.clients = clients ?? <PlayingClient>[],
        _gameLoop = GameLoop(gameState);

  void start() {
    _gameLoop.tryStart();
  }

  Stream<GameState> get gameState$ => _gameLoop.gameState$;

  void dispose() {
    _gameLoop.dispose();
  }
}

class GameUpdatesService extends GameUpdatesServiceBase {
  int _currentGameID;
  final Map<int, Game> _games;

  GameUpdatesService() : _games = Map<int, Game>();

  final _gameStateEvent$ = StreamController<GameStateEvent>.broadcast();
  Stream<GameStateEvent> get gameStateEvent$ => _gameStateEvent$.stream;

  Future<PlayingClient> play(ServiceCall call, Empty request) {
    final game = _getOrCreateCurrentGame();

    final clientID = getRandomInt();
    final playingClient = PlayingClient()
      ..gameID = game.id
      ..clientID = clientID;

    game.clients.add(playingClient);
    return Future.value(playingClient);
  }

  Stream<GameStateEvent> subscribeGameStates(
    ServiceCall call,
    PlayingClientEvent event$,
    ) {
  }

  Stream<GameStateEvent> sync(
    ServiceCall call,
    Stream<PlayingClientEvent> event$,
  ) {
    // TODO: process player inputs found inside the event
  }

  void _processPlayingClientEvent(PlayingClientEvent event) {
    final client = event.client;
    final game = _games[client.gameID]
    assert(game != null, 'cannot find game with id ${client.gameID}');
  }

  Game _getOrCreateCurrentGame() {
    Game game;
    if (_games.isEmpty) {
      _currentGameID = getRandomInt();
      final gameState = GameState();
      game = Game(_currentGameID, gameState);
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
