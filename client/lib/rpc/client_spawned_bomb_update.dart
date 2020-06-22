import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedClientSpawnedBombUpdate;

class ClientSpawnedBombUpdate {
  TilePosition spawnPosition;

  ClientSpawnedBombUpdate();

  PackedClientSpawnedBombUpdate pack() {
    final packedUpdate = PackedClientSpawnedBombUpdate();
    packedUpdate.spawnPosition = spawnPosition?.pack();
    return packedUpdate;
  }

  factory ClientSpawnedBombUpdate.unpack(PackedClientSpawnedBombUpdate packed) {
    return ClientSpawnedBombUpdate()
      ..spawnPosition = TilePosition.unpack(packed.spawnPosition);
  }

  String toString() {
    return '''
    spawnPosition $spawnPosition
    ''';
  }
}
