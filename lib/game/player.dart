import 'dart:math';
import 'dart:ui' show Canvas, Offset, Paint;

import 'package:batufo/engine/hit_tiles.dart';
import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/inputs/gestures.dart';
import 'package:batufo/inputs/keyboard.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/sprites/thrust_sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const twopi = 2 * pi;

typedef TilePositionPredicate = bool Function(TilePosition);

Paint _debugHitTilePaint = Paint()
  ..color = Colors.amberAccent
  ..strokeWidth = 0.5
  ..style = PaintingStyle.stroke;

class Player {
  Sprite playerSprite;
  ThrustSprite thrustSprite;
  final double keyboardRotationFactor;
  final double keyboardThrustForce;
  final double tileSize;
  final double hitSize;
  final double wallHitSlowdown;
  final TilePositionPredicate colliderAt;

  Player({
    String playerImagePath,
    @required this.keyboardRotationFactor,
    @required this.keyboardThrustForce,
    @required this.tileSize,
    @required this.hitSize,
    @required this.wallHitSlowdown,
    @required double thrustAnimationDurationMs,
    @required this.colliderAt,
  }) {
    playerSprite = Sprite(playerImagePath);
    thrustSprite = ThrustSprite(
      width: tileSize / 2,
      height: tileSize / 2,
      animationDurationMs: thrustAnimationDurationMs,
    );
  }

  PlayerModel update(
    double dt,
    Set<GameKey> keys,
    AggregatedGestures gestures,
    PlayerModel model,
  ) {
    model.appliedThrust = false;
    model.velocity = _checkWallCollision(model);
    model.tilePosition = _move(model.tilePosition, model.velocity);

    // rotation
    if (keys.contains(GameKey.Left)) {
      model.angle = _increasAngle(model.angle, dt * keyboardRotationFactor);
    }
    if (keys.contains(GameKey.Right)) {
      model.angle = _increasAngle(model.angle, -dt * keyboardRotationFactor);
    }
    if (gestures.rotation != 0.0) {
      model.angle = _increasAngle(model.angle, gestures.rotation);
    }
    // thrust
    if (keys.contains(GameKey.Up)) {
      model.velocity = _increaseVelocity(
        model.velocity,
        model.angle,
        keyboardThrustForce * dt,
      );
      model.appliedThrust = true;
    }
    if (gestures.thrust != 0.0) {
      model.velocity = _increaseVelocity(
        model.velocity,
        model.angle,
        gestures.thrust,
      );
      model.appliedThrust = true;
    }
    if (model.appliedThrust) thrustSprite.reset();
    thrustSprite.update(dt);

    return model;
  }

  void render(Canvas canvas, PlayerModel player) {
    final playerTilePosition = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    canvas.save();
    canvas.translate(center.x, center.y);
    canvas.rotate(player.angle);
    playerSprite.render(canvas, Offset.zero, width: tileSize, height: tileSize);
    thrustSprite.render(canvas, Offset.zero, tileSize);
    _renderDebugHitTile(canvas, player);
    canvas.restore();
  }

  void _renderDebugHitTile(Canvas canvas, PlayerModel player) {
    if (!GameProps.debugPlayerHitTile) return;
    final radius = hitSize / 2;
    final rect = Rect.fromLTWH(-radius, -radius, hitSize, hitSize);
    canvas.drawRect(rect, _debugHitTilePaint);
  }

  double _increasAngle(double angle, double delta) {
    final res = angle + delta;
    return res > twopi ? res - twopi : res;
  }

  Offset _increaseVelocity(
    Offset velocity,
    double angle,
    double thrustForce,
  ) {
    final xa = cos(angle);
    final ya = sin(angle);
    return velocity.translate(xa * thrustForce, ya * thrustForce);
  }

  TilePosition _move(TilePosition tilePosition, Offset velocity) {
    if (velocity == Offset.zero) return tilePosition;
    final wp = tilePosition.toWorldPosition();
    final newWp = WorldPosition(wp.x + velocity.dx, wp.y + velocity.dy);
    return newWp.toTilePosition();
  }

  Offset _checkWallCollision(PlayerModel playerModel) {
    final next = _move(playerModel.tilePosition, playerModel.velocity);
    final hit =
        getHitTiles(playerModel.tilePosition.toWorldPosition(), hitSize);
    final nextHit = getHitTiles(next.toWorldPosition(), hitSize);

    final hitOnAxisX = () {
      return playerModel.velocity.scale(-wallHitSlowdown, wallHitSlowdown);
    };
    final hitOnAxisY = () {
      return playerModel.velocity.scale(wallHitSlowdown, -wallHitSlowdown);
    };
    final handleHit = (TilePosition tp, TilePosition nextTp) {
      return tp.col == nextTp.col ? hitOnAxisY() : hitOnAxisX();
    };

    if (colliderAt(nextHit.bottomRight)) {
      if (colliderAt(nextHit.bottomLeft)) return hitOnAxisY();
      if (colliderAt(nextHit.topRight)) return hitOnAxisX();
      return handleHit(hit.bottomRight, nextHit.bottomRight);
    }
    if (colliderAt(nextHit.topRight)) {
      if (colliderAt(nextHit.topLeft)) return hitOnAxisY();
      return handleHit(hit.topRight, nextHit.topRight);
    }
    if (colliderAt(nextHit.bottomLeft)) {
      if (colliderAt(nextHit.topLeft)) return hitOnAxisX();
      return handleHit(hit.bottomLeft, nextHit.bottomLeft);
    }

    if (colliderAt(nextHit.topLeft)) {
      return handleHit(hit.topLeft, nextHit.topLeft);
    }

    return playerModel.velocity;
  }
}
