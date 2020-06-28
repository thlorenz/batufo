import 'dart:ui';

import 'package:flutter/foundation.dart';

class Circle {
  final double cx;
  final double cy;
  final double radius;

  Circle(this.cx, this.cy, this.radius);

  bool contains(double x, double y) {
    final dx = x - cx;
    final dy = y - cy;
    return dx * dx + dy * dy <= radius * radius;
  }
}

class CircleSlice {
  final double radius;
  final double startAngle;
  final double endAngle;
  final double radiusSquared;
  final Offset center;

  CircleSlice({
    @required this.center,
    @required this.radius,
    @required this.startAngle,
    @required this.endAngle,
  }) : radiusSquared = radius * radius;

  bool contains(Offset point) {
    final zeroBased = point - center;
    if (zeroBased.distanceSquared > radiusSquared) return false;
    final direction = zeroBased.direction;
    if (direction < startAngle) return false;
    if (direction > endAngle) return false;
    return true;
  }
}
