import 'dart:async';

import 'package:batufo/arena/arena.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/client_game.dart';
import 'package:batufo/game/inputs/input_processor.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/client_game_state.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/client.dart';
import 'package:batufo/rpc/client_player_update.dart';
import 'package:batufo/rpc/client_spawned_bullet_update.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';
import 'package:batufo/rpc/server_stats.dart';
import 'package:batufo/setup/config.dart';
import 'package:batufo/states/connection_state.dart';
import 'package:batufo/states/stats_state.dart';
import 'package:batufo/states/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

final _log = Log<Universe>();

class Universe {
  final PlatformType platform;
  final String appTitle;
  final Duration clientPlayerUpdateThrottle;
  final Duration statsThrottle;
  final InputProcessor inputProcessor;
  final SoundController soundController;
  Client client;

  final _userState$ = BehaviorSubject<UserState>();
  final _connectionState$ = BehaviorSubject<ConnectionState>();
  final _statsState$ = BehaviorSubject<StatsState>();
  final _serverStats$ = BehaviorSubject<ServerStats>();
  StreamSubscription<ClientPlayerUpdate> _clientPlayerUpdateSub;
  StreamSubscription<ClientSpawnedBulletUpdate> _clientSpawnedBulletUpdateSub;

  String _currentLevel;

  Universe._({
    @required this.platform,
    @required this.soundController,
    @required String serverHost,
    @required this.appTitle,
    @required this.inputProcessor,
    @required this.clientPlayerUpdateThrottle,
    @required this.statsThrottle,
  }) {
    _userState$.add(initialUserState);
    client = Client(serverHost: serverHost, universe: this);
  }

  UserState get initialUserState => UserRequestingInfoState();
  ConnectionState get initialConnectionState =>
      ConnectionState(ConnectionStates.Initializing);
  ServerStats get initialServerStats => ServerStats.empty();

  Stream<UserState> get userState$ => _userState$.stream.distinct();
  Stream<ConnectionState> get connectionState$ => _connectionState$.distinct();
  Stream<StatsState> get statsState$ =>
      _statsState$.throttleTime(statsThrottle).distinct();
  Stream<ServerStats> get serverStats$ => _serverStats$.stream.distinct();

  static Universe _instance;
  static Universe create({
    @required PlatformType platform,
    @required String appTitle,
    @required String serverHost,
    @required Sound sound,
    Duration clientPlayerUpdateThrottle = const Duration(milliseconds: 100),
    Duration statsThrottle = const Duration(milliseconds: 20),
  }) {
    final soundController = SoundController(sound);
    InputProcessor.create(
      soundController: soundController,
      keyboardRotationFactor: GameProps.keyboardPlayerRotationFactor,
      keyboardThrustForce: GameProps.playerThrustForce,
      timeBetweenThrusts: GameProps.timeBetweenThrustsMs,
      timeBetweenBullets: GameProps.timeBetweenBulletsMs,
    );
    return _instance = Universe._(
      appTitle: appTitle,
      soundController: soundController,
      serverHost: serverHost,
      inputProcessor: InputProcessor.instance,
      clientPlayerUpdateThrottle: clientPlayerUpdateThrottle,
      statsThrottle: statsThrottle,
      platform: platform,
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
      soundController: soundController,
      inputProcessor: inputProcessor,
      enableRecording: platform != PlatformType.Web,
      clientID: clientID,
      playerIndex: playerIndex,
      onGameStateUpdated: _onGameStateUpdated,
      onScored: _onScored,
      parallaxProps: ParallaxProps.forPlatForm(platform),
    );
    _addStatsState(StatsState.initial(arena.players.length));
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
    _currentLevel = level;
    _addStatsState(StatsState.empty);
    client.requestPlay(level);
  }

  void userPlayOtherLevel() {
    _disposeCurrentGame();
    final state = UserSelectingLevelState(_userState$.value?.serverInfo);
    _addUserState(state);
    _log.info('playing other level', _userState$.value);
  }

  void userReplayLevel() {
    assert(_currentLevel != null, 'cannot replay level if none was selected');
    _disposeCurrentGame();
    final stateForNow = UserSelectingLevelState(_userState$.value?.serverInfo);
    _addUserState(stateForNow);
    _log.info('replaying level', _userState$.value);
    userSelectedLevel(_currentLevel);
  }

