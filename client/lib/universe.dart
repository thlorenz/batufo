import 'dart:async';

import 'package:batufo/arena/arena.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/client_game.dart';
import 'package:batufo/rpc/client.dart';
import 'package:batufo/rpc/client_player_update.dart';
import 'package:batufo/rpc/client_spawned_bullet_update.dart';
import 'package:batufo/states/connection_state.dart';
import 'package:batufo/states/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

final _log = Log<Universe>();

class Universe {
  final _userState$ = BehaviorSubject<UserState>();
  final _connectionState$ = BehaviorSubject<ConnectionState>();
  final Duration clientPlayerUpdateThrottle;
  Client client;
  StreamSubscription<ClientPlayerUpdate> _clientPlayerUpdateSub;
  StreamSubscription<ClientSpawnedBulletUpdate> _clientSpawnedBulletUpdateSub;

  Universe._({
    @required String serverHost,
    @required this.clientPlayerUpdateThrottle,
  }) {
    _userState$.add(initialUserState);
    client = Client(serverHost: serverHost, universe: this);
  }

  UserState get initialUserState => UserRequestingInfoState();
  ConnectionState get initialConnectionState =>
      ConnectionState(ConnectionStates.Initializing);
  Stream<UserState> get userState$ => _userState$.stream;
  Stream<ConnectionState> get connectionState$ => _connectionState$;

  static Universe _instance;
  static Universe create({
    @required String serverHost,
    Duration clientPlayerUpdateThrottle = const Duration(milliseconds: 100),
    Duration clientSpawnedBulletUpdateThrottle = Duration.zero,
  }) {
    return _instance = Universe._(
      serverHost: serverHost,
      clientPlayerUpdateThrottle: clientPlayerUpdateThrottle,
    );
  }

  static Universe get instance {
    return _instance;
  }

  void clientConnected() {
    _connectionState$.add(ConnectionState(ConnectionStates.Connected));
  }

  void clientDisconnected(String reason) {
    _connectionState$.add(ConnectionState(
      ConnectionStates.Disconnected,
      reason: reason,
    ));
  }

  void clientReceivedInfo(ServerInfo info) {
    final state = UserSelectingLevelState(info);
    _addUserState(state);
  }

  void clientCreatedGame(
    int clientID,
    int playerIndex,
    Arena arena,
  ) {
    WorldPosition.tileSize = arena.tileSize.toDouble();
    final game = ClientGame(
      arena: arena,
      clientID: clientID,
      playerIndex: playerIndex,
    );
    final state = UserGameCreatedState.from(_userState$.value, game);
    _addUserState(state);
  }

  void clientRequestInfo() {
    client.requestInfo();
  }

  void clientStartedGame() {
    final state = UserGameStartedState.from(_userState$.value);
    state.game.start();
    _addUserState(state);
    _subscribeClientUpdates(state.game);
  }

  void userSelectedLevel(String level) {
    client.requestPlay(level);
  }

  void _addUserState(UserState state) {
    _log.fine('${state.kind}');
    _userState$.add(state);
  }

  void _subscribeClientUpdates(ClientGame game) {
    _disposeClientUpdateSubs();

    _clientPlayerUpdateSub = game.clientPlayerUpdate$
        .throttleTime(clientPlayerUpdateThrottle)
        .listen(_onClientPlayerUpdate);

    _clientSpawnedBulletUpdateSub =
        game.clientSpawnedBulletUpdate$.listen(_onClientSpawnedBulletUpdate);
  }

  void _onClientPlayerUpdate(ClientPlayerUpdate update) {
    client.sendClientPlayerUpdate(update);
  }

  void _onClientSpawnedBulletUpdate(ClientSpawnedBulletUpdate update) {
    client.sendClientSpawnedBulletUpdate(update);
  }

  void _disposeClientUpdateSubs() {
    _clientPlayerUpdateSub?.cancel();
    _clientSpawnedBulletUpdateSub?.cancel();
  }

  void dispose() {
    if (!_userState$.isClosed) _userState$.close();
    _disposeClientUpdateSubs();
  }

  void receivedClientPlayerUpdate(ClientPlayerUpdate clientPlayerUpdate) {
    final game = _userState$.value.game;
    game.updatePlayers(clientPlayerUpdate);
  }

  void receivedSpawnedBulletUpdate(ClientSpawnedBulletUpdate update) {
    final game = _userState$.value.game;
    game.updateBullets(update);
  }
}
