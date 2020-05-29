import 'dart:math';
import 'dart:ui' show Canvas, Offset, Size;

import 'package:batufo/arena/arena.dart';
import 'package:batufo/controllers/game_controller.dart';
import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/game.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/entities/background.dart';
import 'package:batufo/game/entities/bullets.dart';
import 'package:batufo/game/entities/grid.dart';
import 'package:batufo/game/entities/player.dart';
import 'package:batufo/game/entities/walls.dart';
import 'package:batufo/game/inputs/gestures.dart';
import 'package:batufo/game/inputs/input_processor.dart';
import 'package:batufo/game/inputs/keyboard.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/client_game_state.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

final _log = Log<ClientGame>();

class ClientGame extends Game {
  final Arena arena;
  final Background _background;
  final Grid _grid;
  final Walls _walls;
  final InputProcessor _inputProcessor;
  final int clientID;

  ClientGameState gameState;
  GameController _gameController;
  Map<int, Player> _players;
  Bullets _bullets;

  Offset _camera;
  Offset _backgroundCamera;
  Size _size;
  bool _disposed;
  bool _started;

  bool get disposed => _disposed;
  bool get started => _started;
  bool get ready => !_disposed && _started;

  ClientGame({
    @required this.arena,
    @required this.clientID,
    @required int playerIndex,
  })  : _disposed = false,
        _started = false,
        _grid = Grid(arena.tileSize.toDouble()),
        _background = Background(
          arena.floorTiles,
          arena.tileSize.toDouble(),
          GameProps.renderBackground,
        ),
        _walls = Walls(arena.walls, arena.tileSize.toDouble()),
        _inputProcessor = InputProcessor(
          keyboardRotationFactor: GameProps.keyboardPlayerRotationFactor,
          keyboardThrustForce: GameProps.playerThrustForce,
          timeBetweenThrusts: GameProps.timeBetweenThrustsMs,
          timeBetweenBullets: GameProps.timeBetweenBulletsMs,
        ),
        _camera = Offset.zero,
        _backgroundCamera = Offset.zero {
    _bullets = Bullets(
      msToExplode: GameProps.bulletMsToExplode,
      tileSize: arena.tileSize.toDouble(),
    );

    assert(playerIndex < arena.players.length,
        '$playerIndex is out of range for ${arena.players}');
    _players = <int, Player>{clientID: _initPlayer()};
    gameState = _preStartGameState(playerIndex);
    _gameController = GameController(arena, gameState);
  }

  PlayerModel get clientPlayer {
    final player = gameState.players[clientID];
    assert(player != null, 'our player with id $clientID should exist');
    return player;
  }

  ClientGameState _preStartGameState(int playerIndex) {
    final playerStartPosition = arena.players[playerIndex];
    final hero = PlayerModel(
      id: clientID,
      health: GameProps.playerTotalHealth,
      velocity: Offset.zero,
      tilePosition: playerStartPosition,
      angle: 0,
    );
    return ClientGameState(
      clientID: clientID,
      bullets: [],
      players: {clientID: hero},
    );
  }

  void start() {
    if (_started) return;
    // this.gameState = gameState;
    for (final clientID in gameState.players.keys) {
      _players[clientID] = _initPlayer();
    }
    _started = true;
  }

  void update(double dt, double ts) {
    if (!ready) return;
    if (!PlayerStatus(clientPlayer).isDead) {
      final pressedKeys = GameKeyboard.pressedKeys;
      final gestures = GameGestures.instance.aggregatedGestures;

      _inputProcessor.udate(dt, pressedKeys, gestures, clientPlayer);
    }
    _gameController.update(dt, ts);
  }

  void updateUI(double dt, double ts) {
    if (_disposed) return;
    _cameraFollow(
      clientPlayer.tilePosition.toWorldPosition(),
      dt,
    );
    if (!started) return;

    for (final entry in gameState.players.entries) {
      final player = _players[entry.key];
      if (player == null) continue;
      player.updateSprites(entry.value, dt);
    }
    _bullets.updateSprites(gameState.bullets, dt);
  }

  void _renderArena(Canvas canvas) {
    _lowerLeftCanvas(canvas, _size.height);

    canvas.save();
    {
      canvas.translate(-_backgroundCamera.dx, -_backgroundCamera.dy);
      _grid.render(canvas, arena.nrows, arena.ncols);
    }
    canvas.restore();

    canvas.translate(-_camera.dx, -_camera.dy);
    _background.render(canvas);
    _walls.render(canvas);
  }

  void render(Canvas canvas) {
    if (disposed) return;
    _renderArena(canvas);

    for (final entry in gameState.players.entries) {
      final player = _players[entry.key];
      if (player == null) continue;
      _players[clientID].render(canvas, entry.value);
    }
    _bullets.render(canvas, gameState.bullets);
  }

  void cleanup() {
    if (!ready) return;
    _gameController.cleanup();
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
    final playerSize = GameProps.playerSizeFactor * arena.tileSize;
    return Player(
      playerImagePath: assets.player.imagePath,
      deadPlayerImagePath: assets.skull.imagePath,
      tileSize: arena.tileSize.toDouble(),
      hitSize: playerSize,
      thrustAnimationDurationMs: GameProps.playerThrustAnimationDurationMs,
    );
  }

  void dispose() {
    _log.fine('disposing');
    _disposed = true;
  }
}
