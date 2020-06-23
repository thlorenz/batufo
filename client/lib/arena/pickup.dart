import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedPickup, PackedPickupType;

enum PickupType {
  Medkit,
  Shield,
  Bomb,
}

PickupType unpackPickupType(PackedPickupType data) {
  return PickupType.values[data.value];
}

PackedPickupType packPickupType(PickupType type) {
  return PackedPickupType.values[type.index];
}

class Pickup {
  final PickupType type;
  final TilePosition tilePosition;

  String get id => '$type:[${tilePosition.col},${tilePosition.row}]';

  Pickup(this.type, this.tilePosition);

  PackedPickup pack() {
    final packedType = packPickupType(type);
    final packedTilePosition = tilePosition.pack();

    return PackedPickup()
      ..type = packedType
      ..tilePosition = packedTilePosition;
  }

  static Pickup unpack(PackedPickup data) {
    final type = unpackPickupType(data.type);
    final tilePosition = TilePosition.unpack(data.tilePosition);

    return Pickup(type, tilePosition);
  }
}
