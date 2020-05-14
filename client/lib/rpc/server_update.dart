import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedServerUpdate;

class ServerUpdate {
  final Map<int, PlayerModel> players;
  // TODO: need to identify who spawned them to not respawn our own bullets
  final List<BulletModel> spawnedBullets;

  ServerUpdate(
      [Map<int, PlayerModel> players, List<BulletModel> spawnedBullets])
      : players = players ?? <int, PlayerModel>{},
        spawnedBullets = spawnedBullets ?? <BulletModel>[];

  void _addPlayer(int id, PlayerModel player) {
    players[id] = player;
  }

  void _addSpawnedBullet(BulletModel bullet) {
    spawnedBullets.add(bullet);
  }

  PackedServerUpdate pack() {
    final packedUpdate = PackedServerUpdate();

    final ps = packedUpdate.players;
    players.values.forEach((x) => ps.add(x.pack()));

    final bs = packedUpdate.spawnedBullets;
    spawnedBullets.forEach((x) => bs.add(x.pack()));
    return packedUpdate;
  }

  factory ServerUpdate.unpack(PackedServerUpdate data) {
    final serverUpdate = ServerUpdate();

    for (final p in data.players) {
      final playerModel = PlayerModel.unpack(p);
      serverUpdate._addPlayer(p.id, playerModel);
    }
    for (final b in data.spawnedBullets) {
      final bulletModel = BulletModel.unpack(b);
      serverUpdate._addSpawnedBullet(bulletModel);
    }
    return serverUpdate;
  }

  static int playersAlive(ServerUpdate serverUpdate) {
    return serverUpdate.players.values.where((x) => x.health > 0).length;
  }

  String toString() {
    return '''
    players: $players
    spawnedBullets: $spawnedBullets
    ''';
  }
}
