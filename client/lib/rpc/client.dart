import 'dart:async';
import 'dart:ui' show Offset;

import 'package:batufo/arena/arena.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';
import 'package:batufo/rpc/server_update.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class Client {
  final String serverHost;
  final String level;
  Arena _arena;
  PlayingClient _playingClient;
  final _serverUpdate$ = BehaviorSubject<ServerUpdate>();

  Arena get arena => _arena;
  Stream<ServerUpdate> get serverUpdate$ => _serverUpdate$.stream;
  int get clientID => _playingClient.clientID;

  Client({@required this.level, @required this.serverHost}) {
    _init();
  }

  // TODO: async stuff needs to happen inside static create method
  void _init() {
    _arena = Arena.forLevel('simple');
    _playingClient = PlayingClient()
      ..gameID = 1
      ..clientID = 2;
    final model = PlayerModel(
        id: clientID,
        tilePosition: _arena.players[0],
        health: GameProps.playerTotalHealth,
        angle: 0,
        velocity: Offset.zero);
    final Map<int, PlayerModel> playerMap = {clientID: model};
    final update = ServerUpdate(playerMap, []);
    _serverUpdate$.add(update);
  }

  void dispose() {
    if (!_serverUpdate$.isClosed) _serverUpdate$.close();
  }

  static Future<Client> create(String level, String serverHost) {
    return Future.value(Client(level: level, serverHost: serverHost));
  }
}
