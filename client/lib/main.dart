import 'dart:async';
import 'dart:io';

import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/images.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/game/game_created_widget.dart';
import 'package:batufo/widgets/game/game_running_widget.dart';
import 'package:batufo/widgets/game/menu_widget.dart';
import 'package:flutter/material.dart';

const PORT = 2222;
const LOCALHOST = 'http://localhost:$PORT';
const LOCALBOX = 'http://192.168.1.7:$PORT';

Future<void> main() async {
  Log.activateConsole();
  Log.rootLevel = Level.FINE;
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
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    serverIP = LOCALHOST;
  }

  final universe = Universe.create(
    serverHost: serverIP,
    clientPlayerUpdateThrottle: Duration(seconds: 2),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: UniverseWidget(
        universe: universe,
      ),
    ),
  ));

  universe.clientRequestInfo();
}

class UniverseWidget extends StatelessWidget {
  final Universe universe;

  const UniverseWidget({
    @required this.universe,
  }) : super();

  Widget build(BuildContext context) {
    return Scaffold(body: _selectWidget(context));
  }

  Widget _selectWidget(BuildContext context) {
    return StreamBuilder(
      initialData: universe.initialUserState,
      builder: (BuildContext context, AsyncSnapshot<UserState> snapshot) {
        if (!snapshot.hasData ||
            snapshot.data.kind == UserStates.RequestingInfo) {
          return Container(child: Text('Connecting ...'));
        } else if (snapshot.data.kind == UserStates.SelectingLevel) {
          final serverInfo = snapshot.data.serverInfo;
          assert(serverInfo != null, 'cannot select level without server info');
          return MenuWidget(
            universe: universe,
            levels: serverInfo.levels,
          );
        } else if (snapshot.data.kind == UserStates.GameCreated) {
          return GameCreatedWidget(game: snapshot.data.game);
        } else if (snapshot.data.kind == UserStates.GameStarted) {
          return GameRunningWidget(game: snapshot.data.game);
        }
        return null;
      },
      stream: universe.userState$,
    );
  }
}
