import 'dart:ui' show Canvas, Paint;

import 'package:batufo/engine/physics.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/types.dart';
import 'package:flutter/material.dart';

final _bulletPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.black45;

final _explosionPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.black45;

class Bullets {
  final TilePositionPredicate colliderAt;
  final Paint paint;
  final double radius;
  final List<BulletModel> _bullets;
  final double msToExplode;

  Bullets(
    this._bullets, {
    @required this.colliderAt,
    @required this.msToExplode,
    this.radius = 3.0,
    Paint paint,
  }) : this.paint = paint ?? _bulletPaint;

  void add(BulletModel model) {
    _bullets.add(model);
  }

  void update(double dt) {
    final exploded = List<BulletModel>();
    for (final bullet in _bullets) {
      bullet.tilePosition =
          Physics.move(bullet.tilePosition, bullet.velocity, dt);

      if (_bulletIsExploding(bullet)) {
        if (bullet.msToExplode < 0) {
          exploded.add(bullet);
        } else {
          bullet.msToExplode -= dt;
        }
      } else if (colliderAt(bullet.tilePosition)) {
        bullet.msToExplode = msToExplode;
        bullet.velocity = Offset.zero;
      }
    }

    for (final bullet in exploded) _bullets.remove(bullet);
  }

  void render(Canvas canvas) {
    for (final bullet in _bullets) {
      _renderBullet(canvas, bullet);
    }
  }

  void _renderBullet(Canvas canvas, BulletModel bullet) {
    final center = bullet.tilePosition.toWorldPosition().toOffset();
    if (bullet.msToExplode == null) {
      canvas.drawCircle(center, radius, paint);
    } else {
      _renderExplosion(canvas, center, bullet);
    }
  }

  void _renderExplosion(Canvas canvas, Offset center, BulletModel bullet) {
    canvas.drawCircle(center, bullet.msToExplode / 20, _explosionPaint);
  }

  static bool _bulletIsExploding(BulletModel bullet) =>
      bullet.msToExplode != null;
}
