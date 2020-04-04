import 'package:batufo/dart_types/dart_types.dart';
import 'package:batufo/engine/geometry/dart_geometry.dart';
import 'package:batufo/generated/message_bus.pb.dart' show PlayingClient;
import 'package:batufo/grpc/message_types/game_state_event.dart';
import 'package:batufo/grpc/server_game/arena.dart';
import 'package:batufo/grpc/server_game/game_loop.dart';
import 'package:batufo/models/player_model.dart';

class ServerGame {
  final int id;
  final List<PlayingClient> _clients;
  final Arena arena;

  final GameLoop _gameLoop;

  ServerGame(
    this.id, {
    @required this.arena,
    @required GameState gameState,
    List<PlayingClient> clients,
  })  : _clients = clients ?? <PlayingClient>[],
        _gameLoop = GameLoop(gameState);

  bool get isFull => arena.isFull(_clients.length);

  bool tryStart() {
    if (!isFull) return false;
    _gameLoop.start();
    return true;
  }

  void addClient(PlayingClient playingClient) {
    assert(!isFull, 'cannot add more clients to arena');

    _clients.add(playingClient);
    final player = PlayerModel(
      id: playingClient.clientID,
      tilePosition: arena.playerPosition(_clients.length - 1),
      angle: 0.0,
      velocity: Offset.zero,
      appliedThrust: false,
    );
    _gameLoop.addPlayer(player);
  }

  Stream<GameState> get gameState$ => _gameLoop.gameState$;

  void dispose() {
    _gameLoop.dispose();
  }
}
