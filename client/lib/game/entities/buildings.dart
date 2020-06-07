import 'dart:ui';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/entities/floor.dart';
import 'package:batufo/game/entities/walls.dart';
import 'package:flutter/foundation.dart';

class Buildings {
  final Floor _floor;
  final Walls _walls;

  Buildings({
    @required List<TilePosition> floorTiles,
    @required List<TilePosition> walls,
    @required double tileSize,
    @required bool isFloorActive,
  })  : _walls = Walls(walls, tileSize),
        _floor = Floor(floorTiles, tileSize, isFloorActive);

  void render(Canvas canvas) {
    _floor.render(canvas);
    _walls.render(canvas);
  }
}
