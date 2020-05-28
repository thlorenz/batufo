import 'package:batufo/arena/arena.dart';
import 'package:batufo/game/client_game.dart';
import 'package:batufo/rpc/client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class ServerInfo extends Equatable {
  final List<LevelInfo> levels;
  const ServerInfo({@required this.levels});

  @override
  List<Object> get props => [levels];
}

class LevelInfo extends Equatable {
  final String name;
  final int nplayers;
  const LevelInfo(this.name, this.nplayers);

  @override
  List<Object> get props => [name, nplayers];
}

enum UserStates {
  RequestingInfo,
  SelectingLevel,
  GameCreated,
  GameRunning,
}

class UserState extends Equatable {
  final UserStates kind;
  final ClientGame game;
  final ServerInfo serverInfo;
  const UserState(this.kind, {this.serverInfo, this.game});

  @override
  List<Object> get props => [kind, serverInfo, game?.gameState?.clientID];
}

class UserRequestingInfoState extends UserState {
  const UserRequestingInfoState() : super(UserStates.RequestingInfo);
}

class UserSelectingLevelState extends UserState {
  const UserSelectingLevelState(ServerInfo serverInfo)
      : super(UserStates.SelectingLevel, serverInfo: serverInfo);
}

class UserGameCreatedState extends UserState {
  const UserGameCreatedState({
    @required ServerInfo serverInfo,
    @required ClientGame game,
  }) : super(UserStates.GameCreated, serverInfo: serverInfo, game: game);

  factory UserGameCreatedState.from(UserState state, ClientGame game) {
    return UserGameCreatedState(serverInfo: state.serverInfo, game: game);
  }
}

class UserGameStartedState extends UserState {
  const UserGameStartedState({
    @required ServerInfo serverInfo,
    @required ClientGame game,
  }) : super(UserStates.GameRunning, serverInfo: serverInfo, game: game);

  factory UserGameStartedState.from(UserState state, ClientGame game) {
    return UserGameStartedState(serverInfo: state.serverInfo, game: game);
  }
}

enum ConnectionStates { Initializing, Connected, Disconnected }

class ConnectionState extends Equatable {
  final ConnectionStates kind;
  final String reason;
  const ConnectionState(this.kind, {this.reason});

  @override
  List<Object> get props => [kind, reason];
}

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

  void userSelectedLevel(String level) {
    client.requestPlay(level);
  }

  void dispose() {
    if (!_userState$.isClosed) _userState$.close();
  }
}
