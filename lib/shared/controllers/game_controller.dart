import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/controllers/bullets_controller.dart';
import 'package:batufo/shared/controllers/helpers/colliders.dart';
import 'package:batufo/shared/controllers/player_controller.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/models/game_state.dart';
import 'package:batufo/shared/types.dart';

class GameController {
  List<PlayerController> _playerControllers;
  BulletsController _bulletsController;
  final double _bulletForce;
  final GameState _gameState;
  final Arena _arena;

  GameController(this._arena, this._gameState)
      : _bulletForce = GameProps.bulletForce {
    final colliders = Colliders(
      _arena.nrows,
      _arena.ncols,
      walls: _arena.walls,
    );

    _playerControllers = _gameState.players.keys
        .map(
            (clientID) => _initPlayerController(clientID, colliders.colliderAt))
        .toList();

    _bulletsController = BulletsController(
      _gameState.bullets,
      colliderAt: colliders.colliderAt,
      tileSize: GameProps.tileSize,
    );
  }

  void update(double dt, double ts) {
    _playerControllers.forEach(
      (x) => x.update(dt, _gameState.players),
    );
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
  }

  PlayerController _initPlayerController(
    int clientID,
    TilePositionPredicate colliderAt,
  ) {
    return PlayerController(
      clientID,
      hitSize: GameProps.playerSize,
      wallHitSlowdown: GameProps.playerHitsWallSlowdown,
      wallHitHealthTollFactor: GameProps.playerHitsWallHealthFactor,
      colliderAt: colliderAt,
    );
  }
}
