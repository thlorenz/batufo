import 'dart:math';
import 'dart:ui' show Canvas, Offset;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/inputs/keyboard.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

const twopi = 2 * pi;

class Player {
  Sprite playerSprite;
  final double keyboardRotationFactor;
  Player(
    String imagePath, {
    @required this.keyboardRotationFactor,
    double tileSize,
  }) {
    playerSprite = Sprite(imagePath, width: tileSize, height: tileSize);
  }

  PlayerModel update(
    double dt,
    Set<GameKey> keys,
    PlayerModel model,
  ) {
    if (keys.contains(GameKey.Left)) {
      model.angle = _increasAngle(model.angle, dt * keyboardRotationFactor);
    }
    if (keys.contains(GameKey.Right)) {
      model.angle = _increasAngle(model.angle, -dt * keyboardRotationFactor);
    }
    return model;
  }

  double _increasAngle(double angle, double delta) {
    final res = angle + delta;
    return res > twopi ? res - twopi : res;
  }

  void render(Canvas canvas, PlayerModel player) {
    final playerTilePosition = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    canvas.save();
    canvas.translate(center.x, center.y);
    canvas.rotate(player.angle);
    playerSprite.render(canvas, Offset.zero);
    canvas.restore();
  }
}
