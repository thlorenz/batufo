import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:flutter/foundation.dart';

class BombModel {
  // Transmitted Properties
  final TilePosition tilePosition;

  // Local Properties
  final Offset worldOffset;
  final bool spawnedByHero;
  double timeToExplodeMs;
  double timeLeftExplodingMs;
  bool explosionHandled;

  BombModel({
    @required this.tilePosition,
    @required this.timeToExplodeMs,
    @required this.spawnedByHero,
    this.timeLeftExplodingMs = 0.0,
  })  : worldOffset = tilePosition.toWorldOffset(),
        explosionHandled = false;

  bool get isExploding => timeToExplodeMs <= 0.0 && timeLeftExplodingMs >= 0.0;
  bool get hasExploded => timeToExplodeMs <= 0.0 && timeLeftExplodingMs <= 0.0;

  String toString() {
    return 'BombModel [ $tilePosition, $isExploding, $hasExploded ]';
  }
}
