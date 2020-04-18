import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/models/game_state.dart';

final _log = Log<ClientGameState>();

const SYNC_ONLY_ONCE = false;

class ClientGameState extends GameState {
  bool synced = false;
  void sync(GameState gameState) {
    for (final entry in gameState.players.entries) {
      final player = entry.value;
      if (!synced || !SYNC_ONLY_ONCE) {
        players[entry.key] = player;
        synced = true;
      }
    }
  }

  String toString() {
    return '''GameModel {
    player: $players
    bullets: $bullets
    }''';
  }
}
