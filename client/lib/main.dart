import 'dart:async';
import 'dart:io';

import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/images.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/rpc/server_stats.dart';
import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/game/game_created_widget.dart';
import 'package:batufo/widgets/game/game_outcome_widget.dart';
import 'package:batufo/widgets/game/game_running_widget.dart';
import 'package:batufo/widgets/game/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const PORT = 2222;
const LOCALHOST = 'http://localhost:$PORT';
const LOCALBOX = 'http://192.168.1.7:$PORT';

Future<void> main() async {
  Log.activateConsole();
  Log.rootLevel = Level.FINER;
  Log.loggerFilter = (String s) => !s.contains('socket_io');

  WidgetsFlutterBinding.ensureInitialized();

  await Images.instance.load([
    assets.floorTiles.imagePath,
    assets.player.imagePath,
    assets.thrust.imagePath,
    assets.wallMetal.imagePath,
    assets.bulletExplosion.imagePath,
    assets.skull.imagePath,
  ]);
  String serverIP;
  try {
    serverIP = Platform.isAndroid ? LOCALBOX : LOCALHOST;
    // only do the below if the above didn't throw as the below basically
    // stops the browser in its tracks (not just throwing)
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    serverIP = LOCALHOST;
  }

  final universe = Universe.create(
    serverHost: serverIP,
    clientPlayerUpdateThrottle: Duration(milliseconds: 100),
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: UniverseWidget(universe: universe),
        ),
      )));

  universe.clientRequestInfo();
}

final _log = Log<UniverseWidget>();

class UniverseWidget extends StatelessWidget {
  final Universe universe;

  const UniverseWidget({
    @required this.universe,
  }) : super();

  Widget build(BuildContext context) {
    return _selectWidget(context);
  }

  Widget _selectWidget(BuildContext context) {
    return StreamBuilder<UserState>(
      initialData: universe.initialUserState,
      builder: (context, snapshot) {
        _log.fine('building ${snapshot.data?.kind}');

        if (!snapshot.hasData ||
            snapshot.data.kind == UserStates.RequestingInfo) {
          return Container(child: Text('Connecting ...'));
        }
        if (snapshot.data.kind == UserStates.SelectingLevel) {
          final serverInfo = snapshot.data.serverInfo;
          assert(serverInfo != null, 'cannot select level without server info');
          return _menuWidget(context, serverInfo.levels);
        }
        if (snapshot.data.kind == UserStates.GameCreated) {
          return GameCreatedWidget(game: snapshot.data.game);
        }
        if (snapshot.data.kind == UserStates.GameStarted) {
          return GameRunningWidget(
              universe: universe, game: snapshot.data.game);
        }
        if (snapshot.data.kind == UserStates.GameOutcome) {
          return GameOutcomeWidget(
            universe: universe,
            game: snapshot.data.game,
            gameOutcome: snapshot.data.gameOutcome,
            score: snapshot.data.score,
          );
        }
        return null;
      },
      stream: universe.userState$,
    );
  }

  Widget _menuWidget(BuildContext context, List<LevelInfo> levels) {
    return StreamBuilder<ServerStats>(
      stream: universe.serverStats$,
      initialData: universe.initialServerStats,
      builder: (context, snapshot) {
        return MenuWidget(
          universe: universe,
          levels: levels,
          serverStats: snapshot.data,
        );
      },
    );
  }
}