  void _addUserState(UserState state) {
    if (state != _userState$.value) _log.fine('user: ${state.kind}');
    _userState$.add(state);
  }

  void _addStatsState(StatsState state) {
    if (state != _statsState$.value) _log.finest('stats: $state');
    _statsState$.add(state);
  }

  void _addServerStats(ServerStats stats) {
    if (stats != _serverStats$.value) _log.fine('serverStats: $stats');
    _serverStats$.add(stats);
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

  void _onGameStateUpdated(ClientGameState gameState) {
    final game = _userState$.value?.game;
    if (game == null || game.finished || game.disposed) return;

    final hero = gameState.hero;
    assert(hero != null, 'could not find hero player');
    final stats = _statsState$.value.copyWith(
      health: hero.health,
      totalPlayers: gameState.totalPlayers,
      playersAlive: gameState.playersAlive,
      percentReadyToShoot: inputProcessor.percentReadyToShoot,
      percentReadyToThrust: inputProcessor.percentReadyToThrust,
    );
    _addStatsState(stats);
    _detectGameOutcome(gameState, hero.health);
  }

  void _detectGameOutcome(ClientGameState gameState, double heroHealth) {
    final game = _userState$.value?.game;
    if (game == null || game.finished || game.disposed) return;

    if (heroHealth <= 0) {
      game?.finish();
      final state = UserGameOutcomeState.from(
        _userState$.value,
        GameOutcomes.Lost,
        _statsState$.value?.score ?? 0,
      );
      _addUserState(state);
      return;
    }
    // Single player games only end when hero dies at this point
    if (gameState.totalPlayers == 1) return;

    if (gameState.playersAlive == 1) {
      game?.finish();
      final state = UserGameOutcomeState.from(
        _userState$.value,
        GameOutcomes.Won,
        _statsState$.value?.score ?? 0,
      );
      _addUserState(state);
      return;
    }
  }

  void _onScored(int score) {
    final current = _statsState$.value;
    final stats = current.copyWith(score: current.score + score);
    _addStatsState(stats);
  }

  void receivedClientPlayerUpdate(ClientPlayerUpdate clientPlayerUpdate) {
    final game = _userState$.value.game;
    if (game == null) return;
    game.updatePlayers(clientPlayerUpdate.player);
  }

  void receivedSpawnedBulletUpdate(ClientSpawnedBulletUpdate update) {
    final game = _userState$.value.game;
    if (game == null) return;
    game.updateBullets(update);
  }

  void receivedPlayerJoined(int clientID, int playerIndex) {
    final game = _userState$.value.game;
    if (game == null) return;
    if (game.hasPlayer(clientID)) return;

    final initialPosition = game.arena.players[playerIndex];
    assert(
      initialPosition != null,
      'no player in arena for index $playerIndex',
    );
    final playerModel = PlayerModel.forInitialPosition(
      clientID,
      initialPosition,
      GameProps.playerTotalHealth,
    );
    game.updatePlayers(playerModel);
    _refreshAlivePlayers(game);
  }

  void receivedPlayerDeparted(int clientID) {
    final game = _userState$.value.game;
    if (game == null) return;
    game.removePlayer(clientID);
    _refreshAlivePlayers(game);
  }

  void receivedServerStatsUpdate(ServerStatsUpdate update) {
    final stats = ServerStats.fromServerStatsUpdate(update);
    _addServerStats(stats);
  }

  void _refreshAlivePlayers(ClientGame game) {
    final current = _statsState$.value;
    assert(current != null, 'should have some stats by now');
    final stats = current.copyWith(playersAlive: game.gameState.playersAlive);
    _addStatsState(stats);
  }

  bool get involvedInGame =>
      _userState$.value?.game != null && !_userState$.value.game.disposed;

  void _disposeCurrentGame() {
    client.requestLeave();
    _userState$.value?.game?.dispose();
    _disposeClientUpdateSubs();
  }

  void _disposeClientUpdateSubs() {
    _clientPlayerUpdateSub?.cancel();
    _clientSpawnedBulletUpdateSub?.cancel();
  }

  void dispose() {
    _disposeCurrentGame();
    if (!_userState$.isClosed) _userState$.close();
    if (!_statsState$.isClosed) _statsState$.close();
    if (!_serverStats$.isClosed) _serverStats$.close();
  }
}
