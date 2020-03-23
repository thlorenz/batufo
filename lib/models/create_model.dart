import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/levels/tilemap.dart';
import 'package:batufo/models/game_model.dart';
import 'package:batufo/models/player_model.dart';

GameModel createModel(Tilemap tilemap, double tileSize) {
  final nrows = tilemap.nrows;
  final ncols = tilemap.ncols;
  final center = tileSize / 2;

  PlayerModel player;
  final floorTiles = List<TilePosition>();

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
    }
  }

  return GameModel(player: player, floorTiles: floorTiles);
}
