import 'dart:ui' show Canvas, Offset, Paint, PaintingStyle;

import 'package:batufo/game/sprites/bullet_explosion_sprite.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;

final _bulletPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.black45;

class Bullets {
  final Paint paint;
  final double radius;
  final List<BulletExplosionSprite> _explodingBullets;
  final double msToExplode;
  final double tileSize;

  Bullets({
    @required this.msToExplode,
    @required this.tileSize,
    this.radius = 3.0,
    Paint paint,
  })  : paint = paint ?? _bulletPaint,
        _explodingBullets = <BulletExplosionSprite>[];

  void updateSprites(Iterable<BulletModel> bullets, double dt) {
    for (final bullet in bullets) {
      if (bullet.collided) {
        _explodingBullets
            .add(_createBulletExplosion(bullet.tilePosition.toWorldOffset()));
      }
    }
    _explodingBullets.removeWhere((bullet) => bullet.done);
    for (final bullet in _explodingBullets) {
      bullet.update(dt);
    }
  }

  void render(Canvas canvas, Iterable<BulletModel> bullets) {
    for (final bullet in bullets) {
      _renderBullet(canvas, bullet);
    }
    for (final bullet in _explodingBullets) {
      bullet.render(canvas);
    }
  }

  void _renderBullet(Canvas canvas, BulletModel bullet) {
    final center = bullet.tilePosition.toWorldPosition().toOffset();
    canvas.drawCircle(center, radius, paint);
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
