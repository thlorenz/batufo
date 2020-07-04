import 'dart:math';
import 'dart:ui' show Canvas, Offset, Paint, Rect, Size;

import 'package:batufo/arena/arena.dart';
import 'package:batufo/arena/pickup.dart';
import 'package:batufo/controllers/game_controller.dart';
import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/game.dart';
import 'package:batufo/engine/physics.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/entities/bombs.dart';
import 'package:batufo/game/entities/buildings.dart';
import 'package:batufo/game/entities/bullets.dart';
import 'package:batufo/game/entities/grid.dart';
import 'package:batufo/game/entities/pickups.dart';
import 'package:batufo/game/entities/planets.dart';
import 'package:batufo/game/entities/player.dart';
import 'package:batufo/game/entities/radar.dart';
import 'package:batufo/game/entities/stars.dart';
import 'package:batufo/game/entities/teleports.dart';
import 'package:batufo/game/inputs/gestures.dart';
import 'package:batufo/game/inputs/input_processor.dart';
import 'package:batufo/game/inputs/keyboard.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/client_game_state.dart';
import 'package:batufo/models/pickups_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/radar_model.dart';
import 'package:batufo/rpc/client_picked_up_update.dart';
import 'package:batufo/rpc/client_player_update.dart';
import 'package:batufo/rpc/client_spawned_bomb_update.dart';
import 'package:batufo/rpc/client_spawned_bullet_update.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

final _log = Log<ClientGame>();

final _backgroundPaint = Paint()
  ..color = Colors.black
  ..style = PaintingStyle.fill;

class ClientGame extends Game {
  final Arena arena;
  final void Function(ClientGameState state) onGameStateUpdated;
  final Buildings _buildings;
  final Grid _grid;
  final Stars _starsBack;
  final Stars _starsMiddle;
  final Stars _starsFront;
  final Planets _planetsBack;
  final Planets _planetsFront;
  final Teleports _teleports;
  final InputProcessor inputProcessor;
  final SoundController soundController;
  final int clientID;
  final ClientPlayerUpdate _clientPlayerUpdate;
  final ClientSpawnedBulletUpdate _clientSpawnedBulletUpdate;
  final ClientSpawnedBombUpdate _clientSpawnedBombUpdate;
  final _clientPlayerUpdate$ = BehaviorSubject<ClientPlayerUpdate>();
  final _clientSpawnedBulletUpdate$ =
      BehaviorSubject<ClientSpawnedBulletUpdate>();
  final _clientSpawnedBombUpdate$ = BehaviorSubject<ClientSpawnedBombUpdate>();
  final _clientPickedUpUpdate$ = BehaviorSubject<ClientPickedUpUpdate>();

  final double _bottomMargin;

  GameController _gameController;
  Map<int, Player> _players;
  Bullets _bullets;
  Pickups _pickups;
  Bombs _bombs;
  Radar _radar;

  Offset _z10Camera;
  Offset _z20Camera;
  Offset _z30Camera;
  Offset _z40Camera;
  Offset _z100Camera;
  Offset _arenaCamera;
  Rect _z0VisibleRect;
  Rect _z10VisibleRect;
  Rect _z20VisibleRect;
  Rect _z30VisibleRect;
  Rect _z40VisibleRect;
  Rect _z100VisibleRect;
  Rect _arenaVisibleRect;
  Size _size;
  bool _disposed;
  bool _started;
  bool _finished;

  bool get disposed => _disposed;
  bool get started => _started;
  bool get finished => _finished;
  bool get ready => _started && !_disposed;
  bool hasPlayer(int clientID) => gameState.hasPlayer(clientID);

  Stream<ClientPlayerUpdate> get clientPlayerUpdate$ =>
      _clientPlayerUpdate$.stream;
  Stream<ClientSpawnedBulletUpdate> get clientSpawnedBulletUpdate$ =>
      _clientSpawnedBulletUpdate$.stream;
  Stream<ClientSpawnedBombUpdate> get clientSpawnedBombUpdate$ =>
      _clientSpawnedBombUpdate$.stream;

  Stream<ClientPickedUpUpdate> get clientPickedUpUpdate$ =>
      _clientPickedUpUpdate$.stream;

