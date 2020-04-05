import 'dart:async';

import 'package:batufo/server/game/game_state.dart';
import 'package:batufo/shared/models/player_model.dart';

const TICK_DURATION = 100;

class GameLoop {
  bool _started;
  final GameState _currentGameState;
  GameLoop(this._currentGameState) : _started = false;

  final _gameState$ = StreamController<GameState>.broadcast();
  Stream<GameState> get gameState$ => _gameState$.stream;

  void start() {
    assert(!_started, 'cannot start the game loop twice');
    _started = true;
    _scheduleTick();
  }

  void addPlayer(PlayerModel player) {
    _currentGameState.players[player.id] = player;
  }

  void _scheduleTick() {
    Future.delayed(Duration(milliseconds: TICK_DURATION), _tick);
  }

  void _tick() {
    // TODO: run controllers, ala _currentGameState = ...
    _currentGameState.players.values.forEach((p) => p.angle += 0.1);
    _gameState$.add(_currentGameState);
    _scheduleTick();
  }

  void dispose() {
    if (!_gameState$.isClosed) _gameState$?.close();
  }
}
