import 'dart:ui';

import 'package:batufo/arena/pickup.dart';
import 'package:batufo/arena/teleport.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart' show PackedArena;
import 'package:flutter/foundation.dart';

class Arena {
  final List<TilePosition> floorTiles;
  final List<TilePosition> walls;
  final List<TilePosition> players;
  final List<Pickup> pickups;
  final List<Teleport> teleports;
  final int nrows;
  final int ncols;
  final int tileSize;

  // Local properties
  final List<Offset> buildingWorldOffsets;
  final Size size;

  Arena({
    @required this.floorTiles,
    @required this.walls,
    @required this.players,
    @required this.pickups,
    @required this.nrows,
    @required this.ncols,
    @required this.tileSize,
    @required this.teleports,
  })  : buildingWorldOffsets = List.from(walls.map<Offset>(
            (x) => x.toWorldOffset(tileSize: tileSize.toDouble()))),
        size = Size(ncols * tileSize.toDouble(), nrows * tileSize.toDouble());

  PackedArena pack() {
    final packedFloorTiles = floorTiles.map((x) => x.pack());
    final packedWalls = walls.map((x) => x.pack());
    final packedPlayerPositions = players.map((x) => x.pack());
    final packedArena = PackedArena()
      ..nrows = nrows
      ..ncols = ncols
      ..tileSize = tileSize;
    packedFloorTiles.forEach((x) => packedArena.floorTiles.add(x));
    packedWalls.forEach((x) => packedArena.walls.add(x));
    packedPlayerPositions.forEach((x) => packedArena.playerPositions.add(x));

    return packedArena;
  }

  factory Arena.unpack(PackedArena data) {
    final tileSize = data.tileSize;
    final floorTiles =
        data.floorTiles.map((x) => TilePosition.unpack(x)).toList();
    final walls = data.walls.map((x) => TilePosition.unpack(x)).toList();
    final playerPositions =
        data.playerPositions.map((x) => TilePosition.unpack(x)).toList();
    final pickups = data.pickups.map(Pickup.unpack).toList();
    final teleports = data.teleports
        .map((x) => Teleport.unpack(x, tileSize.toDouble()))
        .toList();

    return Arena(
      floorTiles: floorTiles,
      walls: walls,
      players: playerPositions,
      pickups: pickups,
      teleports: teleports,
      nrows: data.nrows,
      ncols: data.ncols,
      tileSize: tileSize,
    );
  }

  String toString() {
    return '''
    Arena: ${nrows}x$ncols {
      players: $players
      walls: $walls
      pickups: $pickups
      teleports: $teleports
    }
''';
  }
}