  ClientGame({
    @required this.inputProcessor,
    @required this.arena,
    @required this.clientID,
    @required this.onGameStateUpdated,
    @required this.soundController,
    @required void Function(int score) onScored,
    @required List<List<bool>> coveredTiles,
    @required int playerIndex,
    @required ParallaxProps parallaxProps,
    @required bool enableRecording,
    @required bool enableGradient,
    @required bool addBottomRow,
  })  : _started = false,
        _finished = false,
        _disposed = false,
        _bottomMargin = addBottomRow ? arena.tileSize * 1.0 : 0.0,
        _clientPlayerUpdate = ClientPlayerUpdate(),
        _clientSpawnedBulletUpdate = ClientSpawnedBulletUpdate(),
        _clientSpawnedBombUpdate = ClientSpawnedBombUpdate(),
        _grid = Grid(arena.tileSize.toDouble()),
        _starsBack = Stars(
          arena.tileSize.toDouble(),
          enableRecording: enableRecording,
          minRadius: 0.1,
          maxRadius: 0.4,
          density: parallaxProps.starsBackDensity,
          coveredTiles: coveredTiles,
          debugVisibleRect: GameProps.debugZ0VisibleRect,
        ),
        _starsMiddle = Stars(
          arena.tileSize.toDouble(),
          enableRecording: enableRecording,
          minRadius: 0.3,
          maxRadius: 0.7,
          density: parallaxProps.starsMiddleDensity,
          coveredTiles: coveredTiles,
          debugVisibleRect: GameProps.debugZ10VisibleRect,
        ),
        _starsFront = Stars(
          arena.tileSize.toDouble(),
          enableRecording: enableRecording,
          minRadius: 0.8,
          maxRadius: 1.2,
          density: parallaxProps.starsFrontDensity,
          coveredTiles: coveredTiles,
          debugVisibleRect: GameProps.debugZ20VisibleRect,
        ),
        // Recording planets makes performance considerably worse
        _planetsBack = Planets(
          arena.tileSize.toDouble(),
          enableRecording: false,
          minRadius: 0.05,
          maxRadius: 0.25,
          density: parallaxProps.planetsBackDensity,
          debugVisibleRect: GameProps.debugZ30VisibleRect,
        ),
        _planetsFront = Planets(
          arena.tileSize.toDouble(),
          enableRecording: false,
          minRadius: 0.3,
          maxRadius: 0.5,
          density: parallaxProps.planetsFrontDensity,
          debugVisibleRect: GameProps.debugZ40VisibleRect,
        ),
        _buildings = Buildings(
          floorTiles: arena.floorTiles,
          walls: arena.walls,
          tileSize: arena.tileSize.toDouble(),
          isFloorActive: GameProps.renderFloor,
          enableRecording: enableRecording,
          debugVisibleRect: GameProps.debugZ100VisibleRect,
        ),
        _teleports = Teleports(
          arena.teleports,
          arena.tileSize,
          GameProps.teleportRadiusFromTileSizeFactor,
        ),
        _z10Camera = Offset.zero,
        _z20Camera = Offset.zero,
        _z30Camera = Offset.zero,
        _z40Camera = Offset.zero,
        _z100Camera = Offset.zero,
        _arenaCamera = Offset.zero {
    final tileSize = arena.tileSize.toDouble();
    _bullets = Bullets(
      msToExplode: GameProps.bulletMsToExplode,
      tileSize: tileSize,
    );
    _bombs = Bombs(tileSize: tileSize);

    assert(
      playerIndex < arena.players.length,
      '$playerIndex is out of range for ${arena.players}',
    );
    _players = <int, Player>{clientID: _initPlayer()};
    _gameController = GameController(
      arena,
      _heroOnlyGameState(playerIndex),
      onScored,
      _onPickedUp,
      clientID,
      soundController,
    );
    _pickups = Pickups(_gameController.gameState.pickups, arena.tileSize);
    _radar = Radar(
      _gameController.gameState.radar,
      enableGradient: enableGradient,
    );
  }

  ClientGameState get gameState => _gameController.gameState;
  int get totalPlayers => arena.players.length;

  PlayerModel get clientPlayer {
    final player = gameState.players[clientID];
    assert(player != null, 'our player with id $clientID should exist');
    return player;
  }

  ClientGameState _heroOnlyGameState(int playerIndex) {
    final playerStartPosition = arena.players[playerIndex];
    final hero = PlayerModel.forInitialPosition(
      clientID,
      playerStartPosition,
      GameProps.playerTotalHealth,
      GameProps.playerInitialBombs,
      GameProps.playerInitialBullets,
    );
    final radarLength = min(
      max(arena.size.width / 2, arena.size.height / 2),
      GameProps.radarMaxLength,
    );
    return ClientGameState(
      clientID: clientID,
      bullets: [],
      bombs: [],
      pickups: PickupsModel(arena.pickups),
      totalPlayers: arena.players.length,
      players: {clientID: hero},
      radar: RadarModel(
        deltaAngle: GameProps.radarDeltaAngle,
        radarLength: radarLength,
      ),
    );
  }

  void updatePlayers(PlayerModel player) {
    final id = player.id;
    _gameController.updatePlayer(player);
    _players.putIfAbsent(id, _initPlayer);
  }

  void removePickup(int col, int row) {
    _gameController.removePickup(col, row);
  }

