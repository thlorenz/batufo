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
    if (radar.startAngle <= -pi) radar.startAngle += _pipi;
    if (radar.startAngle >= pi) radar.startAngle -= _pipi;
    radar.origin = hero.tilePosition.toWorldOffset();

    final slice = CircleSlice(
        center: radar.origin,
        radius: radar.radarLength,
        startAngle: radar.startAngle,
        endAngle: radar.endAngle);

    _updateVisibles(
      slice,
      buildingPositions,
      radar.buildings,
    );
    _updateVisibles(
      slice,
      enemyPositions,
      radar.enemies,
    );
    _msSinceLastChange = 0.0;
  }

  void _updateVisibles(
    CircleSlice slice,
    Iterable<Offset> src,
    List<Offset> tgt,
  ) {
    final visible = src.where((x) => slice.contains(x)).toList();
    tgt
      ..removeWhere(
          (x) => !radar.coveredCircle.contains(x.dx, x.dy) || slice.contains(x))
      ..addAll(visible);
  }
}
