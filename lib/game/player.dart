import 'dart:math';
import 'dart:ui' show Canvas, Offset;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/inputs/keyboard.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

const twopi = 2 * pi;

class Player {
  Sprite playerSprite;
  final double keyboardRotationFactor;
  final double keyboardThrustForce;
  Player(
    String imagePath, {
    @required this.keyboardRotationFactor,
    @required this.keyboardThrustForce,
    double tileSize,
  }) {
    playerSprite = Sprite(imagePath, width: tileSize, height: tileSize);
  }

  PlayerModel update(
    double dt,
    Set<GameKey> keys,
    PlayerModel model,
  ) {
    model.tilePosition = _move(model.tilePosition, model.velocity);

    if (keys.contains(GameKey.Left)) {
      model.angle = _increasAngle(model.angle, dt * keyboardRotationFactor);
    }
    if (keys.contains(GameKey.Right)) {
      model.angle = _increasAngle(model.angle, -dt * keyboardRotationFactor);
    }
    if (keys.contains(GameKey.Up)) {
      model.velocity = _increaseVelocity(model.velocity, model.angle);
    }
    return model;
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

  double _increasAngle(double angle, double delta) {
    final res = angle + delta;
    return res > twopi ? res - twopi : res;
  }

  Offset _increaseVelocity(Offset velocity, double angle) {
    debugPrint('increasing $velocity');
    final xa = cos(angle);
    final ya = sin(angle);
    return velocity.translate(
        xa * keyboardThrustForce, ya * keyboardThrustForce);
  }

  TilePosition _move(TilePosition tilePosition, Offset velocity) {
    if (velocity == Offset.zero) return tilePosition;
    final wp = tilePosition.toWorldPosition();
    final newWp = WorldPosition(wp.x + velocity.dx, wp.y + velocity.dy);
    return newWp.toTilePosition();
  }
}
