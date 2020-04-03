import 'package:batufo/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/game_props.dart';
import 'package:batufo/grpc/server_game/arena.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/game_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/stats_model.dart';

GameModel createModel(Arena arena) {
  final players = <int, PlayerModel>{};
  for (final initialPlayer in arena.players) {
    final player = PlayerModel(
      id: initialPlayer.id,
      tilePosition: initialPlayer.tilePosition,
      velocity: Offset.zero,
      angle: 0.0,
      appliedThrust: false,
    );
    players[initialPlayer.id] = player;
  }
  final statsModel = StatsModel(playerHealth: GameProps.playerTotalHealth);
  final bullets = <BulletModel>[];
  return GameModel(
    players: players,
    floorTiles: arena.floorTiles,
    walls: arena.walls,
    nrows: arena.nrows,
    ncols: arena.ncols,
    stats: statsModel,
    bullets: bullets,
  );
}
