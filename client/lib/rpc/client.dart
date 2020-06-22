import 'dart:async';

import 'package:batufo/arena/arena.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/client_picked_up_update.dart';
import 'package:batufo/rpc/client_player_update.dart';
import 'package:batufo/rpc/client_spawned_bomb_update.dart';
import 'package:batufo/rpc/client_spawned_bullet_update.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show
        GameCreated,
        InfoRequest,
        InfoResponse,
        PackedClientPickedUpUpdate,
        PackedClientPlayerUpdate,
        PackedClientSpawnedBombUpdate,
        PackedClientSpawnedBulletUpdate,
        PlayRequest,
        PlayerDeparted,
        PlayerJoined,
        ServerStatsUpdate;
import 'package:batufo/rpc/generated/message_bus.pbenum.dart' show Platform;
import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final _log = Log<Client>();

List<int> listFromData(dynamic data) {
  return (data as String).split(',').map(int.parse).toList();
}

const PING_TIMEOUT = Duration(seconds: 5);

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
  final io.Socket _socket;
  final Duration pingTimeout;
  Timer _pingTimer;

  Client({
    @required this.serverHost,
    @required this.universe,
    this.pingTimeout = PING_TIMEOUT,
  }) : _socket = io.io(serverHost, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        }) {
    _pingTimer = Timer.periodic(pingTimeout, _sendPing);
  }

  void _ensureMainSocketConnected(Function onConnected) {
    if (_socket.connected) {
      onConnected();
      return;
    }
    _socket
      ..once('connect', (dynamic _) {
        universe.clientConnected();
        onConnected();
        _log.info('main socket connected');
      })
      ..once('disconnect',
          (dynamic reason) => universe.clientDisconnected(reason as String))
      ..on('server:stats', _onServerStatsMessage)
      ..on('game:client-update', _onClientPlayerUpdateMessage)
      ..on('game:spawned-bullet', _onClientSpawnedBulletMessage)
      ..on('game:spawned-bomb', _onClientSpawnedBombMessage)
      ..on('game:picked-up', _onClientPickedUpMessage)
      ..on('game:player-joined', _onPlayerJoinedMessage)
      ..on('game:player-departed', _onPlayerDepartedMessage)
      ..connect();
  }

  void _sendPing(Timer timer) {
    if (_socket == null || !_socket.connected || !universe.involvedInGame) {
      return;
    }
    _socket.emit('client:ping');
  }

  void requestInfo() {
    _ensureMainSocketConnected(() {
      final infoRequest = InfoRequest();
      final buf = infoRequest.writeToBuffer();
      _socket
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
      _socket.connected,
      'main socket should have connected when getting info',
    );
    final playRequest = PlayRequest()
      ..levelName = level
      ..platform = Platform.values[universe.platform.index];

    final buf = playRequest.writeToBuffer();
    _socket
      ..once('game:created', _onGameCreatedMessage)
      ..once('game:started', _onGameStartedMessage)
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
    _log.fine('game:created', [createdGame.gameID, createdGame.clientID]);
  }

  void _onGameStartedMessage(dynamic _) {
    _log.info('game:started');
    universe.clientStartedGame();
  }

  void requestLeave() {
    _log.fine('leaving game');
    _socket.emit('game:leave');
  }

  void _onServerStatsMessage(dynamic data) {
    final list = listFromData(data);
    final stats = ServerStatsUpdate.fromBuffer(list);
    universe.receivedServerStatsUpdate(stats);
  }

  void sendClientPlayerUpdate(ClientPlayerUpdate update) {
    assert(update != null, 'need a valid non-null update');
    final packed = update.pack();
    final buf = packed.writeToBuffer();
    _socket.emitWithBinary('game:client-update', buf);
  }

  void sendClientSpawnedBulletUpdate(ClientSpawnedBulletUpdate update) {
    assert(update != null, 'need a valid non-null update');
    final packed = update.pack();
    final buf = packed.writeToBuffer();
    _socket.emitWithBinary('game:spawned-bullet', buf);
  }

  void sendClientSpawnedBombUpdate(ClientSpawnedBombUpdate update) {
    assert(update != null, 'need a valid non-null update');
    final packed = update.pack();
    final buf = packed.writeToBuffer();
    _socket.emitWithBinary('game:spawned-bomb', buf);
  }

  void sendClientPickedUpUpdate(ClientPickedUpUpdate update) {
    assert(update != null, 'need a valid non-null update');
    final packed = update.pack();
    final buf = packed.writeToBuffer();
    _socket.emitWithBinary('game:picked-up', buf);
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

  void _onClientSpawnedBombMessage(dynamic data) {
    final list = listFromData(data);
    final packed = PackedClientSpawnedBombUpdate.fromBuffer(list);
    final update = ClientSpawnedBombUpdate.unpack(packed);

    _log.finest('received: $update');
    universe.receivedSpawnedBombUpdate(update);
  }

  void _onClientPickedUpMessage(dynamic data) {
    final list = listFromData(data);
    final packed = PackedClientPickedUpUpdate.fromBuffer(list);
    final update = ClientPickedUpUpdate.unpack(packed);

    _log.finest('received: $update');
    universe.receivedClientPickedUpUpdate(update);
  }

  void _onPlayerJoinedMessage(dynamic data) {
    final list = listFromData(data);
    final playerJoined = PlayerJoined.fromBuffer(list);
    final clientID = playerJoined.clientID;
    final playerIndex = playerJoined.playerIndex;
    _log.fine('player joined: $clientID at index $playerIndex');
    universe.receivedPlayerJoined(clientID, playerIndex);
  }

  void _onPlayerDepartedMessage(dynamic data) {
    final list = listFromData(data);
    final playerDeparted = PlayerDeparted.fromBuffer(list);
    final clientID = playerDeparted.clientID;
    _log.fine('player departed: $clientID');
    universe.receivedPlayerDeparted(clientID);
  }

  void disconnect() {
    requestLeave();
    if (_socket == null || !_socket.connected) return;
    _socket.disconnect();
    _log.fine('disconnecting main socket');
  }

  void dispose() {
    disconnect();
    _pingTimer?.cancel();
    _log.info('disposing');
  }
}
