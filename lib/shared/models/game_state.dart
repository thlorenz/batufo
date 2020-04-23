import 'package:batufo/shared/generated/message_bus.pb.dart';
import 'package:batufo/shared/models/bullet_model.dart';
import 'package:batufo/shared/models/player_model.dart';

class GameState {
  final Map<int, PlayerModel> players;
  final List<BulletModel> bullets;
  GameState([Map<int, PlayerModel> players, List<BulletModel> bullets])
      : players = players ?? <int, PlayerModel>{},
        bullets = bullets ?? <BulletModel>[];

  void addPlayer(int id, PlayerModel player) {
    assert(player != null, 'cannot add null as player');
    players[id] = player;
  }

  void addBullet(BulletModel bullet) {
    bullets.add(bullet);
  }

  void clearBullets() {
    bullets.clear();
  }

  PackedGameState pack() {
    final packedState = PackedGameState();

    final ps = packedState.players;
    players.values.forEach((x) => ps.add(x.pack()));

    final bs = packedState.bullets;
    bullets.forEach((x) => bs.add(x.pack()));
    return packedState;
  }

  factory GameState.unpack(PackedGameState data) {
    final gameState = GameState();

    for (final p in data.players) {
      final playerModel = PlayerModel.unpack(p);
      gameState.addPlayer(p.id, playerModel);
    }
    for (final b in data.bullets) {
      final bulletModel = BulletModel.unpack(b);
      gameState.addBullet(bulletModel);
    }
    return gameState;
  }

  GameState clone() {
    final clonedPlayers = <int, PlayerModel>{};

    for (final entry in players.entries) {
      clonedPlayers[entry.key] = entry.value.clone();
    }

    final clonedBullets = bullets.map((x) => x.clone()).toList();
    return GameState(clonedPlayers, clonedBullets);
  }

  @override
  String toString() {
    return '''GameState { 
      players: $players
     }''';
  }
}
