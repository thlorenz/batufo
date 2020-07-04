import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedPoint, PackedTeleport;
import 'package:batufo/rpc/packing_types.dart' show Point;

class Teleport {
  final TilePosition portA;
  final TilePosition portB;

  Teleport(this.portA, this.portB);

  static Teleport unpack(PackedTeleport data, double tileSize) {
    final PackedPoint packedPortA = data.portA;
    final PackedPoint packedPortB = data.portB;

    assert(packedPortA != null, 'data was missing portA');
    assert(packedPortB != null, 'data was missing portB');

    final portA = Point.unpack(packedPortA);
    final portB = Point.unpack(packedPortB);
    return Teleport(
      TilePosition.centered(portA.x, portA.y, tileSize),
      TilePosition.centered(portB.x, portB.y, tileSize),
    );
  }
}
