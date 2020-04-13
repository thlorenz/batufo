import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/models/game_state.dart';

final _log = Log<ClientGameState>();

class ClientGameState extends GameState {
  void sync(GameState gameState) {
    _log.finest('updating game state');
    for (final entry in gameState.players.entries) {
      final player = entry.value;
      _log.finest(player.tilePosition.toString());
      players[entry.key] = player;
    }
  }

  String toString() {
    return '''GameModel {
    player: $players
    bullets: $bullets
    }''';
  }
}
