import 'dart:ui';

import 'package:batufo/engine/tile_position.dart';
import 'package:flutter/foundation.dart';

@immutable
class WorldPosition {
  final double x;
  final double y;

  const WorldPosition(this.x, this.y);

  static WorldPosition fromTilePosition(
    TilePosition tp, {
    double tileSize,
    bool center = false,
  }) {
    tileSize = tileSize ?? WorldPosition.tileSize;
    final halfTileSize = tileSize / 2.0;
    assert(tileSize != null, 'init tileSize first');
    final t = tileSize;
    final relX = center ? halfTileSize : tp.relX;
    final relY = center ? halfTileSize : tp.relY;
    final x = t * tp.col + relX;
    final y = t * tp.row + relY;
    return WorldPosition(x, y);
  }

  TilePosition toTilePosition() {
    assert(tileSize != null, 'init tileSize first');
    final t = tileSize;
    final col = x ~/ t;
    final row = y ~/ t;
    final relX = x % t;
    final relY = y % t;
    return TilePosition(col, row, relX, relY);
  }

  Offset toOffset() {
    return Offset(x, y);
  }

  static WorldPosition fromOffset(Offset offset) {
    return WorldPosition(offset.dx, offset.dy);
  }

  static double tileSize;
}
