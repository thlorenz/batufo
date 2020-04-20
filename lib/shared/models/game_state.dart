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

  PackedGameState pack() {
    final gameState = PackedGameState();
    final ps = gameState.players;
    players.values.forEach((x) => ps.add(x.pack()));
    return gameState;
  }

  factory GameState.unpack(PackedGameState data) {
    final gameState = GameState();

    for (final p in data.players) {
      final playerModel = PlayerModel.unpack(p);
      gameState.addPlayer(p.id, playerModel);
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
