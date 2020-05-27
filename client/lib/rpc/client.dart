import 'dart:async';
import 'dart:ui' show Offset;

import 'package:batufo/arena/arena.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';
import 'package:batufo/rpc/server_update.dart';
import 'package:batufo/universe.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
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
  final String level;
  final io.Socket socket;
  final Universe universe;
  Arena _arena;
  PlayingClient _playingClient;
  final _serverUpdate$ = BehaviorSubject<ServerUpdate>();

  Arena get arena => _arena;
  Stream<ServerUpdate> get serverUpdate$ => _serverUpdate$.stream;
  int get clientID => _playingClient.clientID;

  Client({
    @required this.level,
    @required this.serverHost,
    @required this.universe,
  }) : socket = io.io(serverHost, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        }) {
    _init();
  }

  void _init() {
    socket
      ..once('connect', (dynamic connection) {
        final playRequest = PlayRequest()..levelName = level;
        final buf = playRequest.writeToBuffer();
        socket.emitWithBinary('play:request', buf);
      })
      // TODO(thlorenz): implement reconnect logic unless we
      // disconnected on purpose, i.e. when game is over

      ..once('disconnect', (dynamic _) => _log.fine('disconnected'))
      ..once('game:created', _onGameCreatedMessage)
      ..once(
        'game:started',
        _onGameStartedMessage,
      )
      ..connect();
  }

  void _onGameCreatedMessage(dynamic data) {
    final list = listFromData(data);
    final client = PlayingClient.fromBuffer(list);
    final playingClient = PlayingClient()
      ..gameID = client.gameID
      ..clientID = client.clientID;
    final arena = Arena.unpack(client.arena);
    universe.handleGameCreated(level, playingClient, arena);
  }

  void _onGameStartedMessage(dynamic data) {
    final list = listFromData(data);
    final client = PlayingClient.fromBuffer(list);

    _playingClient = PlayingClient()
      ..gameID = client.gameID
      ..clientID = client.clientID;
    _arena = Arena.unpack(client.arena);

    final players = _arena.players;
    // TODO(thlorenz): server needs to send us the index of our player
    const playerIndex = 0;
    assert(
      _arena.players.length > playerIndex,
      'invalid player index $playerIndex '
      'for arena with only ${players.length} players.',
    );
    final model = PlayerModel(
        id: client.clientID,
        tilePosition: players[playerIndex],
        health: GameProps.playerTotalHealth,
        angle: 0,
        velocity: Offset.zero);

    _log.info(
      'Starting game gameID: ${client.gameID}, '
      'clientID: ${client.clientID}',
    );

    GameStarted(this, model, [], _arena);
  }

  void dispose() {
    if (!_serverUpdate$.isClosed) _serverUpdate$.close();
  }

  static Client create(Universe universe, String level, String serverHost) {
    return Client(
      universe: universe,
      level: level,
      serverHost: serverHost,
    ).._init();
  }
}
