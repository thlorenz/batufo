import 'package:batufo/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/levels/tilemap.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/game_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/stats_model.dart';

GameModel createModel(Tilemap tilemap, double tileSize) {
  final nrows = tilemap.nrows;
  final ncols = tilemap.ncols;
  final center = tileSize / 2;

  PlayerModel player;
  final floorTiles = <TilePosition>[];
  final walls = <TilePosition>[];

  for (int row = 0; row < nrows; row++) {
    for (int col = 0; col < ncols; col++) {
      final tile = tilemap.tiles[row * ncols + col];
      if (!Tilemap.coversBackground(tile)) {
        floorTiles.add(TilePosition(col, row, center, center));
      }
      if (tile == Tile.Player) {
        player = PlayerModel(
          tilePosition: TilePosition(col, row, center, center),
          angle: 0,
          velocity: Offset.zero,
          appliedThrust: false,
        );
      }
      if (tile == Tile.Wall || tile == Tile.Boundary) {
        walls.add(TilePosition(col, row, center, center));
      }
    }
  }

  final statsModel = StatsModel(playerHealth: GameProps.playerTotalHealth);
  final bullets = <BulletModel>[];
  return GameModel(
    player: player,
    floorTiles: floorTiles,
    walls: walls,
    stats: statsModel,
    bullets: bullets,
    nrows: nrows,
    ncols: ncols,
  );
}
