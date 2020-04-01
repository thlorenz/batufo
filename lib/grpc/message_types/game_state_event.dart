import 'package:batufo/generated/message_bus.pb.dart';
import 'package:batufo/models/player_model.dart';

class GameState {
  final Map<int, PlayerModel> _players;
  GameState() : _players = Map<int, PlayerModel>();

  void addPlayer(int id, PlayerModel player) {
    _players[id] = player;
  }

  bool get enoughPlayers => _players.length >= 2;

  PackedGameState pack() {
    final gameState = PackedGameState();
    final ps = gameState.players;
    _players.values.forEach((x) => ps.add(x.pack()));
    return gameState;
  }

  factory GameState.unpack(PackedGameState data) {
    final players = Map<int, PlayerModel>();
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
      players: $_players
     }''';
  }
}
