import 'dart:math';

import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/input_types.dart';
import 'package:batufo/shared/models/player_model.dart';

const twopi = 2 * pi;

class InputProcessor {
  final double keyboardThrustForce;
  final double keyboardRotationFactor;

  InputProcessor({
    @required this.keyboardThrustForce,
    @required this.keyboardRotationFactor,
  });

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
    // thrust
    if (keys.contains(GameKey.Up)) {
      player.appliedThrustForce = keyboardThrustForce * dt;
    }

    if (gestures.thrust != 0.0) {
      player.appliedThrustForce = gestures.thrust;
    }
  }

  double _increaseAngle(double angle, double delta) {
    final res = angle + delta;
    return res > twopi ? res - twopi : res;
  }
}