  void removePlayer(int clientID) {
    _gameController.removePlayer(clientID);
    _players.remove(clientID);
  }

  void updateBullet(ClientSpawnedBulletUpdate update) {
    // this method is invoked for bullets spawned by opponents
    // bullets of the hero are handled inside InputProcessor
    soundController.playerFiredBullet(
      bulletPosition: update.spawnedBullet.tilePosition,
    );
    _gameController.addBullet(update.spawnedBullet);
  }

  void updateBomb(ClientSpawnedBombUpdate update) {
    _gameController.spawnBomb(update.spawnPosition, false);
  }

  void start() {
    if (_started) return;
    for (final clientID in gameState.players.keys) {
      _players[clientID] = _initPlayer();
    }
    _started = true;
  }

  void update(double dt, double ts) {
    if (!ready) return;
    final player = clientPlayer;
    if (!PlayerStatus.isDead(player)) {
      final pressedKeys = GameKeyboard.pressedKeys;
      final gestures = GameGestures.instance.aggregatedGestures;

      if (!player.teleportation.isActive) {
        inputProcessor.udate(
          dt,
          pressedKeys,
          gestures,
          player,
        );
      }
    }
    _gameController.update(dt, ts);
    _clientPlayerUpdate.player = gameState.players[clientID];
    _clientPlayerUpdate$.add(_clientPlayerUpdate);

    if (player.shotBullet) {
      _clientSpawnedBulletUpdate.spawnedBullet = gameState.bullets.last;
      _clientSpawnedBulletUpdate$.add(_clientSpawnedBulletUpdate);
    }
    if (player.spawnedBomb) {
      _gameController.spawnBomb(player.tilePosition, true);
      _clientSpawnedBombUpdate.spawnPosition = player.tilePosition;
      _clientSpawnedBombUpdate$.add(_clientSpawnedBombUpdate);
    }

    onGameStateUpdated(gameState);
  }

  void updateUI(double dt, double ts) {
    if (_disposed) return;
    _cameraFollow(
      clientPlayer.tilePosition.toWorldPosition(),
      dt,
    );
    final z10FullTranslate = _z10Camera;
    final z20FullTranslate = _z20Camera.translate(
      z10FullTranslate.dx,
      z10FullTranslate.dy,
    );
    final z30FullTranslate = _z30Camera.translate(
      z20FullTranslate.dx,
      z20FullTranslate.dy,
    );
    final z40FullTranslate = _z40Camera.translate(
      z30FullTranslate.dx,
      z30FullTranslate.dy,
    );

    _arenaCamera = Physics.simulateExplosion(
      _z100Camera,
      _gameController.getExplosionStrength(),
    );

    _z0VisibleRect = _visibleRectForCamera(Offset.zero);
    _z10VisibleRect = _visibleRectForCamera(z10FullTranslate);
    _z20VisibleRect = _visibleRectForCamera(z20FullTranslate);
    _z30VisibleRect = _visibleRectForCamera(z30FullTranslate);
    _z40VisibleRect = _visibleRectForCamera(z40FullTranslate);
    _z100VisibleRect = _visibleRectForCamera(_z100Camera);
    _arenaVisibleRect = _visibleRectForCamera(_arenaCamera);

    _starsBack.updateOffset(_z100Camera);
    _starsMiddle.updateOffset(_z100Camera - z10FullTranslate);
    _starsFront.updateOffset(_z100Camera - z20FullTranslate);
    if (!started) return;

    for (final entry in gameState.players.entries) {
      final player = _players[entry.key];
      if (player == null) continue;
      player.updateSprites(entry.value, dt);
    }
    _bullets.updateSprites(gameState.bullets, dt);

    _pickups.update();
  }

  Rect _visibleRectForCamera(Offset camera) {
    return Rect.fromLTWH(
      camera.dx,
      camera.dy - _bottomMargin,
      _size.width,
      _size.height + _bottomMargin,
    );
  }

  void _renderBackdrop(Canvas canvas) {
    if (GameProps.debugGrid) {
      _renderGrid(canvas);
    } else {
      _renderUniverse(canvas);
    }
  }

  void _renderGadgets(Canvas canvas) {
    _radar.render(canvas, _z100VisibleRect);
  }

  void _renderArena(Canvas canvas) {
    canvas.save();
    {
      canvas.translate(-_arenaCamera.dx, -_arenaCamera.dy);
      _buildings.render(canvas, _arenaVisibleRect, _size);
      _teleports.render(canvas, _arenaVisibleRect);

      _pickups.render(canvas, _z100VisibleRect);
      _bombs.render(canvas, gameState.bombs);
      for (final entry in gameState.players.entries) {
        final player = _players[entry.key];
        if (player == null) continue;
        _players[entry.key]
            .render(canvas, entry.value, entry.value.id == clientID);
      }
      _bullets.render(canvas, gameState.bullets);
    }
    canvas.restore();
  }

