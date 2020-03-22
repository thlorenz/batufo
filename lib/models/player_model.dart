import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:flutter/foundation.dart';

class PlayerModel {
  TilePosition tilePosition;
  Offset velocity;
  double angle;
  PlayerModel({
    @required this.tilePosition,
    @required this.angle,
    @required this.velocity,
  });

  String toString() {
    return '''PlayerModel {
     tilePosition: $tilePosition
     angle: $angle
     velocity: $velocity
   }''';
  }
}
