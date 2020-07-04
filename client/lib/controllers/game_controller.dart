import 'dart:math';
import 'dart:ui';

import 'package:batufo/arena/arena.dart';
import 'package:batufo/arena/pickup.dart';
import 'package:batufo/controllers/bombs_controller.dart';
import 'package:batufo/controllers/bullets_controller.dart';
import 'package:batufo/controllers/helpers/bullets_spawner.dart';
import 'package:batufo/controllers/helpers/colliders.dart';
import 'package:batufo/controllers/helpers/pickups_controller.dart';
import 'package:batufo/controllers/player_controller.dart';
import 'package:batufo/controllers/radar_controller.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/controllers/teleports_controller.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/bomb_model.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/client_game_state.dart';
import 'package:batufo/models/player_model.dart';

final _log = Log<GameController>();

class GameController {
  final BulletsSpawner _bulletsSpawner;
  final void Function(int score) onScored;
  final void Function(Pickup pickup) onPickedUp;
  final int clientID;
  final SoundController soundController;
  final ClientGameState _gameState;
  final Arena _arena;
  final RadarController _radarController;
  final TeleportsController _teleportsController;

  PlayerController _playerController;
  BulletsController _bulletsController;
  PickupsController _pickupsController;
  BombsController _bombsController;

  GameController(
    this._arena,
    this._gameState,
    this.onScored,
    this.onPickedUp,
    this.clientID,
    this.soundController,
  )   : _bulletsSpawner = BulletsSpawner(
          bulletForce: GameProps.bulletForce,
          playerSize: GameProps.playerSizeFactor * _arena.tileSize,
        ),
        _radarController = RadarController(radar: _gameState.radar),
        _teleportsController = TeleportsController(
          teleports: _arena.teleports,
          soundController: soundController,
          tileHitRadius: GameProps.teleportTileHitRadius,
          teleportTotalTimeInMs: GameProps.teleportTotalTimeInMs,
        ) {
    final playerSize = GameProps.playerSizeFactor * _arena.tileSize;
    final colliders = Colliders(
      _arena.nrows,
      _arena.ncols,
      walls: _arena.walls,
      floorTiles: _arena.floorTiles,
      playerRadius: playerSize,
      shieldRadiusFactor: GameProps.shieldRadiusFactor,
    );

    _playerController = PlayerController(
      soundController: soundController,
      hitSize: playerSize,
      wallHitSlowdown: GameProps.playerHitsWallSlowdown,
      wallHitHealthTollFactor: GameProps.playerHitsWallHealthFactor,
      playerCollidingAt: colliders.playerCollidingAt,
      isValidPosition: colliders.isValidPosition,
      thrustForce: GameProps.playerThrustForce,
    );

    _bulletsController = BulletsController(
      _gameState.bullets,
      soundController: soundController,
      bulletCollidingAt: colliders.bulletCollidingAt,
      onPlayerHitByBullet: _onPlayerHitByBullet,
      tileSize: _arena.tileSize.toDouble(),
    );

    _pickupsController = PickupsController(
      pickups: _gameState.pickups,
      colliders: colliders,
      soundController: soundController,
      onPickedUp: onPickedUp,
      shieldDurationSeconds: GameProps.shieldDurationMs,
      medkitPlayerHealthGain: GameProps.medkitPlayerHealthGain,
      playerTotalHealth: GameProps.playerTotalHealth,
    );

    _bombsController = BombsController(
      _gameState.bombs,
      soundController: soundController,
      bombStartExplosionStrength: GameProps.bombStartExplosionStrength,
      bombTimeExploding: GameProps.bombTimeExplodingMs,
      bombExplosionRadiusSquared: GameProps.bombExplosionRadiusSquared,
      bombDealtDamageFromStrengthFactor:
          GameProps.bombDealtDamageFromStrengthFactor,
      bombReducedShieldFromStrengthFactor:
          GameProps.bombReducedShieldFromStrengthFactor,
      bombScoreFromStrengthFactor: GameProps.bombScoreFromStrengthFactor,
      onScored: onScored,
    );
  }

  ClientGameState get gameState => _gameState;

  void resize(Size size) {}

  ClientGameState update(double dt, double ts) {
    final players = _gameState.players;
    final opponents = players.values.where((x) => x.id != clientID);
    final enemyWorldOffsets =
        opponents.map((x) => x.tilePosition.toWorldOffset(center: true));

    _log.finest('game loop ${players.length} players');
    for (final player in players.values) {
      _playerController.update(dt, player, player.id == clientID);
      if (player.shotBullet) _spawnBullet(player);
    }
    _bulletsController.update(dt, _gameState.players.values);
    _pickupsController.update(_gameState.hero);
    _bombsController.update(dt, _gameState.hero, opponents);
    _radarController.update(
      dt,
      _gameState.hero,
      _arena.buildingWorldOffsets,
      enemyWorldOffsets,
    );
    _teleportsController.update(dt, _gameState.hero);

    return _gameState;
  }

  void _onPlayerHitByBullet(PlayerModel player) {
    if (player.hasShield) {
      _handleShieldedPlayerBulletHit(player);
    } else {
      _handleUnshieldedPlayerBulletHit(player);
    }
  }

  void _handleShieldedPlayerBulletHit(PlayerModel player) {
    if (player.id == _gameState.clientID) {
      final remainingShieldMs =
          max(player.shieldRemainingMs - GameProps.shieldBulletHitLostMs, 0.0);
      player.shieldRemainingMs = remainingShieldMs;
    }
  }

  void _handleUnshieldedPlayerBulletHit(PlayerModel player) {
    final health =
        max(player.health - GameProps.bulletHitsPlayerHealthToll, 0.0);
    if (player.id == _gameState.clientID) {
      // if we are hit, we deal a health toll to ourselves
      player.health = health;
    } else {
      // if we (think) we hit someone, we gain score even if the someone doesn't
      // end up detecting he's hit. This is a bit inconsistent, but much easier
      // than having that someone communicate to us that he's hit.
      // In the worst case we get a bit more points.
      final score = health == 0 ? GameProps.scoreOnKill : GameProps.scoreOnHit;
      onScored(score);
    }
  }

  double getExplosionStrength() {
    return _bombsController.explosionStrength(gameState.hero.tilePosition);
  }

  void cleanup() {
    for (final x in _gameState.players.entries) {
      _playerController.cleanup(x.value);
    }
  }

  void updatePlayer(PlayerModel player) {
    assert(player != null, 'cannot add null as player');
    _gameState.updatePlayer(player);
  }

  void removePickup(int col, int row) {
    _pickupsController.removePickupAt(col, row);
  }

  void removePlayer(int clientID) {
    _gameState.removePlayer(clientID);
  }

  void addBullet(BulletModel bullet) {
    _gameState.addBullet(bullet);
  }

  void _spawnBullet(PlayerModel player) {
    final bullet = _bulletsSpawner.spawnFor(player);
    _gameState.addBullet(bullet);
  }

  void spawnBomb(TilePosition tilePosition, bool spawnedByHero) {
    final bomb = BombModel(
      tilePosition: tilePosition,
      timeToExplodeMs: GameProps.bombTimeToExplodeMs,
      timeLeftExplodingMs: GameProps.bombTimeExplodingMs,
      spawnedByHero: spawnedByHero,
    );
    _gameState.addBomb(bomb);
  }
}
