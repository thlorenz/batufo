import 'dart:math';
import 'dart:ui' show Offset;

import 'package:batufo/controllers/helpers/collision_result.dart';
import 'package:batufo/controllers/helpers/math_utils.dart';
import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/engine/hit_tiles.dart';
import 'package:batufo/engine/physics.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/types.dart';
import 'package:flutter/foundation.dart';

@immutable
class PlayerController {
  final SoundController soundController;
  final TilePositionPredicate playerCollidingAt;
  final double wallHitSlowdown;
  final double wallHitHealthTollFactor;
  final double hitSize;
  final double thrustForce;
  final bool Function(TilePosition tp) isValidPosition;

  const PlayerController({
    @required this.soundController,
    @required this.hitSize,
    @required this.playerCollidingAt,
    @required this.wallHitSlowdown,
    @required this.wallHitHealthTollFactor,
    @required this.thrustForce,
    @required this.isValidPosition,
  });

  void update(
    double dt,
    PlayerModel player,
    bool isHero,
  ) {
    if (PlayerStatus.isDead(player)) return;

    if (player.appliedThrust) {
      final velocity = Physics.increaseVelocity(
        player.velocity,
        player.angle,
        thrustForce,
      );
      player.velocity = _normalizeVelocity(velocity);
      soundController.playerAppliedThrust();
    }

    final result = _checkWallCollision(player, dt);
    double healthToll = 0;
    if (result.collided) {
      soundController.playerHitWallWithForce(player.tilePosition, result.force);
      healthToll = result.force * wallHitHealthTollFactor;
    }
    final nextVelocity = _normalizeVelocity(result.velocity);
    final nextPosition = Physics.move(player.tilePosition, nextVelocity, dt);

    _updateVelocityAndPositionEnsuringValidPosition(
      nextPosition,
      nextVelocity,
      player,
    );

    player
      ..health = max(player.health - healthToll, 0.0)
      ..shieldRemainingMs = max(player.shieldRemainingMs - dt, 0.0);

    if (isHero) {
      soundController.setPlayerPosition(player.tilePosition);
    }
  }

  void _updateVelocityAndPositionEnsuringValidPosition(
    TilePosition nextPosition,
    Offset velocity,
    PlayerModel player,
  ) {
    if (isValidPosition(nextPosition)) {
      player
        ..tilePosition = nextPosition
        ..velocity = velocity;
    } else {
      player.velocity = velocity.scale(-0.5, -0.5);
    }
  }

  void cleanup(PlayerModel player) {
    player
      ..appliedThrust = false
      ..shotBullet = false
      ..spawnedBomb = false;
  }

  Offset _normalizeVelocity(Offset velocity) {
    final dx = roundPrecisionTwo(velocity.dx);
    final dy = roundPrecisionTwo(velocity.dy);
    return Offset(dx, dy);
  }

  CollisionResult _checkWallCollision(
    PlayerModel playerModel,
    double dt,
  ) {
    final next = Physics.move(
      playerModel.tilePosition,
      playerModel.velocity,
      dt,
    );
    final hit =
        getHitTiles(playerModel.tilePosition.toWorldPosition(), hitSize);
    final nextHit = getHitTiles(next.toWorldPosition(), hitSize);

    CollisionResult hitOnAxisX() {
      final hitForce = playerModel.velocity.dx.abs();
      return CollisionResult(
        true,
        playerModel.velocity.scale(-wallHitSlowdown, wallHitSlowdown),
        hitForce,
      );
    }

    CollisionResult hitOnAxisY() {
      final hitForce = playerModel.velocity.dy.abs();
      return CollisionResult(
        true,
        playerModel.velocity.scale(wallHitSlowdown, -wallHitSlowdown),
        hitForce,
      );
    }

    CollisionResult handleHit(TilePosition tp, TilePosition nextTp) {
      return tp.col == nextTp.col ? hitOnAxisY() : hitOnAxisX();
    }

    if (playerCollidingAt(nextHit.bottomRight)) {
      if (playerCollidingAt(nextHit.bottomLeft)) return hitOnAxisY();
      if (playerCollidingAt(nextHit.topRight)) return hitOnAxisX();
      return handleHit(hit.bottomRight, nextHit.bottomRight);
    }
    if (playerCollidingAt(nextHit.topRight)) {
      if (playerCollidingAt(nextHit.topLeft)) return hitOnAxisY();
      return handleHit(hit.topRight, nextHit.topRight);
    }
    if (playerCollidingAt(nextHit.bottomLeft)) {
      if (playerCollidingAt(nextHit.topLeft)) return hitOnAxisX();
      return handleHit(hit.bottomLeft, nextHit.bottomLeft);
    }

    if (playerCollidingAt(nextHit.topLeft)) {
      return handleHit(hit.topLeft, nextHit.topLeft);
    }

    return CollisionResult(false, playerModel.velocity, 0.0);
  }
}
