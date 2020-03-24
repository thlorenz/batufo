import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class GameModel {
  PlayerModel player;
  List<TilePosition> floorTiles;
  List<TilePosition> walls;
  int nrows;
  int ncols;
  GameModel({
    @required this.player,
    @required this.floorTiles,
    @required this.walls,
    @required this.nrows,
    @required this.ncols,
  });

  String toString() {
    return '''GameModel {
    player: $player
    nrows: $nrows
    ncols: $ncols
    }''';
  }
}
