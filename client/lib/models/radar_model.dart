import 'dart:ui';

import 'package:batufo/engine/geometry.dart';
import 'package:flutter/foundation.dart';

class RadarModel {
  final double deltaAngle;
  final List<Offset> buildings;
  final List<Offset> enemies;
  final double radarLength;
  Offset origin;
  RadarModel({
    @required this.deltaAngle,
    @required this.radarLength,
  })  : startAngle = 0.0,
        buildings = <Offset>[],
        enemies = <Offset>[],
        origin = Offset.zero;

  double startAngle;
  double get endAngle => startAngle + deltaAngle;
  Circle get coveredCircle => Circle(origin.dx, origin.dy, radarLength);
}
