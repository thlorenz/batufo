import 'dart:ui' show Canvas, Paint;
import 'dart:ui' as dui;

import 'package:batufo/dart_types.dart';
import 'package:batufo/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/engine/physics.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/sprites/bullet_explosion_sprite.dart';
import 'package:batufo/types.dart';
import 'package:flutter/material.dart'
    show Canvas, Colors, Paint, PaintingStyle;

final _bulletPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.black45;

class Bullets {
  final TilePositionPredicate colliderAt;
  final Paint paint;
  final double radius;
  final List<BulletModel> _bullets;
  final List<BulletExplosionSprite> _explodingBullets;
  final double msToExplode;
  final double tileSize;

  Bullets(
    this._bullets, {
    @required this.colliderAt,
    @required this.msToExplode,
    @required this.tileSize,
    this.radius = 3.0,
    Paint paint,
  })  : this.paint = paint ?? _bulletPaint,
        _explodingBullets = List<BulletExplosionSprite>();

  void add(BulletModel model) {
    _bullets.add(model);
  }

  void update(double dt) {
    final collidedInPreviousFrame = List<BulletModel>();
    for (final bullet in _bullets) {
      final previousPosition = bullet.tilePosition;
      bullet.tilePosition =
          Physics.move(bullet.tilePosition, bullet.velocity, dt);

      if (bullet.collided) {
        collidedInPreviousFrame.add(bullet);
        _explodingBullets
            .add(_createBulletExplosion(bullet.tilePosition.toWorldOffset()));
      } else if (colliderAt(bullet.tilePosition)) {
        _handleCollision(bullet, previousPosition);
      }
    }

    for (final bullet in collidedInPreviousFrame) {
      _bullets.remove(bullet);
    }

    _explodingBullets.removeWhere((bullet) => bullet.done);
    for (final bullet in _explodingBullets) {
      bullet.update(dt);
    }
  }

  void render(Canvas canvas) {
    for (final bullet in _bullets) {
      _renderBullet(canvas, bullet);
    }
    for (final bullet in _explodingBullets) {
      bullet.render(canvas);
    }
  }

  void _handleCollision(BulletModel bullet, TilePosition previousPosition) {
    bullet.collided = true;
    bullet.velocity = Offset.zero;
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

  void _renderBullet(Canvas canvas, BulletModel bullet) {
    final center = bullet.tilePosition.toWorldPosition().toOffset();
    canvas.drawCircle(center as dui.Offset, radius, paint);
  }

  BulletExplosionSprite _createBulletExplosion(Offset center) {
    final size = radius * 5;
    return BulletExplosionSprite(
      center,
      width: size,
      height: size,
      animationDurationMs: msToExplode,
    );
  }
}
