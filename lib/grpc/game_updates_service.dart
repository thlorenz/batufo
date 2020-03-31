import 'package:batufo/generated/message_bus.pbgrpc.dart';
import 'package:batufo/utils/ids.dart';
import 'package:grpc/grpc.dart';

class Game {
  final int id;
  final List<PlayingClient> clients;

  Game(this.id, {this.clients = const <PlayingClient>[]});
}

class GameUpdatesService extends GameUpdatesServiceBase {
  int _currentGameID;
  final Map<int, Game> _games;
  GameUpdatesService() : _games = Map<int, Game>();

  Future<PlayingClient> play(ServiceCall call, Empty request) {
    final game = _getOrCreateCurrentGame();

    final clientID = getRandomInt();
    final playingClient = PlayingClient()
      ..gameID = game.id
      ..clientID = clientID;

    game.clients.add(playingClient);
    return Future.value(playingClient);
  }

  Game _getOrCreateCurrentGame() {
    Game game;
    if (_games.isEmpty) {
      _currentGameID = getRandomInt();
      game = Game(_currentGameID);
      _games[_currentGameID] = game;
    } else {
      game = _games[_currentGameID];
    }
    return game;
  }
}
