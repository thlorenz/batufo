import 'dart:ui';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/entities/floor.dart';
import 'package:batufo/game/entities/walls.dart';
import 'package:flutter/foundation.dart';

class Buildings {
  final Floor _floor;
  final Walls _walls;
  final bool enableRecording;
  Picture _recordedPicture;

  Buildings({
    @required List<TilePosition> floorTiles,
    @required List<TilePosition> walls,
    @required double tileSize,
    @required bool isFloorActive,
    @required this.enableRecording,
  })  : _walls = Walls(walls, tileSize),
        _floor = Floor(floorTiles, tileSize, isFloorActive) {
    if (enableRecording) _recordedPicture = _recordPicture();
  }

  Picture _recordPicture() {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    _render(canvas);
    return recorder.endRecording();
  }

  void _render(Canvas canvas) {
    _floor.render(canvas);
    _walls.render(canvas);
  }

  void render(Canvas canvas) {
    if (enableRecording) {
      return canvas.drawPicture(_recordedPicture);
    } else {
      _render(canvas);
    }
  }
}
