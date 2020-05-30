import 'package:batufo/models/player_model.dart';

class PlayerStatus {
  static bool isDead(PlayerModel player) {
    return player.health <= 0;
  }

  static bool isAlive(PlayerModel player) => !isDead(player);
}
