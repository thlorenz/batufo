import 'package:batufo/arena/arena.dart';
import 'package:batufo/game/client_game.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

enum UserStates {
  SelectingLevel,
  GameCreated,
  GameRunning,
}

class UserState extends Equatable {
  final UserStates kind;
  final String level;
  final ClientGame game;
  const UserState(this.kind, {this.level, this.game});

  @override
  List<Object> get props => [kind, level, game?.gameState?.clientID];
}

class UserSelectingLevelState extends UserState {
  const UserSelectingLevelState() : super(UserStates.SelectingLevel);
}

class UserGameCreatedState extends UserState {
  const UserGameCreatedState({
    @required String level,
    @required ClientGame game,
  }) : super(UserStates.GameCreated, level: level, game: game);
}

class UserGameRunningState extends UserState {
  const UserGameRunningState({
    @required String level,
    @required ClientGame game,
  }) : super(
          UserStates.GameRunning,
          level: level,
          game: game,
        );
}

class Universe {
  final _userState$ = BehaviorSubject<UserState>();
  Universe._() {
    _userState$.add(initialUserState);
  }

  UserState get initialUserState => UserSelectingLevelState();
  Stream<UserState> get userState$ => _userState$.stream;

  static final Universe _instance = Universe._();
  static Universe get instance {
    return _instance;
  }

  void handleGameCreated(
    String level,
    int clientID,
    int playerIndex,
    Arena arena,
  ) {
    final game = ClientGame(
      arena: arena,
      clientID: clientID,
      playerIndex: playerIndex,
    );
    final state = UserGameCreatedState(level: level, game: game);
    _userState$.add(state);
  }

  void dispose() {
    if (!_userState$.isClosed) _userState$.close();
  }
}
