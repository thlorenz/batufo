import 'dart:math';
import 'dart:ui';

import 'package:batufo/engine/game.dart';
import 'package:batufo/engine/physics.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/background.dart';
import 'package:batufo/game/bullets.dart';
import 'package:batufo/game/colliders.dart';
import 'package:batufo/game/grid.dart';
import 'package:batufo/game/player.dart';
import 'package:batufo/game/walls.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/inputs/gestures.dart';
import 'package:batufo/inputs/keyboard.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/game_model.dart';
import 'package:flutter/cupertino.dart';

class BatufoGame extends Game {
  final GameModel _game;
  Player _player;
  final Background _background;
  final Grid _grid;
  final Walls _walls;
  final Bullets _bullets;
  final double _bulletForce;

  Offset _camera;
  Offset _backgroundCamera;
  Size _size;

  BatufoGame(this._game)
      : _grid = Grid(GameProps.tileSize),
        _background = Background(
          _game.floorTiles,
          GameProps.tileSize,
          GameProps.renderBackground,
        ),
        _walls = Walls(_game.walls, GameProps.tileSize),
        _bullets = Bullets(_game.bullets),
        _camera = Offset.zero,
        _backgroundCamera = Offset.zero,
        _bulletForce = GameProps.bulletForce {
    final colliders = Colliders(
      _game.nrows,
      _game.ncols,
      walls: _game.walls,
    );
    _player = Player(
      playerImagePath: GameProps.assets.player.imagePath,
      tileSize: GameProps.tileSize,
      hitSize: GameProps.playerSize,
      keyboardRotationFactor: GameProps.keyboardPlayerRotationFactor,
      keyboardThrustForce: GameProps.keyboardPlayerThrustForce,
      wallHitSlowdown: GameProps.playerHitsWallSlowdown,
      wallHitHealthTollFactor: GameProps.playerHitsWallHealthFactor,
      thrustAnimationDurationMs: GameProps.playerThrustAnimationDurationMs,
      colliderAt: colliders.colliderAt,
    );
  }

  void update(double dt, double ts) {
    final pressedKeys = GameKeyboard.pressedKeys;
    final gestures = GameGestures.instance.aggregatedGestures;
    _player.update(
      dt,
      pressedKeys,
      gestures,
      _game.player,
      _game.stats,
    );
    _bullets.update(dt);

    // firing bullets
    if (pressedKeys.contains(GameKey.Fire)) {
      final p = _game.player;
      final bullet = BulletModel(
        velocity: Physics.increaseVelocity(
          p.velocity,
          p.angle,
          _bulletForce,
        ),
        tilePosition: Physics.scaleAlongAngle(
          _game.player.tilePosition,
          p.angle,
          GameProps.playerSize * 0.85,
        ),
      );
      _bullets.add(bullet);
    }

    _cameraFollow(
      _game.player.tilePosition.toWorldPosition(),
      dt,
    );
  }

  void render(Canvas canvas) {
    _lowerLeftCanvas(canvas, _size.height);

    canvas.save();
    canvas.translate(-_backgroundCamera.dx, -_backgroundCamera.dy);
    _grid.render(canvas, _game.nrows, _game.ncols);
    canvas.restore();

    canvas.translate(-_camera.dx, -_camera.dy);
    _background.render(canvas);
    _walls.render(canvas);
    _player.render(canvas, _game.player);
    _bullets.render(canvas);
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
    final backgroundLerp = 0.8;
    final dx = (moved.dx - _camera.dx) * lerp;
    final dy = (moved.dy - _camera.dy) * lerp;
    _camera = _camera.translate(dx, dy);
    _backgroundCamera = _backgroundCamera.translate(
      dx * backgroundLerp,
      dy * backgroundLerp,
    );
  }

  void _lowerLeftCanvas(Canvas canvas, double height) {
    canvas.translate(0, height);
    canvas.scale(1, -1);
  }
}
