import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/engine/physics.dart';
import 'package:batufo/shared/models/bullet_model.dart';
import 'package:batufo/shared/models/player_model.dart';

class BulletsSpawner {
  final double bulletForce;
  final double playerSize;
  BulletsSpawner({
    @required this.bulletForce,
    @required this.playerSize,
  });

  BulletModel spawnFor(PlayerModel player) {
    return BulletModel(
      tilePosition: Physics.scaleAlongAngle(
        player.tilePosition,
        player.angle,
        playerSize * 0.85,
      ),
      velocity: Physics.increaseVelocity(
        player.velocity,
        player.angle,
        bulletForce,
      ),
    );
  }
}
