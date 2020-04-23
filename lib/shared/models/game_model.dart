import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/models/game_state.dart';

final _log = Log<ClientGameState>();

const SYNC_ONLY_ONCE = false;

class ClientGameState extends GameState {
  bool synced = false;
  void sync(GameState serverState) {
    for (final entry in serverState.players.entries) {
      final player = entry.value;
      if (player.appliedThrust) _log.fine(player.toString());
      if (!synced || !SYNC_ONLY_ONCE) {
        players[entry.key] = player;
        synced = true;
      }
    }

    clearBullets();
    for (final bullet in serverState.bullets) {
      addBullet(bullet);
    }
  }

  String toString() {
    return '''GameModel {
    player: $players
    bullets: $bullets
    }''';
  }
}
