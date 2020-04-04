import 'package:batufo/game_props.dart';
import 'package:batufo/grpc/server_game/arena.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/game_model.dart';
import 'package:batufo/models/stats_model.dart';

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
