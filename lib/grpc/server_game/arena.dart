import 'package:batufo/dart_types/dart_types.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/generated/message_bus.pb.dart'
    show PackedArena, PackedInitialPlayer;
import 'package:batufo/levels/levels.dart';
import 'package:batufo/levels/tilemap.dart';

class InitialPlayer {
  int id;
  final TilePosition tilePosition;

  InitialPlayer(this.tilePosition, [this.id]);

  PackedInitialPlayer pack() {
    return PackedInitialPlayer()
      ..id = id
      ..tilePosition = tilePosition.pack();
  }

  factory InitialPlayer.unpack(PackedInitialPlayer data) {
    return InitialPlayer(TilePosition.unpack(data.tilePosition), data.id);
  }
}

class Arena {
  final List<TilePosition> floorTiles;
  final List<TilePosition> walls;
  final List<InitialPlayer> players;
  final int nrows;
  final int ncols;

  Arena({
    @required this.floorTiles,
    @required this.walls,
    @required this.players,
    @required this.nrows,
    @required this.ncols,
  });

  bool get isFull =>
      players.where((x) => x.id != null).length == players.length;

  void registerClient(int id) {
    assert(!isFull, 'cannot register more clients with full arena');

    for (final p in players) {
      if (p.id != null) continue;
      p.id = id;
      return;
    }
  }

  factory Arena.fromTilemap(Tilemap tilemap, double tileSize) {
    final nrows = tilemap.nrows;
    final ncols = tilemap.ncols;
    final center = tileSize / 2;
    final floorTiles = <TilePosition>[];
    final walls = <TilePosition>[];
    final initialPlayers = <InitialPlayer>[];

    for (int row = 0; row < nrows; row++) {
      for (int col = 0; col < ncols; col++) {
        final tile = tilemap.tiles[row * ncols + col];
        if (!Tilemap.coversBackground(tile)) {
          floorTiles.add(TilePosition(col, row, center, center));
        }
        if (tile == Tile.Wall || tile == Tile.Boundary) {
          walls.add(TilePosition(col, row, center, center));
        }
        if (tile == Tile.Player) {
          initialPlayers.add(
            InitialPlayer(TilePosition(col, row, center, center)),
          );
        }
      }
    }
    return Arena(
      floorTiles: floorTiles,
      walls: walls,
      players: initialPlayers,
      nrows: nrows,
      ncols: ncols,
    );
  }

  PackedArena pack() {
    final packedFloorTiles = floorTiles.map((x) => x.pack());
    final packedWalls = walls.map((x) => x.pack());
    final packedInitialPlayers = players.map((x) => x.pack());
    final packedArena = PackedArena()
      ..nrows = nrows
      ..ncols = ncols;
    packedFloorTiles.forEach((x) => packedArena.floorTiles.add(x));
    packedWalls.forEach((x) => packedArena.walls.add(x));
    packedInitialPlayers.forEach((x) => packedArena.players.add(x));

    return packedArena;
  }

  factory Arena.unpack(PackedArena data) {
    final floorTiles =
        data.floorTiles.map((x) => TilePosition.unpack(x)).toList();
    final walls = data.walls.map((x) => TilePosition.unpack(x)).toList();
    final initialPlayers =
        data.players.map((x) => InitialPlayer.unpack(x)).toList();

    return Arena(
      floorTiles: floorTiles,
      walls: walls,
      players: initialPlayers,
      nrows: data.nrows,
      ncols: data.ncols,
    );
  }

  static Arena forLevel(String levelName) {
    final tilemap = Levels.tilemapForLevel(levelName);
    return Arena.fromTilemap(tilemap, GameProps.tileSize);
  }
}
