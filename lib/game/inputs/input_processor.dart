import 'dart:math';

import 'package:batufo/game/inputs/input_types.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

const twopi = 2 * pi;

class InputProcessor {
  final double keyboardThrustForce;
  final double keyboardRotationFactor;
  final double timeBetweenThrusts;
  final double timeBetweenBullets;

  double timeSinceLastThrust;
  double timeSinceLastBullet;

  InputProcessor({
    @required this.keyboardThrustForce,
    @required this.keyboardRotationFactor,
    @required this.timeBetweenThrusts,
    @required this.timeBetweenBullets,
  }) {
    timeSinceLastThrust = 0.0;
    timeSinceLastBullet = 0.0;
  }

  bool get canApplyThrust {
    return timeBetweenThrusts <= timeSinceLastThrust;
  }

  bool get canShootBullet {
    return timeBetweenBullets <= timeSinceLastBullet;
  }

  void udate(
    double dt,
    GameKeys keys,
    AggregatedGestures gestures,
    PlayerModel player,
  ) {
    // rotation
    if (keys.contains(GameKey.Left)) {
      player.angle = _increaseAngle(player.angle, dt * keyboardRotationFactor);
    }
    if (keys.contains(GameKey.Right)) {
      player.angle = _increaseAngle(player.angle, -dt * keyboardRotationFactor);
    }
    if (gestures.rotation != 0.0) {
      player.angle = _increaseAngle(player.angle, gestures.rotation);
    }
    timeSinceLastThrust = min(timeBetweenThrusts, timeSinceLastThrust + dt);
    timeSinceLastBullet = min(timeBetweenBullets, timeSinceLastBullet + dt);

    // bullets
    if (canShootBullet) {
      if (keys.contains(GameKey.Fire) || gestures.fire) {
        player.shotBullet = true;
        timeSinceLastBullet = 0.0;
      }
    }

    // thrust
    if (canApplyThrust) {
      if (keys.contains(GameKey.Up)) {
        player.appliedThrust = true;
        timeSinceLastThrust = 0.0;
      }
      if (gestures.thrust != 0.0) {
        player.appliedThrust = true;
        timeSinceLastThrust = 0.0;
      }
    }
  }

  double _increaseAngle(double angle, double delta) {
    final res = angle + delta;
    return res > twopi ? res - twopi : res;
  }
}
