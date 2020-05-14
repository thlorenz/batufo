import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';

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
