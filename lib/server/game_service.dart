import 'dart:async';

import 'package:batufo/server/game/game_state.dart';
import 'package:batufo/server/game/server_game.dart';
import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart';
import 'package:batufo/shared/generated/message_bus.pbgrpc.dart';
import 'package:batufo/shared/messaging/ids.dart';
import 'package:grpc/grpc.dart';

final _log = Log<GameService>();

class GameService extends GameServiceBase {
  int _currentGameID;
  final Map<int, ServerGame> _games;

  GameService() : _games = <int, ServerGame>{};

  final _gameStateEvent$ = StreamController<GameStateEvent>.broadcast();
  Stream<GameStateEvent> get gameStateEvent$ => _gameStateEvent$.stream;

  Future<PlayingClient> play(ServiceCall call, PlayRequest request) {
    final arena = Arena.forLevel(request.levelName);
    final game = _getOrCreateCurrentGame(arena);

    final clientID = getRandomInt();
    final playingClient = PlayingClient()
      ..gameID = game.gameID
      ..clientID = clientID
      ..arena = arena.pack();

    game
      ..addClient(playingClient)
      ..tryStart();
    return Future.value(playingClient);
  }

  Stream<GameStateEvent> syncClientAndGameStates(
    ServiceCall call,
    Stream<PlayingClientEvent> request,
  ) {
    final metadata = call.clientMetadata;
    assert(
      metadata.containsKey(GameProps.GAME_ID),
      'metata data is missing game id',
    );
    assert(
      metadata.containsKey(GameProps.CLIENT_ID),
      'metata data is missing client id',
    );
    final gameID = int.parse(metadata[GameProps.GAME_ID]);
    final clientID = int.parse(metadata[GameProps.CLIENT_ID]);

    StreamSubscription<PlayingClientEvent> sub;
    sub = request.listen(
      _processPlayingClientEvent,
      onDone: () => sub.cancel(),
      onError: (Object err, StackTrace stackTrace) =>
          _handleClientDisconnect(gameID, clientID, err, stackTrace),
      cancelOnError: true,
    );

    final game = _games[gameID];
    assert(game != null, 'cannot find game $gameID}');

    return game.gameState$.map((gs) {
      final event = GameStateEvent()..gameState = gs.pack();
      return event;
    });
  }

  void _handleClientDisconnect(
    int gameID,
    int clientID,
    Object err,
    StackTrace stackTrace,
  ) {
    // TODO(thlorenz): clean up games?
    _log.fine(stackTrace.toString());
    _log.info('client $clientID disconnected from game $gameID');
    _log.fine(err);
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
