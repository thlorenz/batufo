import 'dart:async';

import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/models/game_state.dart';
import 'package:batufo/shared/models/player_model.dart';

final _log = Log<ClientGameState>();

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

  void sync(GameState serverState) {
    for (final entry in serverState.players.entries) {
      final player = entry.value;
      final id = entry.key;
      if (!synced || !SYNC_ONLY_ONCE) {
        players[id] = player;
        synced = true;
      }

      if (id == clientID) {
        _addStats(
          player,
          GameState.playersAlive(serverState),
        );
      }
    }

    clearBullets();
    for (final bullet in serverState.bullets) {
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
