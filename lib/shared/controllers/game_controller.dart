import 'package:batufo/shared/controllers/bullets_controller.dart';
import 'package:batufo/shared/controllers/helpers/colliders.dart';
import 'package:batufo/shared/controllers/player_controller.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/models/game_model.dart';
import 'package:batufo/shared/types.dart';

class GameController {
  List<PlayerController> _playerControllers;
  BulletsController _bulletsController;
  final double _bulletForce;
  final GameModel _game;

  GameController(this._game) : _bulletForce = GameProps.bulletForce {
    final colliders = Colliders(_game.nrows, _game.ncols, walls: _game.walls);

    _playerControllers = _game.players.keys
        .map(
            (clientID) => _initPlayerController(clientID, colliders.colliderAt))
        .toList();

    _bulletsController = BulletsController(
      _game.bullets,
      colliderAt: colliders.colliderAt,
      tileSize: GameProps.tileSize,
    );
  }

  void update(double dt, double ts) {
    _playerControllers.forEach(
      (x) => x.update(dt, _game.players),
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
