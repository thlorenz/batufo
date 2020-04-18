import 'package:batufo/shared/controllers/helpers/math_utils.dart';
import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/shared/engine/hit_tiles.dart';
import 'package:batufo/shared/engine/physics.dart';
import 'package:batufo/shared/engine/tile_position.dart';
import 'package:batufo/shared/models/player_model.dart';
import 'package:batufo/shared/types.dart';

final _log = Log<PlayerController>();

@immutable
class PlayerController {
  final TilePositionPredicate colliderAt;
  final double wallHitSlowdown;
  final double wallHitHealthTollFactor;
  final double hitSize;
  final double thrustForce;

  PlayerController({
    @required this.hitSize,
    @required this.colliderAt,
    @required this.wallHitSlowdown,
    @required this.wallHitHealthTollFactor,
    @required this.thrustForce,
  });

  void update(
    double dt,
    PlayerModel player,
  ) {
    if (player.appliedThrust) {
      final velocity = Physics.increaseVelocity(
        player.velocity,
        player.angle,
        thrustForce,
      );
      player.velocity = _normalizeVelocity(velocity);
    }

    final check = _checkWallCollision(player, dt);
    player
      ..appliedThrust = false
      ..velocity = _normalizeVelocity(check.first)
      ..tilePosition = Physics.move(player.tilePosition, player.velocity, dt);

    /*
    if (check.second > 0) {
      stats.playerHealth -= check.second;
    }
     */
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
