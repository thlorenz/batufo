import 'package:batufo/arena/arena.dart';
import 'package:batufo/game/client_game.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

enum StateOfTheUniverse {
  SelectingLevel,
  GameCreated,
  GameRunning,
}

class UniverseState extends Equatable {
  final StateOfTheUniverse kind;
  final String level;
  final ClientGame game;
  const UniverseState(this.kind, {this.level, this.game});

  @override
  List<Object> get props => [kind, level, game?.gameState?.clientID];
}

class SelectingLevelState extends UniverseState {
  const SelectingLevelState() : super(StateOfTheUniverse.SelectingLevel);
}

class GameCreatedState extends UniverseState {
  const GameCreatedState({
    @required String level,
    @required ClientGame game,
  }) : super(StateOfTheUniverse.GameCreated, level: level, game: game);
}

class GameRunningState extends UniverseState {
  const GameRunningState({
    @required String level,
    @required ClientGame game,
  }) : super(
          StateOfTheUniverse.GameRunning,
          level: level,
          game: game,
        );
}

class Universe {
  final _state$ = BehaviorSubject<UniverseState>();
  Universe._() {
    _state$.add(initalState);
  }

  UniverseState get initalState => SelectingLevelState();
  Stream<UniverseState> get state$ => _state$.stream;

  static final Universe _instance = Universe._();
  static Universe get instance {
    return _instance;
  }

  void handleGameCreated(String level, int clientID, Arena arena) {
    final game = ClientGame(arena: arena, clientID: clientID);
    final state = GameCreatedState(level: level, game: game);
    _state$.add(state);
  }

  void dispose() {
    if (!_state$.isClosed) _state$.close();
  }
}
