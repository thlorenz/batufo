import 'package:batufo/engine/physics.dart';
import 'package:batufo/game/controllers/bullets_controller.dart';
import 'package:batufo/game/controllers/player_controller.dart';
import 'package:batufo/game/helpers/colliders.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/inputs/input_types.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/game_model.dart';

class GameController {
  PlayerController _playerController;
  BulletsController _bulletsController;
  final double _bulletForce;
  final GameModel _game;

  GameController(this._game) : _bulletForce = GameProps.bulletForce {
    final colliders = Colliders(_game.nrows, _game.ncols, walls: _game.walls);
    _playerController = PlayerController(
      hitSize: GameProps.playerSize,
      keyboardRotationFactor: GameProps.keyboardPlayerRotationFactor,
      keyboardThrustForce: GameProps.keyboardPlayerThrustForce,
      wallHitSlowdown: GameProps.playerHitsWallSlowdown,
      wallHitHealthTollFactor: GameProps.playerHitsWallHealthFactor,
      colliderAt: colliders.colliderAt,
    );
    _bulletsController = BulletsController(
      _game.bullets,
      colliderAt: colliders.colliderAt,
      tileSize: GameProps.tileSize,
    );
  }

  void update(
    double dt,
    double ts,
    GameKeys pressedKeys,
    AggregatedGestures gestures,
  ) {
    _playerController.update(
      dt,
      pressedKeys,
      gestures,
      _game.player,
      _game.stats,
    );
    _bulletsController.update(dt);

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
      _bulletsController.add(bullet);
    }
  }
}
