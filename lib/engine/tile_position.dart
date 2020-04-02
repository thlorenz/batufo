import 'package:batufo/dart_types/dart_types.dart';
import 'package:batufo/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/generated/message_bus.pb.dart' show PackedTilePosition;
import 'package:batufo/utils/packing_types.dart' show FractionalPoint, Point;

@immutable
class TilePosition {
  final int col;
  final int row;
  final double relX;
  final double relY;

  const TilePosition(this.col, this.row, this.relX, this.relY);

  bool isSameTileAs(TilePosition other) => other.col == col && other.row == row;

  WorldPosition toWorldPosition() => WorldPosition.fromTilePosition(this);
  Offset toWorldOffset() => toWorldPosition().toOffset();

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
