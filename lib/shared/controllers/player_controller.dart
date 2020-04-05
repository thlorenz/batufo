import 'dart:math';

import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/shared/engine/hit_tiles.dart';
import 'package:batufo/shared/engine/physics.dart';
import 'package:batufo/shared/engine/tile_position.dart';
import 'package:batufo/shared/input_types.dart';
import 'package:batufo/shared/models/player_model.dart';
import 'package:batufo/shared/models/stats_model.dart';
import 'package:batufo/shared/types.dart';

const twopi = 2 * pi;

class PlayerController {
  final double keyboardRotationFactor;
  final double keyboardThrustForce;
  final TilePositionPredicate colliderAt;
  final double wallHitSlowdown;
  final double wallHitHealthTollFactor;
  final double hitSize;
  final int cliendID;

  PlayerController(
    this.cliendID, {
    @required this.keyboardRotationFactor,
    @required this.keyboardThrustForce,
    @required this.hitSize,
    @required this.colliderAt,
    @required this.wallHitSlowdown,
    @required this.wallHitHealthTollFactor,
  });

  void update(
    double dt,
    GameKeys keys,
    AggregatedGestures gestures,
    Map<int, PlayerModel> players,
    StatsModel stats,
  ) {
    final player = players[cliendID];
    final check = _checkWallCollision(player, dt);
    player
      ..appliedThrust = false
      ..velocity = check.first;

    if (check.second > 0) {
      stats.playerHealth -= check.second;
    }
    player.tilePosition =
        Physics.move(player.tilePosition, player.velocity, dt);

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
      player
        ..velocity = Physics.increaseVelocity(
          player.velocity,
          player.angle,
          keyboardThrustForce * dt,
        )
        ..appliedThrust = true;
    }
    if (gestures.thrust != 0.0) {
      player
        ..velocity = Physics.increaseVelocity(
          player.velocity,
          player.angle,
          gestures.thrust,
        )
        ..appliedThrust = true;
    }
  }

  double _increasAngle(double angle, double delta) {
    final res = angle + delta;
    return res > twopi ? res - twopi : res;
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
      final healthToll =
          playerModel.velocity.dx.abs() * wallHitHealthTollFactor;
      return Tuple(
        playerModel.velocity.scale(-wallHitSlowdown, wallHitSlowdown),
        healthToll,
      );
    }

    Tuple<Offset, double> hitOnAxisY() {
      final healthToll =
          playerModel.velocity.dy.abs() * wallHitHealthTollFactor;
      return Tuple(
        playerModel.velocity.scale(wallHitSlowdown, -wallHitSlowdown),
        healthToll,
      );
    }

    Tuple<Offset, double> handleHit(TilePosition tp, TilePosition nextTp) {
      return tp.col == nextTp.col ? hitOnAxisY() : hitOnAxisX();
    }

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
