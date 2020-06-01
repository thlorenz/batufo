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
  GameStarted,
  GameOutcome,
}

enum GameOutcomes { Won, Lost, None }

class UserState extends Equatable {
  final UserStates kind;
  final ClientGame game;
  final ServerInfo serverInfo;
  final GameOutcomes gameOutcome;
  final int score;
  const UserState(
    this.kind, {
    this.serverInfo,
    this.game,
    this.gameOutcome = GameOutcomes.None,
    this.score = 0,
  });

  @override
  List<Object> get props => [
        kind,
        serverInfo,
        game?.gameState?.clientID,
        gameOutcome,
        score,
      ];

  @override
  String toString() {
    return 'UserState { kind: $kind }';
  }
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
  }) : super(UserStates.GameStarted, serverInfo: serverInfo, game: game);

  factory UserGameStartedState.from(UserState state) {
    return UserGameStartedState(serverInfo: state.serverInfo, game: state.game);
  }
}

class UserGameOutcomeState extends UserState {
  const UserGameOutcomeState({
    @required ServerInfo serverInfo,
    @required ClientGame game,
    @required GameOutcomes gameOutcome,
    @required int score,
  }) : super(UserStates.GameOutcome,
            serverInfo: serverInfo,
            game: game,
            gameOutcome: gameOutcome,
            score: score);

  factory UserGameOutcomeState.from(
    UserState state,
    GameOutcomes gameOutcome,
    int score,
  ) {
    return UserGameOutcomeState(
        serverInfo: state.serverInfo,
        game: state.game,
        gameOutcome: gameOutcome,
        score: score);
  }
}
