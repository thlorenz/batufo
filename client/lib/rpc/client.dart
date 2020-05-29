import 'package:batufo/arena/arena.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show InfoRequest, InfoResponse, PlayRequest, GameCreated;
import 'package:batufo/universe.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final _log = Log<Client>();

List<int> listFromData(dynamic data) {
  return (data as String).split(',').map(int.parse).toList();
}

class GameStarted {
  final Client client;
  final PlayerModel player;
  final List<TilePosition> otherPlayers;
  final Arena arena;

  GameStarted(this.client, this.player, this.otherPlayers, this.arena);
}

class Client {
  final String serverHost;
  final Universe universe;
  final io.Socket _mainSocket;
  io.Socket _gameSocket;

  Client({
    @required this.serverHost,
    @required this.universe,
  }) : _mainSocket = io.io(serverHost, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

  void _connectMain(Function onConnected) {
    _mainSocket
      ..once('connect', (dynamic connection) {
        universe.clientConnected();
        onConnected();
        _log.info('main socket connected');
      })
      ..once('disconnect',
          (dynamic reason) => universe.clientDisconnected(reason as String))
      ..once('info:response', _onInfoMessage)
      ..once('game:created', _onGameCreatedMessage)
      ..connect();
  }

  void requestInfo() {
    _connectMain(() {
      final infoRequest = InfoRequest();
      final buf = infoRequest.writeToBuffer();
      _mainSocket.emitWithBinary('info:request', buf);
    });
  }

  void _onInfoMessage(dynamic data) {
    final list = listFromData(data);
    final info = InfoResponse.fromBuffer(list);
    final List<LevelInfo> levels =
        info.levels.map((x) => LevelInfo(x.name, x.nplayers)).toList();
    universe.clientReceivedInfo(ServerInfo(levels: levels));
  }

  void requestPlay(String level) {
    assert(
      _mainSocket.connected,
      'main socket should have connected when getting info',
    );
    final playRequest = PlayRequest()..levelName = level;
    final buf = playRequest.writeToBuffer();
    _mainSocket.emitWithBinary('play:request', buf);
  }

  void _onGameCreatedMessage(dynamic data) {
    final list = listFromData(data);
    final client = GameCreated.fromBuffer(list);

    final gameID = client.gameID;
    final arena = Arena.unpack(client.arena);
    universe.clientCreatedGame(client.clientID, client.playerIndex, arena);
    _gameSocket = io.io('$serverHost/$gameID', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    })
      ..connect();
  }

  void dispose() {
    _mainSocket?.once('disconnect',
        (dynamic reason) => universe.clientDisconnected(reason as String));
    _mainSocket?.disconnect();
  }
}
