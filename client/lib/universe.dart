import 'package:batufo/arena/arena.dart';
import 'package:batufo/game/client_game.dart';
import 'package:batufo/rpc/client.dart';
import 'package:batufo/states/connection_state.dart';
import 'package:batufo/states/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class Universe {
  final _userState$ = BehaviorSubject<UserState>();
  final _connectionState$ = BehaviorSubject<ConnectionState>();
  Client client;

  Universe._({@required String serverHost}) {
    _userState$.add(initialUserState);
    client = Client(serverHost: serverHost, universe: this);
  }

  UserState get initialUserState => UserRequestingInfoState();
  ConnectionState get initialConnectionState =>
      ConnectionState(ConnectionStates.Initializing);
  Stream<UserState> get userState$ => _userState$.stream;
  Stream<ConnectionState> get connectionState$ => _connectionState$;

  static Universe _instance;
  static Universe create({@required String serverHost}) {
    return _instance = Universe._(serverHost: serverHost);
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
    _userState$.add(state);
  }

  void clientCreatedGame(
    int clientID,
    int playerIndex,
    Arena arena,
  ) {
    final game = ClientGame(
      arena: arena,
      clientID: clientID,
      playerIndex: playerIndex,
    );
    final state = UserGameCreatedState.from(_userState$.value, game);
    _userState$.add(state);
  }

  void clientRequestInfo() {
    client.requestInfo();
  }

  void clientStartedGame() {
    final state = UserGameStartedState.from(_userState$.value);
    // TODO: need to send player info from server
    // to compose ClientGameState and pass it in here
    state.game.start();
    _userState$.add(state);
  }

  void userSelectedLevel(String level) {
    client.requestPlay(level);
  }

  void dispose() {
    if (!_userState$.isClosed) _userState$.close();
  }
}
