import 'package:batufo/shared/generated/message_bus.pb.dart';
import 'package:batufo/shared/models/bullet_model.dart';
import 'package:batufo/shared/models/player_model.dart';

class GameState {
  Map<int, PlayerModel> players;
  List<BulletModel> bullets;
  GameState()
      : players = <int, PlayerModel>{},
        bullets = <BulletModel>[];

  void addPlayer(int id, PlayerModel player) {
    players[id] = player;
  }

  PackedGameState pack() {
    final gameState = PackedGameState();
    final ps = gameState.players;
    players.values.forEach((x) => ps.add(x.pack()));
    return gameState;
  }

  factory GameState.unpack(PackedGameState data) {
    final gameState = GameState();

    for (final p in data.players) {
      final playerModel = PlayerModel.unpack(p);
      gameState.addPlayer(p.id, playerModel);
    }
    return gameState;
  }

  @override
  String toString() {
    return '''GameState { 
      players: $players
     }''';
  }
}
