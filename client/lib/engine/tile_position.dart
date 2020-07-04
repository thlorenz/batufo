import 'dart:ui' show Offset;

import 'package:batufo/engine/world_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedTilePosition;
import 'package:batufo/rpc/packing_types.dart' show FractionalPoint, Point;
import 'package:flutter/foundation.dart';

@immutable
class TilePosition {
  final int col;
  final int row;
  final double relX;
  final double relY;

  const TilePosition(this.col, this.row, this.relX, this.relY);

  factory TilePosition.centered(int col, int row, [double tileSize]) {
    tileSize = tileSize ?? WorldPosition.tileSize;
    final relX = tileSize / 2;
    final relY = tileSize / 2;
    return TilePosition(col, row, relX, relY);
  }

  factory TilePosition.zero() {
    return TilePosition(0, 0, 0.0, 0.0);
  }

  bool isSameTileAs(TilePosition other) => other.col == col && other.row == row;

  WorldPosition toWorldPosition({double tileSize, bool center = false}) =>
      WorldPosition.fromTilePosition(this, tileSize: tileSize);
  Offset toWorldOffset({double tileSize, bool center = false}) =>
      toWorldPosition(tileSize: tileSize, center: center).toOffset();

  TilePosition copyWith({
    int col,
    int row,
    double relX,
    double relY,
  }) {
    return TilePosition(
      col ?? this.col,
      row ?? this.row,
      relX ?? this.relX,
      relY ?? this.relY,
    );
  }

  PackedTilePosition pack() {
    final colRow = Point(col, row).pack();
    final relXY = FractionalPoint(relX, relY).pack();
    return PackedTilePosition()
      ..colRow = colRow
      ..relXY = relXY;
  }

  factory TilePosition.unpack(PackedTilePosition data) {
    final colRow = Point.unpack(data.colRow);
    final relXY = FractionalPoint.unpack(data.relXY);
    return TilePosition(colRow.x, colRow.y, relXY.x, relXY.y);
  }

  @override
  String toString() {
    return '''TilePosition {
      col: $col + $relX
      row: $row + $relY
    }''';
  }
}
