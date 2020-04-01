import 'dart:async';

import 'message_types/game_state_event.dart';

class GameLoop {
  GameState _currentGameState;
  GameLoop(this._currentGameState);

  final _gameState$ = StreamController<GameState>.broadcast();
  Stream<GameState> get gameState$ => _gameState$.stream;

  bool tryStart() {
    if (!_currentGameState.enoughPlayers) return false;
  }

  void dispose() {
    if (!_gameState$.isClosed) _gameState$?.close();
  }
}
