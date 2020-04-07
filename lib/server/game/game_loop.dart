import 'dart:async';

import 'package:batufo/shared/controllers/game_controller.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/engine/geometry/dart_geometry.dart';
import 'package:batufo/shared/models/game_state.dart';
import 'package:batufo/shared/models/player_model.dart';

const TICK_DURATION = 100;
final _log = Log<GameLoop>();

class GameLoop {
  bool _started;
  final GameController _gameController;
  DateTime _lastTick;
  GameLoop(this._gameController) : _started = false;

  final _gameState$ = StreamController<GameState>.broadcast();
  Stream<GameState> get gameState$ => _gameState$.stream;

  void start(int gameID) {
    assert(!_started, 'cannot start the game loop twice');
    _log.info('starting gameloop $gameID');
    _started = true;
    _scheduleTick();
  }

  void addPlayer(PlayerModel player) {
    _gameController.addPlayer(player);
    player.velocity = Offset(0.08, 0.0);
  }

  void _scheduleTick() {
    Future.delayed(Duration(milliseconds: TICK_DURATION), _tick);
  }

  void _tick() {
    final ts = DateTime.now();
    final double dt = _lastTick == null
        ? Duration.zero.inMicroseconds / 1E3
        : ts.difference(_lastTick).inMicroseconds / 1E3;
    final gameState = _gameController.update(
      dt,
      ts.microsecondsSinceEpoch / 1E3,
    );
    _lastTick = ts;

    _log.finest('tick: $dt');
    _log.finest(gameState.toString());

    _gameState$.add(gameState);
    _scheduleTick();
  }

  void dispose() {
    if (!_gameState$.isClosed) _gameState$?.close();
  }
}
