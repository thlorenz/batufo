import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:flutter/foundation.dart';

class HitTiles {
  final TilePosition topLeft;
  final TilePosition topRight;
  final TilePosition bottomLeft;
  final TilePosition bottomRight;

  HitTiles({
    @required this.topLeft,
    @required this.topRight,
    @required this.bottomRight,
    @required this.bottomLeft,
  });
}

HitTiles getHitTiles(WorldPosition wp, double size) {
  final radius = size / 2;
  final topLeft = WorldPosition(wp.x - radius, wp.y + radius).toTilePosition();
  final topRight = WorldPosition(wp.x + radius, wp.y + radius).toTilePosition();
  final bottomLeft =
      WorldPosition(wp.x - radius, wp.y - radius).toTilePosition();
  final bottomRight =
      WorldPosition(wp.x + radius, wp.y - radius).toTilePosition();

  return HitTiles(
    topLeft: topLeft,
    topRight: topRight,
    bottomLeft: bottomLeft,
    bottomRight: bottomRight,
  );
}
