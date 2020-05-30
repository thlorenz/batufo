import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';

class ClientSpawnedBulletUpdate {
  final int clientID;
  BulletModel spawnedBullet;

  ClientSpawnedBulletUpdate(this.clientID);

  PackedClientSpawnedBulletUpdate pack() {
    final packedUpdate = PackedClientSpawnedBulletUpdate();
    packedUpdate.clientID = clientID;
    packedUpdate.spawnedBullet = spawnedBullet?.pack();
    return packedUpdate;
  }

  factory ClientSpawnedBulletUpdate.unpack(
      PackedClientSpawnedBulletUpdate packed) {
    final spawnedBullet = BulletModel.unpack(packed.spawnedBullet);
    return ClientSpawnedBulletUpdate(packed.clientID)
      ..spawnedBullet = spawnedBullet;
  }

  String toString() {
    return '''
    spawnedBullets $spawnedBullet
    ''';
  }
}
