import 'dart:math';
import 'dart:ui';

import 'package:batufo/engine/geometry.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/radar_model.dart';
import 'package:flutter/foundation.dart';

const _pipi = 2 * pi;
const _framesPerSec = 20;
const _frameRateMs = 1000 / _framesPerSec;

class RadarController {
  final RadarModel radar;
  double _msSinceLastChange = 0.0;
  RadarController({@required this.radar});

  void update(
    double dt,
    PlayerModel hero,
    Iterable<Offset> buildingPositions,
    Iterable<Offset> enemyPositions,
  ) {
    _msSinceLastChange += dt;
    if (_msSinceLastChange < _frameRateMs) return;
    radar.startAngle -= (_msSinceLastChange / 60) / _pipi;
    if (radar.startAngle <= 0) radar.startAngle = _pipi;
    radar.origin = hero.tilePosition.toWorldOffset();
    final triangle = Triangle.fromOriginAndVectors(
      radar.origin.dx,
      radar.origin.dy,
      radar.startAngle,
      radar.radarLength,
      radar.endAngle,
      radar.radarLength,
    );
    // TODO(radar): reliability could be improved if we consider tiles instead
    // of world positions, i.e. which tiles are even just partially included
    // in the triangle
    final covered = radar.coveredCircle;

    _updateVisibles(
      triangle,
      covered,
      buildingPositions,
      radar.buildings,
    );
    _updateVisibles(
      triangle,
      covered,
      enemyPositions,
      radar.enemies,
    );
    _msSinceLastChange = 0.0;
  }

  void _updateVisibles(
    Triangle triangle,
    Circle covered,
    Iterable<Offset> src,
    List<Offset> tgt,
  ) {
    final visible = src
        .where((x) =>
            covered.contains(x.dx, x.dy) && triangle.contains(x.dx, x.dy))
        .toList();
    tgt
      ..removeWhere(
          (x) => !covered.contains(x.dx, x.dy) || triangle.contains(x.dx, x.dy))
      ..addAll(visible);
  }
}
