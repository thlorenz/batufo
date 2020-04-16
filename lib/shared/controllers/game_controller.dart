import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/controllers/bullets_controller.dart';
import 'package:batufo/shared/controllers/helpers/colliders.dart';
import 'package:batufo/shared/controllers/player_controller.dart';
import 'package:batufo/shared/engine/world_position.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/messaging/player_inputs.dart';
import 'package:batufo/shared/models/game_state.dart';
import 'package:batufo/shared/models/player_model.dart';

class GameController {
  PlayerController _playerController;
  BulletsController _bulletsController;
  final double _bulletForce;
  final GameState _gameState;

  final Arena _arena;

  GameController(this._arena, this._gameState)
      : _bulletForce = GameProps.bulletForce {
    WorldPosition.tileSize = GameProps.tileSize;

    final colliders = Colliders(
      _arena.nrows,
      _arena.ncols,
      walls: _arena.walls,
    );

    _playerController = PlayerController(
      hitSize: GameProps.playerSize,
      wallHitSlowdown: GameProps.playerHitsWallSlowdown,
      wallHitHealthTollFactor: GameProps.playerHitsWallHealthFactor,
      colliderAt: colliders.colliderAt,
    );

    _bulletsController = BulletsController(
      _gameState.bullets,
      colliderAt: colliders.colliderAt,
      tileSize: GameProps.tileSize,
    );
  }

  GameState get gameState => _gameState;

  GameState update(double dt, double ts) {
    for (final x in _gameState.players.entries) {
      _playerController.update(dt, x.value);
    }
    // _bulletsController.update(dt);

    /*
    // firing bullets
    if (pressedKeys.contains(GameKey.Fire)) {
      final p = _game.players;
      final bullet = BulletModel(
        velocity: Physics.increaseVelocity(
          p.velocity,
          p.angle,
          _bulletForce,
        ),
        tilePosition: Physics.scaleAlongAngle(
          _game.players.tilePosition,
          p.angle,
          GameProps.playerSize * 0.85,
        ),
      );
      _bulletsController.add(bullet);

    }
     */
    return _gameState;
  }

  void addPlayer(PlayerModel player) {
    assert(player != null, 'cannot add null as player');
    _gameState.addPlayer(player.id, player);
  }

  void syncPlayerInputs(int clientID, PlayerInputs inputs) {
    assert(
      _gameState.players.containsKey(clientID),
      'player with id $clientID not found',
    );
    _gameState.players[clientID].angle = inputs.angle;
  }
}
