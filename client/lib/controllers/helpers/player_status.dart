import 'package:batufo/models/player_model.dart';

class PlayerStatus {
  final PlayerModel player;
  PlayerStatus(this.player);

  bool get isDead {
    return player.health <= 0;
  }
}
