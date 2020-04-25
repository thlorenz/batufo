import 'dart:async';

import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/models/game_state.dart';
import 'package:batufo/shared/models/player_model.dart';

final _log = Log<ClientGameState>();

const SYNC_ONLY_ONCE = false;

class Stats {
  final double health;

  Stats({@required this.health});

  String toString() {
    return 'Stats [ $health ]';
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stats &&
          runtimeType == other.runtimeType &&
          health == other.health;

  int get hashCode => health.hashCode;
}

class ClientGameState extends GameState {
  final int clientID;

  bool synced = false;
  Stats _currentStats;
  final StreamController<Stats> _stats$;

  ClientGameState({@required this.clientID})
      : _stats$ = StreamController<Stats>();

  Stream<Stats> get stats$ => _stats$.stream.asBroadcastStream();

  void sync(GameState serverState) {
    for (final entry in serverState.players.entries) {
      final player = entry.value;
      final id = entry.key;
      if (!synced || !SYNC_ONLY_ONCE) {
        players[id] = player;
        synced = true;
      }
      if (id == clientID) {
        _addStats(player);
      }
    }

    clearBullets();
    for (final bullet in serverState.bullets) {
      addBullet(bullet);
    }
  }

  void _addStats(PlayerModel player) {
    final stats = Stats(health: player.health);
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
