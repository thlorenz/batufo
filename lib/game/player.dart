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
import 'package:batufo/models/stats_model.dart';
import 'package:batufo/sprites/thrust_sprite.dart';
import 'package:batufo/types.dart';
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
  final double wallHitHealthTollFactor;
  final TilePositionPredicate colliderAt;

  Player({
    String playerImagePath,
    @required this.keyboardRotationFactor,
    @required this.keyboardThrustForce,
    @required this.tileSize,
    @required this.hitSize,
    @required this.wallHitSlowdown,
    @required this.wallHitHealthTollFactor,
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

  void update(
    double dt,
    Set<GameKey> keys,
    AggregatedGestures gestures,
    PlayerModel player,
    StatsModel stats,
  ) {
    player.appliedThrust = false;
    final check = _checkWallCollision(player);
    player.velocity = check.first;
    if (check.second > 0) {
      stats.playerHealth -= check.second;
    }
    player.tilePosition = _move(player.tilePosition, player.velocity);

    // rotation
    if (keys.contains(GameKey.Left)) {
      player.angle = _increasAngle(player.angle, dt * keyboardRotationFactor);
    }
    if (keys.contains(GameKey.Right)) {
      player.angle = _increasAngle(player.angle, -dt * keyboardRotationFactor);
    }
    if (gestures.rotation != 0.0) {
      player.angle = _increasAngle(player.angle, gestures.rotation);
    }
    // thrust
    if (keys.contains(GameKey.Up)) {
      player.velocity = _increaseVelocity(
        player.velocity,
        player.angle,
        keyboardThrustForce * dt,
      );
      player.appliedThrust = true;
    }
    if (gestures.thrust != 0.0) {
      player.velocity = _increaseVelocity(
        player.velocity,
        player.angle,
        gestures.thrust,
      );
      player.appliedThrust = true;
    }
    if (player.appliedThrust) thrustSprite.reset();
    thrustSprite.update(dt);
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

  Tuple<Offset, double> _checkWallCollision(PlayerModel playerModel) {
    final next = _move(playerModel.tilePosition, playerModel.velocity);
    final hit =
        getHitTiles(playerModel.tilePosition.toWorldPosition(), hitSize);
    final nextHit = getHitTiles(next.toWorldPosition(), hitSize);

    final hitOnAxisX = () {
      final healthToll =
          playerModel.velocity.dx.abs() * wallHitHealthTollFactor;
      return Tuple(
        playerModel.velocity.scale(-wallHitSlowdown, wallHitSlowdown),
        healthToll,
      );
    };
    final hitOnAxisY = () {
      final healthToll =
          playerModel.velocity.dy.abs() * wallHitHealthTollFactor;
      return Tuple(
        playerModel.velocity.scale(wallHitSlowdown, -wallHitSlowdown),
        healthToll,
      );
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

    return Tuple(playerModel.velocity, 0.0);
  }
}
