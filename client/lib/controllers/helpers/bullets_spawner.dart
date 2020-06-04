import 'package:batufo/engine/physics.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class BulletsSpawner {
  final double bulletForce;
  final double playerSize;
  BulletsSpawner({
    @required this.bulletForce,
    @required this.playerSize,
  });

  BulletModel spawnFor(PlayerModel player) {
    return BulletModel(
      clientID: player.id,
      tilePosition: Physics.scaleAlongAngle(
        player.tilePosition,
        player.angle,
        playerSize * 0.6,
      ),
      velocity: Physics.increaseVelocity(
        player.velocity,
        player.angle,
        bulletForce,
      ),
    );
  }
}
