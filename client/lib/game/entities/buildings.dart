import 'dart:ui';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/entities/floor.dart';
import 'package:batufo/game/entities/scene.dart';
import 'package:batufo/game/entities/walls.dart';
import 'package:flutter/foundation.dart';

class Buildings extends Scene {
  final Floor _floor;
  final Walls _walls;

  Buildings({
    @required List<TilePosition> floorTiles,
    @required List<TilePosition> walls,
    @required double tileSize,
    @required bool isFloorActive,
    @required bool enableRecording,
    bool debugVisibleRect,
  })  : _walls = Walls(walls, tileSize),
        _floor = Floor(floorTiles, tileSize, isFloorActive),
        super(
          enableRecording: enableRecording,
          debugVisibleRect: debugVisibleRect,
        );

  bool get skipRender => false;

  void renderScene(Canvas canvas, Rect visibleRect) {
    _floor.render(canvas, visibleRect);
    _walls.render(canvas, visibleRect);
  }
}
