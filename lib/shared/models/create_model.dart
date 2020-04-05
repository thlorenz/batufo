import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/models/bullet_model.dart';
import 'package:batufo/shared/models/game_model.dart';
import 'package:batufo/shared/models/stats_model.dart';

GameModel createModel(Arena arena, int clientID) {
  final statsModel = StatsModel(playerHealth: GameProps.playerTotalHealth);
  final bullets = <BulletModel>[];
  return GameModel(
    floorTiles: arena.floorTiles,
    walls: arena.walls,
    nrows: arena.nrows,
    ncols: arena.ncols,
    stats: statsModel,
    bullets: bullets,
  );
}
