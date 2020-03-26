import 'dart:ui' show Canvas, Paint;

import 'package:batufo/engine/physics.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:flutter/material.dart';

final _bulletPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.black45;

class Bullets {
  final Paint paint;
  final double radius;
  final List<BulletModel> _bullets;

  Bullets(this._bullets, {this.radius = 3.0, Paint paint})
      : this.paint = paint ?? _bulletPaint;

  void add(BulletModel model) {
    _bullets.add(model);
  }

  void update(double dt) {
    for (final bullet in _bullets) {
      bullet.tilePosition =
          Physics.move(bullet.tilePosition, bullet.velocity, dt);
    }
  }

  void render(Canvas canvas) {
    for (final bullet in _bullets) {
      _renderBullet(canvas, bullet);
    }
  }

  void _renderBullet(Canvas canvas, BulletModel bullet) {
    final center = bullet.tilePosition.toWorldPosition().toOffset();
    canvas.drawCircle(center, radius, paint);
  }
}
