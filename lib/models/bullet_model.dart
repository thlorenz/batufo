import 'dart:ui' show Offset;

import 'package:batufo/dart_types.dart';
import 'package:batufo/engine/tile_position.dart';

class BulletModel {
  TilePosition tilePosition;
  Offset velocity;
  bool collided;

  BulletModel({
    @required this.tilePosition,
    @required this.velocity,
    this.collided = false,
  });

  String toString() {
    return '''PlayerModel {
     tilePosition: $tilePosition
     velocity: $velocity
   }''';
  }
}
