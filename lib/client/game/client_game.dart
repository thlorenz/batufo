import 'dart:math';
import 'dart:ui' show Canvas, Offset, Size;

import 'package:batufo/client/engine/game.dart';
import 'package:batufo/client/game/assets/assets.dart';
import 'package:batufo/client/game/entities/background.dart';
import 'package:batufo/client/game/entities/bullets.dart';
import 'package:batufo/client/game/entities/grid.dart';
import 'package:batufo/client/game/entities/player.dart';
import 'package:batufo/client/game/entities/walls.dart';
import 'package:batufo/client/game/inputs/gestures.dart';
import 'package:batufo/client/game/inputs/keyboard.dart';
import 'package:batufo/shared/controllers/game_controller.dart';
import 'package:batufo/shared/engine/world_position.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/models/game_model.dart';

class ClientGame extends Game {
  final GameModel _game;
  final Background _background;
  final Grid _grid;
  final Walls _walls;
  final GameController _gameController;

  Map<int, Player> _players;
  Bullets _bullets;

  Offset _camera;
  Offset _backgroundCamera;
  Size _size;

  ClientGame(this._game)
      : _gameController = GameController(_game),
        _grid = Grid(GameProps.tileSize),
        _background = Background(
          _game.floorTiles,
          GameProps.tileSize,
          GameProps.renderBackground,
        ),
        _walls = Walls(_game.walls, GameProps.tileSize),
        _camera = Offset.zero,
        _backgroundCamera = Offset.zero {
    _players = <int, Player>{};
    for (final clientID in _game.players.keys) {
      _players[clientID] = _initPlayer();
    }

    _bullets = Bullets(
      msToExplode: GameProps.bulletMsToExplode,
      tileSize: GameProps.tileSize,
    );
  }

  void update(double dt, double ts) {
    // game controller updater
    final pressedKeys = GameKeyboard.pressedKeys;
    final gestures = GameGestures.instance.aggregatedGestures;
    // _gameController.update(dt, ts, pressedKeys, gestures);
  }

  void updateUI(double dt, double ts) {
    /*
    _cameraFollow(
      _game.players.tilePosition.toWorldPosition(),
      dt,
    );
     */
    for (final entry in _game.players.entries) {
      _players[entry.key].updateSprites(entry.value, dt);
    }
    _bullets.updateSprites(_game.bullets, dt);
  }

  void render(Canvas canvas) {
    _lowerLeftCanvas(canvas, _size.height);

    canvas.save();
    {
      canvas.translate(-_backgroundCamera.dx, -_backgroundCamera.dy);
      _grid.render(canvas, _game.nrows, _game.ncols);
    }
    canvas.restore();

    {
      canvas.translate(-_camera.dx, -_camera.dy);
      _background.render(canvas);
      _walls.render(canvas);
      for (final entry in _game.players.entries) {
        _players[entry.key].render(canvas, entry.value);
      }
      _bullets.render(canvas, _game.bullets);
    }
  }

  void resize(Size size) {
    _size = size;
  }

  void _cameraFollow(WorldPosition wp, double dt) {
    if (_size == null) return;
    final pos = wp.toOffset();
    final centerScreen = Offset(_size.width / 2, _size.height / 2);
    final moved = Offset(pos.dx - centerScreen.dx, pos.dy - centerScreen.dy);

    final lerp = min(0.0025 * dt, 1.0);
    const backgroundLerp = 0.8;
    final dx = (moved.dx - _camera.dx) * lerp;
    final dy = (moved.dy - _camera.dy) * lerp;
    _camera = _camera.translate(dx, dy);
    _backgroundCamera = _backgroundCamera.translate(
      dx * backgroundLerp,
      dy * backgroundLerp,
    );
  }

  void _lowerLeftCanvas(Canvas canvas, double height) {
    canvas
      ..translate(0, height)
      ..scale(1, -1);
  }

  Player _initPlayer() {
    return Player(
      playerImagePath: assets.player.imagePath,
      tileSize: GameProps.tileSize,
      hitSize: GameProps.playerSize,
      thrustAnimationDurationMs: GameProps.playerThrustAnimationDurationMs,
    );
  }
}
