import 'dart:async';
import 'dart:io';

import 'package:batufo/rpc/client.dart';
import 'package:batufo/client/engine/game_widget.dart';
import 'package:batufo/client/engine/images.dart';
import 'package:batufo/client/game/assets/assets.dart';
import 'package:batufo/client/game/client_game.dart';
import 'package:batufo/client/game/inputs/gestures.dart';
import 'package:batufo/client/widgets/game_over/game_over_widget.dart';
import 'package:batufo/client/widgets/hud/hud_widget.dart';
import 'package:batufo/client/widgets/restart/restart_widget.dart';
import 'package:batufo/rpc/server_update.dart';
import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/models/game_model.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  Log.activateConsole();
  Log.rootLevel = Level.FINEST;

  WidgetsFlutterBinding.ensureInitialized();
  await Images.instance.load([
    assets.floorTiles.imagePath,
    assets.player.imagePath,
    assets.thrust.imagePath,
    assets.wallMetal.imagePath,
    assets.bulletExplosion.imagePath,
    assets.skull.imagePath,
  ]);
  const level = 'large';
  final serverIP = Platform.isAndroid ? '192.168.1.7' : 'localhost';

  runApp(
    RestartWidget(
      child: MyApp(
        level: level,
        serverIP: serverIP,
      ),
    ),
  );
}

final _log = Log<MyApp>();

class MyApp extends StatefulWidget {
  final String level;
  final String serverIP;
  const MyApp({@required this.level, @required this.serverIP}) : super();

  @override
  _MyAppState createState() => _MyAppState(level: level, serverIP: serverIP);
}

class _MyAppState extends State<MyApp> {
  Stream<ServerUpdate> serverUpdate$;
  Arena arena;
  Client client;
  ClientGameState clientGameState;
  int clientID;

  ClientGame game;
  RunningGame gameWidget;
  final String level;
  final String serverIP;

  _MyAppState({@required this.level, @required this.serverIP});

  Future<void> _createClient() async {
    client = await Client.create(level, serverIP);
    arena = client.arena;
    clientGameState = ClientGameState(clientID: client.clientID);
    serverUpdate$ = client.serverUpdate$;
    clientID = client.clientID;
    game = null;
    return client;
  }

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

    if (game == null) {
      game = ClientGame(
        arena: arena,
        gameState: clientGameState,
        clientID: clientID,
      );
      gameWidget = RunningGame(
        game: game,
        newGameRequested: () => _onNewGameRequested(context),
      );
    }
    return gameWidget;
  }

  void _onNewGameRequested(BuildContext context) {
    _disposeGame();
    RestartWidget.restartApp(context);
  }

  Future<void> _startNewGame() async {
    _disposeGame();
    await _createClient();
    // trigger a rebuild in case creating the client completed after last build
    setState(() {});
  }

  void initState() {
    super.initState();
    _log.finer('init state');
  }

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _log.finer('start: did change dependencies');
    await _startNewGame();
    _log.finer('end: did change dependencies');
  }

  Future<void> reassemble() async {
    super.reassemble();
    _log.finer('reassemble');
  }

  void _disposeGame() {
    game?.dispose();
  }
}

class WaitingForPlayers extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(child: Text('Waiting for players'));
  }
}

class RunningGame extends StatelessWidget {
  final ClientGame game;
  final VoidCallback newGameRequested;
  const RunningGame({
    @required this.game,
    @required this.newGameRequested,
  });

  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onPanUpdate: GameGestures.instance.onPanUpdate,
        onTap: GameGestures.instance.onTap,
        child: GameWidget(
          game,
          background: Colors.tealAccent,
        ),
      ),
      StreamBuilder(
        stream: game.gameState.stats$,
        builder: (_, AsyncSnapshot<Stats> snapshot) => snapshot.data.health > 0
            ? HudWidget(stats: snapshot.data)
            : GameOverWidget(newGameRequested: onNewGameRequested, won: false),
        // FIXME: possibly get number of starting players from Level?
        initialData: Stats.initial(2),
      ),
    ]);
  }

  void onNewGameRequested() {
    newGameRequested();
  }
}
