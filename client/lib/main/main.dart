import 'dart:async';

import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/images.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/rpc/server_stats.dart';
import 'package:batufo/setup/config.dart';
import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/game/game_created_widget.dart';
import 'package:batufo/widgets/game/game_outcome_widget.dart';
import 'package:batufo/widgets/game/game_running_widget.dart';
import 'package:batufo/widgets/game/menu_widget.dart';
import 'package:flutter/material.dart';

Future<void> mainEntry({
  @required String serverIP,
  @required Config config,
  @required Sound sound,
  Level logLevel = Level.FINE,
}) async {
  Log.activateConsole();
  Log.rootLevel = logLevel;
  Log.loggerFilter = (String s) => !s.contains('socket_io');

  await Images.instance.load([
    assets.floorTiles.imagePath,
    assets.planets.imagePath,
    assets.player.imagePath,
    assets.thrust.imagePath,
    assets.wallMetal.imagePath,
    assets.bulletExplosion.imagePath,
    assets.skull.imagePath,
  ]);

  final universe = Universe.create(
    platform: config.platform,
    appTitle: config.title,
    serverHost: serverIP,
    sound: sound,
    clientPlayerUpdateThrottle: Duration(milliseconds: 100),
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: config.title,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: UniverseWidget(universe: universe),
        ),
      )));

  _log.info('Connecting to $serverIP');
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

        if (!snapshot.hasData) {
          return Container(child: Text('Connecting ...'));
        }

        switch (snapshot.data.kind) {
          case UserStates.RequestingInfo:
            return Container(child: Text('Connecting ...'));
          case UserStates.SelectingLevel:
            {
              final serverInfo = snapshot.data.serverInfo;
              assert(serverInfo != null,
                  'cannot select level without server info');
              return _menuWidget(context, serverInfo.levels);
            }
          case UserStates.GameCreated:
            return GameCreatedWidget(
                universe: universe, game: snapshot.data.game);
          case UserStates.GameStarted:
            return GameRunningWidget(
                universe: universe, game: snapshot.data.game);
          case UserStates.GameOutcome:
            return GameOutcomeWidget(
              universe: universe,
              game: snapshot.data.game,
              gameOutcome: snapshot.data.gameOutcome,
              score: snapshot.data.score,
            );
          default:
            return null;
        }
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
