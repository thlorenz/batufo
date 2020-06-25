import 'dart:math';
import 'dart:ui' show Canvas, Offset, Paint, Rect;

import 'package:batufo/models/radar_model.dart';
import 'package:flutter/material.dart' show Colors, PaintingStyle;
import 'package:flutter/painting.dart';

final _sweepGradientColors = <Color>[
  Colors.white.withOpacity(0.8),
  Colors.white.withOpacity(0.5),
  Colors.white.withOpacity(0.3),
  Colors.white.withOpacity(0.2),
  Colors.white.withOpacity(0.1),
];

class Radar {
  final Paint _backgroundOuterPaint;
  final Paint _backgroundInnerPaint;
  final Paint _outerCirclePaint;
  final Paint _buildingPaint;
  final Paint _enemyPaint;
  final RadarModel radar;
  Radar(this.radar)
      : _backgroundOuterPaint = Paint()
          ..color = Color(0xdd01112a)
          ..style = PaintingStyle.fill,
        _backgroundInnerPaint = Paint()
          ..color = Color(0xdd00386b)
          ..style = PaintingStyle.fill,
        _outerCirclePaint = Paint()
          ..color = Color(0xff0c55b4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.3,
        _buildingPaint = Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.fill,
        _enemyPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  void render(Canvas canvas, Rect visibleRect) {
    final width = min(visibleRect.width, visibleRect.height) / 5;
    final outerRadius = width / 2;
    final innerRadius = outerRadius * 0.4;
    final center = Offset(outerRadius, outerRadius);

    canvas.drawCircle(center, outerRadius, _backgroundOuterPaint);
    canvas.drawCircle(center, innerRadius, _backgroundInnerPaint);
    canvas.drawCircle(center, outerRadius, _outerCirclePaint);
    _drawObjects(canvas, center, outerRadius);
    _drawArc(canvas, center, outerRadius, radar.startAngle, radar.deltaAngle);
  }

  void _drawObjects(
    Canvas canvas,
    Offset center,
    double outerRadius,
  ) {
    canvas.save();
    {
      canvas.translate(center.dx, center.dy);
      final scale = outerRadius / radar.radarLength;

      final translatedBuildings = radar.buildings
          .map((x) => x.translate(-radar.origin.dx, -radar.origin.dy));
      for (final pos in translatedBuildings) {
        canvas.drawCircle(
          pos.scale(scale, scale),
          0.5,
          _buildingPaint,
        );
      }

      final translatedEnemies = radar.enemies
          .map((x) => x.translate(-radar.origin.dx, -radar.origin.dy));
      for (final pos in translatedEnemies) {
        canvas.drawCircle(
          pos.scale(scale, scale),
          2,
          _enemyPaint,
        );
      }
    }
    canvas.restore();
  }

  void _drawArc(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double deltaAngle,
  ) {
    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );
    final Gradient gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: deltaAngle,
      colors: _sweepGradientColors,
      transform: GradientRotation(startAngle),
    );

    final Paint paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawArc(rect, startAngle, deltaAngle, true, paint);
  }
}
