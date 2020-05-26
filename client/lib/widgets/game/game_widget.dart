import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/game/client_game.dart';
import 'package:batufo/models/game_model.dart';
import 'package:batufo/rpc/client.dart';
import 'package:batufo/rpc/server_update.dart';
import 'package:batufo/widgets/game/running_game_widget.dart';
import 'package:batufo/widgets/game/waiting_widget.dart';
import 'package:batufo/widgets/restart/restart_widget.dart';
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
  final String level;
  final String serverIP;

  Stream<ServerUpdate> serverUpdate$;
  Client client;
  ClientGameState clientGameState;
  ClientGame game;
  RunningGame gameWidget;

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
    // TODO: see if we can call game.init in _startNewGame
    // but how do we work around the server update thingy?
    // Possibly have another branch to render the game without the
    // server update?
    // game.init(clientGameState);

    return gameWidget;
  }

  void _onNewGameRequested(BuildContext context) {
    _disposeGame();
    RestartWidget.restartApp(context);
  }

  Future<Client> _createClient() async {
    // TODO: figure out a way to show game
    client = await Client.create(level, serverIP);
    clientGameState = ClientGameState(clientID: client.clientID);
    serverUpdate$ = client.serverUpdate$;
    return client;
  }

  Future<void> _startNewGame() async {
    _disposeGame();
    final client = await _createClient();

    game = ClientGame(
      arena: client.arena,
      clientID: client.clientID,
    );

    gameWidget = RunningGame(
      game: game,
      newGameRequested: () => _onNewGameRequested(context),
      numberOfPlayers: client.arena.players.length,
    );
    setState(() {});
  }

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _log.finer('did change dependencies');
    await _startNewGame();
  }

  void _disposeGame() {
    game?.dispose();
  }
}
