import 'package:batufo/dart_types/dart_types.dart';
import 'package:batufo/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/engine/physics.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/types.dart';

class BulletsController {
  final TilePositionPredicate colliderAt;
  final List<BulletModel> _bullets;
  final double tileSize;
  BulletsController(
    this._bullets, {
    @required this.colliderAt,
    @required this.tileSize,
  });

  void add(BulletModel model) {
    _bullets.add(model);
  }

  void update(double dt) {
    final collidedInPreviousFrame = <BulletModel>[];
    for (final bullet in _bullets) {
      final previousPosition = bullet.tilePosition;
      bullet.tilePosition =
          Physics.move(bullet.tilePosition, bullet.velocity, dt);

      if (bullet.collided) {
        collidedInPreviousFrame.add(bullet);
      } else if (colliderAt(bullet.tilePosition)) {
        _handleCollision(bullet, previousPosition);
      }
    }

    for (final bullet in collidedInPreviousFrame) {
      _bullets.remove(bullet);
    }
  }

  void _handleCollision(BulletModel bullet, TilePosition previousPosition) {
    bullet
      ..collided = true
      ..velocity = Offset.zero;
    if (previousPosition.row < bullet.tilePosition.row) {
      bullet.tilePosition = bullet.tilePosition.copyWith(relY: 0.0);
    } else if (previousPosition.row > bullet.tilePosition.row) {
      bullet.tilePosition = bullet.tilePosition.copyWith(relY: tileSize);
    } else if (previousPosition.col < bullet.tilePosition.col) {
      bullet.tilePosition = bullet.tilePosition.copyWith(relX: 0.0);
    } else if (previousPosition.col > bullet.tilePosition.col) {
      bullet.tilePosition = bullet.tilePosition.copyWith(relX: tileSize);
    }
  }
}
