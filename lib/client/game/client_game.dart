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
import 'package:batufo/client/game/inputs/input_processor.dart';
import 'package:batufo/client/game/inputs/input_synchronizer.dart';
import 'package:batufo/client/game/inputs/keyboard.dart';
import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/controllers/game_controller.dart';
import 'package:batufo/shared/controllers/helpers/player_status.dart';
import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/engine/world_position.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/messaging/player_inputs.dart';
import 'package:batufo/shared/models/game_model.dart';
import 'package:batufo/shared/models/player_model.dart';

final _log = Log<ClientGame>();

class ClientGame extends Game {
  final ClientGameState gameState;
  final Arena arena;
  final Background _background;
  final Grid _grid;
  final Walls _walls;
  final GameController _gameController;
  final InputProcessor _inputProcessor;
  final InputSynchronizer _inputSynchronizer;
  final int clientID;

  Map<int, Player> _players;
  Bullets _bullets;

  Offset _camera;
  Offset _backgroundCamera;
  Size _size;
  bool _disposed;

  bool get disposed => _disposed;

  int get numberOfAlivePlayers {
    return gameState.players.values.where((x) => x.health > 0).length;
  }

  ClientGame({
    @required this.arena,
    @required this.gameState,
    @required this.clientID,
    @required Function(PlayerInputs playerInputs) submitPlayerInputs,
  })  : _disposed = false,
        _gameController = GameController(arena, gameState),
        _grid = Grid(GameProps.tileSize),
        _background = Background(
          arena.floorTiles,
          GameProps.tileSize,
          GameProps.renderBackground,
        ),
        _walls = Walls(arena.walls, GameProps.tileSize),
        _inputProcessor = InputProcessor(
          keyboardRotationFactor: GameProps.keyboardPlayerRotationFactor,
          keyboardThrustForce: GameProps.playerThrustForce,
          timeBetweenThrusts: GameProps.timeBetweenThrustsMs,
          timeBetweenBullets: GameProps.timeBetweenBulletsMs,
        ),
        _inputSynchronizer = InputSynchronizer(
          submitPlayerInputs,
          GameProps.playerInputSyncIntervalMs,
        ),
        _camera = Offset.zero,
        _backgroundCamera = Offset.zero {
    _players = <int, Player>{};
    for (final clientID in gameState.players.keys) {
      _players[clientID] = _initPlayer();
    }

    _bullets = Bullets(
      msToExplode: GameProps.bulletMsToExplode,
      tileSize: GameProps.tileSize,
    );
  }

  PlayerModel get clientPlayer {
    final player = gameState.players[clientID];
    assert(player != null, 'our player with id $clientID should exist');
    return player;
  }

  void update(double dt, double ts) {
    if (_disposed) return;
    if (!PlayerStatus(clientPlayer).isDead) {
      final pressedKeys = GameKeyboard.pressedKeys;
      final gestures = GameGestures.instance.aggregatedGestures;

      _inputProcessor.udate(dt, pressedKeys, gestures, clientPlayer);
      _inputSynchronizer.update(dt, clientPlayer);
    }
    _gameController.update(dt, ts);
  }

  void updateUI(double dt, double ts) {
    if (_disposed) return;
    _cameraFollow(
      clientPlayer.tilePosition.toWorldPosition(),
      dt,
    );
    for (final entry in gameState.players.entries) {
      _players[entry.key].updateSprites(entry.value, dt);
    }
    _bullets.updateSprites(gameState.bullets, dt);
  }

  void render(Canvas canvas) {
    if (_disposed) return;
    _lowerLeftCanvas(canvas, _size.height);

    canvas.save();
    {
      canvas.translate(-_backgroundCamera.dx, -_backgroundCamera.dy);
      _grid.render(canvas, arena.nrows, arena.ncols);
    }
    canvas.restore();

    {
      canvas.translate(-_camera.dx, -_camera.dy);
      _background.render(canvas);
      _walls.render(canvas);
      for (final entry in gameState.players.entries) {
        _players[entry.key].render(canvas, entry.value);
      }
      _bullets.render(canvas, gameState.bullets);
    }
  }

  void cleanup() {
    if (_disposed) return;
    _gameController.cleanup();
  }

  void resize(Size size) {
    if (_disposed) return;
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
      deadPlayerImagePath: assets.skull.imagePath,
      tileSize: GameProps.tileSize,
      hitSize: GameProps.playerSize,
      thrustAnimationDurationMs: GameProps.playerThrustAnimationDurationMs,
    );
  }

  void dispose() {
    _log.fine('disposing');
    _disposed = true;
  }
}
