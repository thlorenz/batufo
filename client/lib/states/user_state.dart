import 'package:batufo/game/client_game.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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

  factory UserGameStartedState.from(UserState state) {
    return UserGameStartedState(serverInfo: state.serverInfo, game: state.game);
  }
}
