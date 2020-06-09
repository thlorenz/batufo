import 'dart:ui' show Offset;

import 'package:batufo/controllers/helpers/colliders.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/engine/physics.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class BulletsController {
  final SoundController soundController;
  final BulletTarget Function(Iterable<PlayerModel>, TilePosition)
      bulletCollidingAt;
  final void Function(PlayerModel player) onPlayerHitByBullet;
  final List<BulletModel> _bullets;
  final double tileSize;
  BulletsController(
    this._bullets, {
    @required this.soundController,
    @required this.bulletCollidingAt,
    @required this.onPlayerHitByBullet,
    @required this.tileSize,
  });

  void add(BulletModel model) {
    _bullets.add(model);
  }

  void update(double dt, Iterable<PlayerModel> players) {
    final collidedInPreviousFrame = <BulletModel>[];
    for (final bullet in _bullets) {
      final previousPosition = bullet.tilePosition;
      bullet.tilePosition =
          Physics.move(bullet.tilePosition, bullet.velocity, dt);

      if (bullet.collided) {
        collidedInPreviousFrame.add(bullet);
      } else {
        final target = bulletCollidingAt(players, bullet.tilePosition);
        switch (target.kind) {
          case BulletTargets.Wall:
            _handleCollision(bullet, previousPosition);
            break;
          case BulletTargets.Player:
            // We cannot be hit by our own bullets
            if (target.player.id == bullet.clientID) break;
            _handleCollision(bullet, previousPosition);
            onPlayerHitByBullet(target.player);
            break;
          case BulletTargets.None:
            break;
        }
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
    soundController.bulletExplodedAt(bullet.tilePosition);

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
