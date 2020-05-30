import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

const SYNC_ONLY_ONCE = false;

class Stats {
  final double health;
  final int playersAlive;

  Stats({@required this.health, @required this.playersAlive});

  String toString() {
    return 'Stats [ $health, $playersAlive ]';
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stats &&
          runtimeType == other.runtimeType &&
          health == other.health &&
          playersAlive == other.playersAlive;

  int get hashCode => health.hashCode ^ playersAlive.hashCode;

  static Stats initial(int playersAlive) {
    return Stats(
      health: GameProps.playerTotalHealth,
      playersAlive: playersAlive,
    );
  }
}

final _log = Log<ClientGameState>();

class ClientGameState {
  final int clientID;
  final Map<int, PlayerModel> players;
  final List<BulletModel> bullets;

  bool synced = false;

  ClientGameState({@required this.clientID, this.players, this.bullets});

  void updatePlayer(PlayerModel player) {
    assert(player != null, 'cannot add null as player');
    players[player.id] = player;
    _log.finest('updated player now have ${players.length} players');
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
