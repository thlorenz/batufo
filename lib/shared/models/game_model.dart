import 'package:batufo/shared/models/game_state.dart';

class ClientGameState extends GameState {
  void sync(GameState gameState) {
    for (final entry in gameState.players.entries) {
      players[entry.key] = entry.value;
    }
  }

  String toString() {
    return '''GameModel {
    player: $players
    bullets: $bullets
    }''';
  }
}
