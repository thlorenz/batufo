import 'package:batufo/models/player_model.dart';

class GameModel {
  PlayerModel player;
  GameModel({this.player});

  String toString() {
    return '''GameModel {
    player: $player
    }''';
  }
}
