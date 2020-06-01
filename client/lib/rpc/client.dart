import 'package:batufo/arena/arena.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/client_player_update.dart';
import 'package:batufo/rpc/client_spawned_bullet_update.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show
        GameCreated,
        InfoRequest,
        InfoResponse,
        PackedClientPlayerUpdate,
        PackedClientSpawnedBulletUpdate,
        PlayRequest,
        ServerStatsUpdate;
import 'package:batufo/states/user_state.dart';
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

  void _ensureMainSocketConnected(Function onConnected) {
    if (_mainSocket.connected) {
      onConnected();
      return;
    }
    _mainSocket
      ..once('connect', (dynamic _) {
        universe.clientConnected();
        onConnected();
        _log.info('main socket connected');
      })
      ..once('disconnect',
          (dynamic reason) => universe.clientDisconnected(reason as String))
      ..on('server:stats', _onServerStatsMessage)
      ..connect();
  }

  void requestInfo() {
    _ensureMainSocketConnected(() {
      final infoRequest = InfoRequest();
      final buf = infoRequest.writeToBuffer();
      _mainSocket
        ..once('info:response', _onInfoMessage)
        ..emitWithBinary('info:request', buf);
      _log.fine('info:request');
    });
  }

  void _onInfoMessage(dynamic data) {
    final list = listFromData(data);
    final info = InfoResponse.fromBuffer(list);
    final List<LevelInfo> levels =
        info.levels.map((x) => LevelInfo(x.name, x.nplayers)).toList();
    universe.clientReceivedInfo(ServerInfo(levels: levels));
    _log.fine('info:message', info.levels);
  }

  void requestPlay(String level) {
    assert(
      _mainSocket.connected,
      'main socket should have connected when getting info',
    );
    final playRequest = PlayRequest()..levelName = level;
    final buf = playRequest.writeToBuffer();
    _mainSocket
      ..once('game:created', _onGameCreatedMessage)
      ..emitWithBinary('play:request', buf);
    _log.fine('play:request', level);
  }

  void _onGameCreatedMessage(dynamic data) {
    final list = listFromData(data);
    final createdGame = GameCreated.fromBuffer(list);
    final arena = Arena.unpack(createdGame.arena);
    universe.clientCreatedGame(
      createdGame.clientID,
      createdGame.playerIndex,
      arena,
    );
    connectGameSocket(createdGame);
    _log.fine('game:created', [createdGame.gameID, createdGame.clientID]);
  }

  void _onServerStatsMessage(dynamic data) {
    final list = listFromData(data);
    final stats = ServerStatsUpdate.fromBuffer(list);
    universe.receivedServerStatsUpdate(stats);
  }

  void connectGameSocket(GameCreated createdGame) {
    final gameID = createdGame.gameID;
    // TODO: need to handle unexpected disconnect
    _gameSocket = io.io('$serverHost/$gameID', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    })
      ..once('connect', (dynamic _) {
        _log.info('game-socket:connect');
      })
      ..once('game:started', (dynamic _) {
        _log.info('game:started');
        universe.clientStartedGame();
      })
      ..on('game:client-update', _onClientPlayerUpdateMessage)
      ..on('game:spawned-bullet', _onClientSpawnedBulletMessage)
      ..connect();
  }

  void sendClientPlayerUpdate(ClientPlayerUpdate update) {
    assert(_gameSocket != null, 'cannot send update without a connected game');
    assert(update != null, 'need a valid non-null update');
    final packed = update.pack();
    final buf = packed.writeToBuffer();
    _gameSocket.emitWithBinary('game:client-update', buf);
  }

  void sendClientSpawnedBulletUpdate(ClientSpawnedBulletUpdate update) {
    assert(_gameSocket != null, 'cannot send update without a connected game');
    assert(update != null, 'need a valid non-null update');
    final packed = update.pack();
    final buf = packed.writeToBuffer();
    _gameSocket.emitWithBinary('game:spawned-bullet', buf);
  }

  void _onClientPlayerUpdateMessage(dynamic data) {
    final list = listFromData(data);
    final packed = PackedClientPlayerUpdate.fromBuffer(list);
    final update = ClientPlayerUpdate.unpack(packed);

    _log.finest('received: $update');
    universe.receivedClientPlayerUpdate(update);
  }

  void _onClientSpawnedBulletMessage(dynamic data) {
    final list = listFromData(data);
    final packed = PackedClientSpawnedBulletUpdate.fromBuffer(list);
    final update = ClientSpawnedBulletUpdate.unpack(packed);

    _log.finest('received: $update');
    universe.receivedSpawnedBulletUpdate(update);
  }

  void disconnect() {
    disconnectGame();
    if (_mainSocket == null || !_mainSocket.connected) return;
    _mainSocket.disconnect();
    _log.fine('disconnecting main socket');
  }

  void disconnectGame() {
    if (_gameSocket == null || !_gameSocket.connected) return;
    _gameSocket.disconnect();
    _log.fine('disconnecting game socket');
  }

  void dispose() {
    disconnect();
    _log.info('disposing');
  }
}