  void _renderGrid(Canvas canvas) {
    canvas.save();
    {
      canvas.translate(-_z10Camera.dx, -_z10Camera.dy);
      _grid.render(canvas, _z10VisibleRect, arena.nrows, arena.ncols);
    }
    canvas.restore();
  }

  void _renderUniverse(Canvas canvas) {
    canvas.save();
    {
      _drawBackground(canvas);
      _starsBack.render(canvas, _z0VisibleRect, _size);
      canvas.translate(-_z10Camera.dx, -_z10Camera.dy);
      _starsMiddle.render(canvas, _z10VisibleRect, _size);
      canvas.translate(-_z20Camera.dx, -_z20Camera.dy);
      _starsFront.render(canvas, _z20VisibleRect, _size);
      canvas.translate(-_z30Camera.dx, -_z30Camera.dy);
      _planetsBack.render(canvas, _z30VisibleRect, _size);
      canvas.translate(-_z40Camera.dx, -_z40Camera.dy);
      _planetsFront.render(canvas, _z40VisibleRect, _size);
    }
    canvas.restore();
  }

  void _drawBackground(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        _size.width,
        _size.height,
      ),
      _backgroundPaint,
    );
  }

  void render(Canvas canvas) {
    if (disposed) return;
    _lowerLeftCanvas(canvas, _size.height);

    _renderBackdrop(canvas);

    _renderArena(canvas);
    _renderGadgets(canvas);

    soundController.processSounds();
  }

  void cleanup() {
    if (!ready) return;
    _gameController.cleanup();
  }

  void resize(Size size) {
    _size = size;
    final ncols = arena.ncols;
    final nrows = arena.nrows;
    final tileSize = arena.tileSize;
    final arenaSize = Size(
      ncols * tileSize.toDouble(),
      nrows * tileSize.toDouble(),
    );

    final fullWidth = max(ncols * tileSize, size.width.ceil());
    final fullHeight = max(nrows * tileSize, size.height.ceil());
    final fullSize = Size(fullWidth.toDouble(), fullHeight.toDouble());
    _log.info('size:$size, arena: $arenaSize => $fullSize');
    _starsBack.resize(fullSize);
    _starsMiddle.resize(fullSize);
    _starsFront.resize(fullSize);
    _planetsBack.resize(fullSize);
    _planetsFront.resize(fullSize);
    _buildings.resize(fullSize);

    _gameController.resize(size);
  }

  void _cameraFollow(WorldPosition wp, double dt) {
    if (_size == null) return;
    final pos = wp.toOffset();
    final centerScreen = Offset(_size.width / 2, _size.height / 2);
    final moved = Offset(pos.dx - centerScreen.dx, pos.dy - centerScreen.dy);

    final lerp = min(0.0025 * dt, GameProps.z100Lerp);
    final dx = (moved.dx - _z100Camera.dx) * lerp;
    final dy = (moved.dy - _z100Camera.dy) * lerp;
    _z10Camera = _z10Camera.translate(
      dx * GameProps.z10Lerp,
      dy * GameProps.z10Lerp,
    );
    _z20Camera = _z20Camera.translate(
      dx * GameProps.z20Lerp,
      dy * GameProps.z20Lerp,
    );
    _z30Camera = _z30Camera.translate(
      dx * GameProps.z30Lerp,
      dy * GameProps.z30Lerp,
    );
    _z40Camera = _z40Camera.translate(
      dx * GameProps.z40Lerp,
      dy * GameProps.z40Lerp,
    );
    _z100Camera = _z100Camera.translate(dx, dy);
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
      teleportTotalTimeInMs: GameProps.teleportTotalTimeInMs,
    );
  }

  void finish() {
    _finished = true;
  }

  void dispose() {
    _finished = true;
    if (_disposed) return;
    _log.fine('disposing');
    if (_clientPlayerUpdate$ != null && !_clientPlayerUpdate$.isClosed) {
      _clientPlayerUpdate$.close();
    }
    if (_clientSpawnedBulletUpdate$ != null &&
        !_clientSpawnedBulletUpdate$.isClosed) {
      _clientSpawnedBulletUpdate$.close();
    }
    if (_clientSpawnedBombUpdate$ != null &&
        !_clientSpawnedBombUpdate$.isClosed) {
      _clientSpawnedBombUpdate$.close();
    }
    if (_clientPickedUpUpdate$ != null && !_clientPickedUpUpdate$.isClosed) {
      _clientPickedUpUpdate$.close();
    }
    _disposed = true;
  }

  void _onPickedUp(Pickup pickup) {
    final update = ClientPickedUpUpdate.fromPickup(pickup);
    _clientPickedUpUpdate$.add(update);
  }
}
