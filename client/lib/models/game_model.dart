import 'dart:async';

import 'package:batufo/game_props.dart';
import 'package:batufo/models/game_state.dart';
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

class ClientGameState extends GameState {
  final int clientID;

  bool synced = false;
  Stats _currentStats;
  final StreamController<Stats> _stats$;

  ClientGameState({@required this.clientID})
      : _stats$ = StreamController<Stats>.broadcast();

  Stream<Stats> get stats$ => _stats$.stream;

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

  void _addStats(PlayerModel player, int playersAlive) {
    final stats = Stats(
      health: player.health,
      playersAlive: playersAlive,
    );
    if (stats == _currentStats) return;
    _currentStats = stats;
    _stats$.add(stats);
  }

  String toString() {
    return '''GameModel {
    player: $players
    bullets: $bullets
    }''';
  }
}
