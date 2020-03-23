import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class GameModel {
  PlayerModel player;
  List<TilePosition> floorTiles;
  GameModel({@required this.player, this.floorTiles});

  String toString() {
    return '''GameModel {
    player: $player
    }''';
  }
}
