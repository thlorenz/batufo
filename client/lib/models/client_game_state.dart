import 'package:batufo/game_props.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/server_update.dart';
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

class ClientGameState {
  final int clientID;
  final Map<int, PlayerModel> players;
  final List<BulletModel> bullets;

  bool synced = false;

  ClientGameState({@required this.clientID, this.players, this.bullets});

  void sync(ServerUpdate serverUpdate) {
    for (final entry in serverUpdate.players.entries) {
      final player = entry.value;
      final id = entry.key;
      if (!synced || !SYNC_ONLY_ONCE) {
        players[id] = player;
        synced = true;
      }

      if (id == clientID) {
        _addStats(
          player,
          ServerUpdate.playersAlive(serverUpdate),
        );
      }
    }

    clearBullets();
    // TODO: don't add our own bullets possibly via a clientSpawnID
    // on the bullet
    for (final bullet in serverUpdate.spawnedBullets) {
      addBullet(bullet);
    }
  }

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

  void _addStats(PlayerModel player, int playersAlive) {
    /* TODO:
    final stats = Stats(
      health: player.health,
      playersAlive: playersAlive,
    );
    if (stats == _currentStats) return;
    _currentStats = stats;
    _stats$.add(stats);
     */
  }

  String toString() {
    return '''ClientGameState {
    player: $players
    bullets: $bullets
    }''';
  }
}
