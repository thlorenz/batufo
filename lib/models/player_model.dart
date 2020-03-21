import 'package:batufo/engine/tile_position.dart';
import 'package:flutter/foundation.dart';

class PlayerModel {
  final TilePosition tilePosition;
  PlayerModel({@required this.tilePosition});

  String toString() {
    return '''PlayerModel {
     tilePosition: $tilePosition
   }''';
  }
}
