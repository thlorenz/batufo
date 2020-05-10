import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/controllers/bullets_controller.dart';
import 'package:batufo/shared/controllers/helpers/bullets_spawner.dart';
import 'package:batufo/shared/controllers/helpers/colliders.dart';
import 'package:batufo/shared/controllers/player_controller.dart';
import 'package:batufo/shared/engine/world_position.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/models/game_state.dart';
import 'package:batufo/shared/models/player_model.dart';

class GameController {
  final BulletsSpawner _bulletsSpawner;
  PlayerController _playerController;
  BulletsController _bulletsController;
  final GameState _gameState;

  final Arena _arena;

  GameController(this._arena, this._gameState)
      : _bulletsSpawner = BulletsSpawner(
          bulletForce: GameProps.bulletForce,
          playerSize: GameProps.playerSize,
        ) {
    WorldPosition.tileSize = GameProps.tileSize;

    final colliders = Colliders(
      _arena.nrows,
      _arena.ncols,
      walls: _arena.walls,
      playerRadius: GameProps.playerSize,
      bulletHitsPlayerHealthToll: GameProps.bulletHitsPlayerHealthToll,
    );

    _playerController = PlayerController(
      hitSize: GameProps.playerSize,
      wallHitSlowdown: GameProps.playerHitsWallSlowdown,
      wallHitHealthTollFactor: GameProps.playerHitsWallHealthFactor,
      playerCollidingAt: colliders.playerCollidingAt,
      thrustForce: GameProps.playerThrustForce,
    );

    _bulletsController = BulletsController(
      _gameState.bullets,
      bulletCollidingAt: colliders.bulletCollidingAt,
      tileSize: GameProps.tileSize,
    );
  }

  GameState get gameState => _gameState;

  GameState update(double dt, double ts) {
    for (final x in _gameState.players.entries) {
      final player = x.value;
      _playerController.update(dt, player);

      if (player.shotBullet) _spawnBullet(player);
    }
    _bulletsController.update(dt, _gameState.players.values);

    return _gameState;
  }

  void cleanup() {
    for (final x in _gameState.players.entries) {
      _playerController.cleanup(x.value);
    }
  }

  void addPlayer(PlayerModel player) {
    assert(player != null, 'cannot add null as player');
    _gameState.addPlayer(player.id, player);
  }

  void _spawnBullet(PlayerModel player) {
    final bullet = _bulletsSpawner.spawnFor(player);
    _gameState.addBullet(bullet);
  }
}
