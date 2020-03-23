import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class GameModel {
  PlayerModel player;
  List<TilePosition> floorTiles;
  List<TilePosition> walls;
  GameModel({
    @required this.player,
    @required this.floorTiles,
    @required this.walls,
  });

  String toString() {
    return '''GameModel {
    player: $player
    }''';
  }
}
