import 'dart:async';

import 'package:batufo/models/player_model.dart';

import 'message_types/game_state_event.dart';

const TICK_DURATION = 2000;

class GameLoop {
  bool _started;
  GameState _currentGameState;
  GameLoop(this._currentGameState) : _started = false;

  final _gameState$ = StreamController<GameState>.broadcast();
  Stream<GameState> get gameState$ => _gameState$.stream;

  bool tryStart() {
    if (_started) return true;
    if (!_currentGameState.enoughPlayers) return false;
    _started = true;
    _scheduleTick();
    return true;
  }

  void addPlayer(PlayerModel player) {
    _currentGameState.players[player.id] = player;
  }

  void _scheduleTick() {
    Future.delayed(Duration(milliseconds: TICK_DURATION), _tick);
  }

  void _tick() {
    // TODO: run controllers, ala _currentGameState = ...
    _currentGameState.players.values.forEach((p) => p.angle += 0.01);
    _gameState$.add(_currentGameState);
    _scheduleTick();
  }

  void dispose() {
    if (!_gameState$.isClosed) _gameState$?.close();
  }
}
