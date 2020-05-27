import 'package:batufo/arena/arena.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';
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
  final PlayingClient playingClient;
  final Arena arena;
  final String level;
  const UniverseState(this.kind, {this.playingClient, this.arena, this.level});

  @override
  List<Object> get props => [kind, playingClient, arena, level];
}

class SelectingLevelState extends UniverseState {
  const SelectingLevelState() : super(StateOfTheUniverse.SelectingLevel);
}

class GameCreatedState extends UniverseState {
  const GameCreatedState({
    @required PlayingClient playingClient,
    @required Arena arena,
    @required String level,
  }) : super(
          StateOfTheUniverse.GameCreated,
          playingClient: playingClient,
          arena: arena,
          level: level,
        );
}

class GameRunningState extends UniverseState {
  const GameRunningState({
    @required PlayingClient playingClient,
    @required Arena arena,
    @required String level,
  }) : super(
          StateOfTheUniverse.GameRunning,
          playingClient: playingClient,
          arena: arena,
          level: level,
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

  void handleGameCreated(
    String level,
    PlayingClient playingClient,
    Arena arena,
  ) {
    final state = GameCreatedState(
      playingClient: playingClient,
      arena: arena,
      level: level,
    );
    _state$.add(state);
  }

  void dispose() {
    if (!_state$.isClosed) _state$.close();
  }
}
