import 'package:batufo/dart_types/dart_types.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/generated/message_bus.pb.dart';
import 'package:batufo/levels/levels.dart';
import 'package:batufo/levels/tilemap.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/game_model.dart';

class Arena {
  final List<TilePosition> floorTiles;
  final List<TilePosition> walls;
  final int nrows;
  final int ncols;

  Arena({
    @required this.floorTiles,
    @required this.walls,
    @required this.nrows,
    @required this.ncols,
  });

  factory Arena.fromTilemap(Tilemap tilemap, double tileSize) {
    final nrows = tilemap.nrows;
    final ncols = tilemap.ncols;
    final center = tileSize / 2;
    final floorTiles = <TilePosition>[];
    final walls = <TilePosition>[];

    for (int row = 0; row < nrows; row++) {
      for (int col = 0; col < ncols; col++) {
        final tile = tilemap.tiles[row * ncols + col];
        if (!Tilemap.coversBackground(tile)) {
          floorTiles.add(TilePosition(col, row, center, center));
        }
        if (tile == Tile.Wall || tile == Tile.Boundary) {
          walls.add(TilePosition(col, row, center, center));
        }
      }
    }
    return Arena(
      floorTiles: floorTiles,
      walls: walls,
      nrows: nrows,
      ncols: ncols,
    );
  }

  PackedArena pack() {
    final packedFloorTiles = floorTiles.map((x) => x.pack());
    final packedWalls = walls.map((x) => x.pack());
    final packedArena = PackedArena()
      ..nrows = nrows
      ..ncols = ncols;
    packedFloorTiles.forEach((x) => packedArena.floorTiles.add(x));
    packedWalls.forEach((x) => packedArena.walls.add(x));
    return packedArena;
  }

  factory Arena.unpack(PackedArena data) {
    final floorTiles =
        data.floorTiles.map((x) => TilePosition.unpack(x)).toList();
    final walls = data.walls.map((x) => TilePosition.unpack(x)).toList();

    return Arena(
      floorTiles: floorTiles,
      walls: walls,
      nrows: data.nrows,
      ncols: data.ncols,
    );
  }

  GameModel initGameModel() {
    return GameModel(
      floorTiles: floorTiles,
      walls: walls,
      bullets: <BulletModel>[],
      nrows: nrows,
      ncols: ncols,
    );
  }

  static Arena forLevel(String levelName) {
    final tilemap = Levels.tilemapForLevel(levelName);
    return Arena.fromTilemap(tilemap, GameProps.tileSize);
  }
}
