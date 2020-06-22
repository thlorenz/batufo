import 'dart:math' show cos, sin;
import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/util/math.dart';

final RandomNumber _rnd = RandomNumber();

class Physics {
  static TilePosition move(
      TilePosition tilePosition, Offset velocity, double dt) {
    if (velocity == Offset.zero) return tilePosition;
    final wp = tilePosition.toWorldPosition();
    final newWp = WorldPosition(
      wp.x + velocity.dx * dt,
      wp.y + velocity.dy * dt,
    );
    return newWp.toTilePosition();
  }

  static TilePosition scaleAlongAngle(
    TilePosition tilePosition,
    double angle,
    double factor,
  ) {
    final xa = cos(angle) * factor;
    final ya = sin(angle) * factor;
    final wp = tilePosition.toWorldPosition();
    return WorldPosition(wp.x + xa, wp.y + ya).toTilePosition();
  }

  static Offset increaseVelocity(
    Offset velocity,
    double angle,
    double force,
  ) {
    final xa = cos(angle);
    final ya = sin(angle);
    return velocity.translate(xa * force, ya * force);
  }

  static Offset simulateExplosion(Offset camera, double explosionStrength) {
    if (explosionStrength == 0) return camera;

    final min = -explosionStrength;
    final max = explosionStrength;
    return camera.translate(
      _rnd.nextDouble(min, max),
      _rnd.nextDouble(min, max),
    );
  }
}
