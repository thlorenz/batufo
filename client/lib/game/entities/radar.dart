import 'dart:math';
import 'dart:ui' show Canvas, Offset, Paint, Rect;

import 'package:batufo/models/radar_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, PaintingStyle;
import 'package:flutter/painting.dart';

const _pipi = pi * 2;

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
  final Paint _gridPaint;
  final Paint _outerCirclePaint;
  final Paint _buildingPaint;
  final Paint _nonGradientRadarPaint;
  final Paint _enemyPaint;
  final RadarModel radar;
  final bool enableGradient;
  Radar(this.radar, {@required this.enableGradient})
      : _backgroundOuterPaint = Paint()
          ..color = Color(0xdd01112a)
          ..style = PaintingStyle.fill,
        _backgroundInnerPaint = Paint()
          ..color = Color(0xdd00386b)
          ..style = PaintingStyle.fill,
        _gridPaint = Paint()
          ..color = Color(0xdd00386b)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
        _outerCirclePaint = Paint()
          ..color = Color(0xff0c55b4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
        _buildingPaint = Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.fill,
        _enemyPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
        _nonGradientRadarPaint = Paint()
          ..color = Color(0x44ffffff)
          ..style = PaintingStyle.fill;

  void render(Canvas canvas, Rect visibleRect) {
    if (visibleRect == null) return;
    final width = min(visibleRect.width, visibleRect.height) / 5;
    final outerRadius = width / 2;
    final innerRadius = outerRadius * 0.25;
    final center = Offset(outerRadius, outerRadius);

    canvas.drawCircle(center, outerRadius, _backgroundOuterPaint);
    canvas.drawCircle(center, innerRadius, _backgroundInnerPaint);
    canvas.drawCircle(center, outerRadius, _outerCirclePaint);
    _drawGrid(canvas, center, outerRadius);
    _drawObjects(canvas, center, outerRadius);
    _drawArc(canvas, center, outerRadius, radar.startAngle, radar.deltaAngle);
  }

  void _drawGrid(
    Canvas canvas,
    Offset center,
    double radius,
  ) {
    for (double angle = 0; angle < _pipi; angle += _pipi / 24) {
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawLine(center, Offset(x, y), _gridPaint);
    }
    canvas.drawCircle(center, radius * 0.5, _gridPaint);
    canvas.drawCircle(center, radius * 0.75, _gridPaint);
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
    final Paint paint = enableGradient
        ? _gradientRadarPaint(
            center,
            rect,
            radius,
            startAngle,
            deltaAngle,
          )
        : _nonGradientRadarPaint;

    canvas.drawArc(rect, startAngle, deltaAngle, true, paint);
  }

  Paint _gradientRadarPaint(
    Offset center,
    Rect rect,
    double radius,
    double startAngle,
    double deltaAngle,
  ) {
    final Gradient gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: deltaAngle,
      colors: _sweepGradientColors,
      transform: GradientRotation(startAngle),
    );
    return Paint()..shader = gradient.createShader(rect);
  }
}
