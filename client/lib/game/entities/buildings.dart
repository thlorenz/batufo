import 'dart:ui';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/entities/floor.dart';
import 'package:batufo/game/entities/recordable.dart';
import 'package:batufo/game/entities/walls.dart';
import 'package:flutter/foundation.dart';

class Buildings extends Recordable {
  final Floor _floor;
  final Walls _walls;

  Buildings({
    @required List<TilePosition> floorTiles,
    @required List<TilePosition> walls,
    @required double lerpFactor,
    @required double tileSize,
    @required bool isFloorActive,
    @required bool enableRecording,
  })  : _walls = Walls(walls, tileSize),
        _floor = Floor(floorTiles, tileSize, isFloorActive),
        super(enableRecording: enableRecording, sizeFactor: lerpFactor);

  bool get skipRender => false;

  void renderScene(Canvas canvas, Size size) {
    _floor.render(canvas);
    _walls.render(canvas);
  }
}
