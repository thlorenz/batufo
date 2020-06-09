import 'dart:math';
import 'dart:ui' show Offset;

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

  const PlayerController({
    @required this.soundController,
    @required this.hitSize,
    @required this.playerCollidingAt,
    @required this.wallHitSlowdown,
    @required this.wallHitHealthTollFactor,
    @required this.thrustForce,
  });

  void update(
    double dt,
    PlayerModel player,
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

    final check = _checkWallCollision(player, dt);
    double healthToll = 0;
    if (check.second > 0) {
      soundController.playerHitWallWithForce(check.second);
      healthToll = check.second * wallHitHealthTollFactor;
    }
    player
      ..velocity = _normalizeVelocity(check.first)
      ..tilePosition = Physics.move(player.tilePosition, player.velocity, dt)
      ..health = max(player.health - healthToll, 0.0);
    soundController.setPlayerPosition(player.tilePosition);
  }

  void cleanup(PlayerModel player) {
    player
      ..appliedThrust = false
      ..shotBullet = false;
  }

  Offset _normalizeVelocity(Offset velocity) {
    final dx = roundPrecisionTwo(velocity.dx);
    final dy = roundPrecisionTwo(velocity.dy);
    return Offset(dx, dy);
  }

  Tuple<Offset, double> _checkWallCollision(
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

    Tuple<Offset, double> hitOnAxisX() {
      final hitForce = playerModel.velocity.dx.abs();
      return Tuple(
        playerModel.velocity.scale(-wallHitSlowdown, wallHitSlowdown),
        hitForce,
      );
    }

    Tuple<Offset, double> hitOnAxisY() {
      final hitForce = playerModel.velocity.dy.abs();
      return Tuple(
        playerModel.velocity.scale(wallHitSlowdown, -wallHitSlowdown),
        hitForce,
      );
    }

    Tuple<Offset, double> handleHit(TilePosition tp, TilePosition nextTp) {
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

    return Tuple(playerModel.velocity, 0.0);
  }
}
