import 'package:batufo/shared/models/game_state.dart';

class ClientGameState extends GameState {
  void sync(GameState gameState) {
    players = gameState.players;
  }

  String toString() {
    return '''GameModel {
    player: $players
    bullets: $bullets
    }''';
  }
}
