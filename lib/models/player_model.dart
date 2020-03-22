import 'package:batufo/engine/tile_position.dart';
import 'package:flutter/foundation.dart';

class PlayerModel {
  final TilePosition tilePosition;
  double angle;
  PlayerModel({
    @required this.tilePosition,
    @required this.angle,
  });

  String toString() {
    return '''PlayerModel {
     tilePosition: $tilePosition
     angle: $angle
   }''';
  }
}
