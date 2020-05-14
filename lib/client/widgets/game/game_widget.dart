import 'package:batufo/client/game/client_game.dart';
import 'package:batufo/client/widgets/game/running_game_widget.dart';
import 'package:batufo/client/widgets/game/waiting_widget.dart';
import 'package:batufo/client/widgets/restart/restart_widget.dart';
import 'package:batufo/rpc/client.dart';
import 'package:batufo/rpc/server_update.dart';
import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/models/game_model.dart';
import 'package:flutter/material.dart';

final _log = Log<GameWidget>();

class GameWidget extends StatefulWidget {
  final String level;
  final String serverIP;
  const GameWidget({@required this.level, @required this.serverIP}) : super();

  @override
  _GameWidgetState createState() =>
      _GameWidgetState(level: level, serverIP: serverIP);
}

class _GameWidgetState extends State<GameWidget> {
  Stream<ServerUpdate> serverUpdate$;
  Arena arena;
  Client client;
  ClientGameState clientGameState;
  int clientID;

  ClientGame game;
  RunningGame gameWidget;
  final String level;
  final String serverIP;

  _GameWidgetState({@required this.level, @required this.serverIP});

  Widget build(BuildContext context) {
    _log.finer('build');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<ServerUpdate>(
          builder: _build,
          stream: serverUpdate$,
          initialData: null,
        ),
      ),
    );
  }

  Widget _build(BuildContext context, AsyncSnapshot<ServerUpdate> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      _log.finer('disconnected, hot restart app to reconnect ...');
    }
    if (snapshot.hasError) {
      _log.warning('snapshot error: ${snapshot.error}');
    }
    _log.info('snapshot: ${snapshot.data.toString()}');
    if (snapshot.data == null) return WaitingForPlayers();

    clientGameState.sync(snapshot.data);
    game.init();

    return gameWidget;
  }

  void _onNewGameRequested(BuildContext context) {
    _disposeGame();
    RestartWidget.restartApp(context);
  }

  Future<void> _createClient() async {
    client = await Client.create(level, serverIP);
    arena = client.arena;
    clientGameState = ClientGameState(clientID: client.clientID);
    serverUpdate$ = client.serverUpdate$;
    clientID = client.clientID;
    return client;
  }

  Future<void> _startNewGame() async {
    _disposeGame();
    await _createClient();

    game = ClientGame(
      arena: arena,
      gameState: clientGameState,
      clientID: clientID,
    );

    gameWidget = RunningGame(
      game: game,
      newGameRequested: () => _onNewGameRequested(context),
      numberOfPlayers: arena.players.length,
    );
    setState(() {});
  }

  void initState() {
    super.initState();
    _log.finer('init state');
  }

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _log.finer('did change dependencies');
    await _startNewGame();
  }

  Future<void> reassemble() async {
    super.reassemble();
    _log.finer('reassemble');
  }

  void _disposeGame() {
    game?.dispose();
  }
}
