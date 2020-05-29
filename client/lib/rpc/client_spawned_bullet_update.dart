import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';

class ClientSpawnedBulletUpdate {
  final int clientID;
  BulletModel _spawnedBullet;

  ClientSpawnedBulletUpdate(this.clientID);

  set spawnedBullet(BulletModel value) {
    _spawnedBullet = value;
  }

  PackedClientSpawnedBulletUpdate pack() {
    final packedUpdate = PackedClientSpawnedBulletUpdate();
    packedUpdate.clientID = clientID;
    packedUpdate.spawnedBullet = _spawnedBullet?.pack();
    return packedUpdate;
  }

  String toString() {
    return '''
    spawnedBullets $_spawnedBullet
    ''';
  }
}
