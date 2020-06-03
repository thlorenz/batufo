import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

final _log = Log<ClientGameState>();

class ClientGameState {
  final int clientID;
  final int totalPlayers;
  final Map<int, PlayerModel> players;
  final List<BulletModel> bullets;

  bool synced = false;

  ClientGameState({
    @required this.totalPlayers,
    @required this.clientID,
    @required this.players,
    @required this.bullets,
  });

  PlayerModel get hero => players[clientID];
  int get remainingPlayers => players.length;
  int get playersAlive => players.values.where(PlayerStatus.isAlive).length;

  void updatePlayer(PlayerModel player) {
    assert(player != null, 'cannot add null as player');
    players[player.id] = player;
    _log.finest('updated player now have ${players.length} players');
  }

  void removePlayer(int clientID) {
    players.remove(clientID);
  }

  void addBullet(BulletModel bullet) {
    bullets.add(bullet);
  }

  void clearBullets() {
    bullets.clear();
  }

  ClientGameState clone() {
    final clonedPlayers = <int, PlayerModel>{};

    for (final entry in players.entries) {
      clonedPlayers[entry.key] = entry.value.clone();
    }

    final clonedBullets = bullets.map((x) => x.clone()).toList();
    return ClientGameState(
      totalPlayers: totalPlayers,
      clientID: clientID,
      players: clonedPlayers,
      bullets: clonedBullets,
    );
  }

  String toString() {
    return '''ClientGameState {
    player: $players
    bullets: $bullets
    }''';
  }
}
