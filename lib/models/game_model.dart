import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/stats_model.dart';
import 'package:flutter/foundation.dart';

class GameModel {
  PlayerModel player;
  StatsModel stats;
  List<TilePosition> floorTiles;
  List<TilePosition> walls;
  List<BulletModel> bullets;
  int nrows;
  int ncols;
  GameModel({
    @required this.player,
    @required this.floorTiles,
    @required this.walls,
    @required this.stats,
    @required this.bullets,
    @required this.nrows,
    @required this.ncols,
  });

  String toString() {
    return '''GameModel {
    player: $player
    bullets: $bullets
    stats: $stats
    nrows: $nrows
    ncols: $ncols
    }''';
  }
}
