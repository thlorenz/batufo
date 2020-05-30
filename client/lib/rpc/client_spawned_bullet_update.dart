import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';

class ClientSpawnedBulletUpdate {
  BulletModel spawnedBullet;

  ClientSpawnedBulletUpdate();

  PackedClientSpawnedBulletUpdate pack() {
    final packedUpdate = PackedClientSpawnedBulletUpdate();
    packedUpdate.spawnedBullet = spawnedBullet?.pack();
    return packedUpdate;
  }

  factory ClientSpawnedBulletUpdate.unpack(
      PackedClientSpawnedBulletUpdate packed) {
    final spawnedBullet = BulletModel.unpack(packed.spawnedBullet);
    return ClientSpawnedBulletUpdate()..spawnedBullet = spawnedBullet;
  }

  String toString() {
    return '''
    spawnedBullets $spawnedBullet
    ''';
  }
}
