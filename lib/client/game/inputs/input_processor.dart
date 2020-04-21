import 'dart:math';

import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/input_types.dart';
import 'package:batufo/shared/models/player_model.dart';

const twopi = 2 * pi;

final _log = Log<InputProcessor>();

class InputProcessor {
  final double keyboardThrustForce;
  final double keyboardRotationFactor;
  final double timeBetweenThrusts;

  double timeSinceLastThrust;

  InputProcessor({
    @required this.keyboardThrustForce,
    @required this.keyboardRotationFactor,
    @required this.timeBetweenThrusts,
  }) {
    timeSinceLastThrust = 0.0;
  }

  bool get canApplyThrust {
    return timeBetweenThrusts <= timeSinceLastThrust;
  }

  bool get canShootBullet {
    return true;
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

    // bullets
    if (canShootBullet) {
      if (keys.contains(GameKey.Fire)) {
        player.shotBullet = true;
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
