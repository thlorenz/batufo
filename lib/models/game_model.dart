import 'package:batufo/dart_types/dart_types.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/stats_model.dart';

class GameModel {
  Map<int, PlayerModel> players;
  StatsModel stats;
  List<BulletModel> bullets;
  List<TilePosition> floorTiles;
  List<TilePosition> walls;
  int nrows;
  int ncols;
  GameModel({
    @required this.floorTiles,
    @required this.walls,
    @required this.stats,
    @required this.bullets,
    @required this.nrows,
    @required this.ncols,
  });

  void updatePlayers(Map<int, PlayerModel> players) {
    this.players = players;
  }

  String toString() {
    return '''GameModel {
    player: $players
    bullets: $bullets
    stats: $stats
    nrows: $nrows
    ncols: $ncols
    }''';
  }
}
