import 'dart:async';
import 'dart:io';

import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/images.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/game/game_created_widget.dart';
import 'package:batufo/widgets/game/game_running_widget.dart';
import 'package:batufo/widgets/game/menu_widget.dart';
import 'package:flutter/material.dart';

const PORT = 2222;

Future<void> main() async {
  Log.activateConsole();
  Log.rootLevel = Level.FINE;
  Log.loggerFilter = (String s) => !s.contains('socket_io');

  WorldPosition.tileSize = GameProps.tileSize;
  WidgetsFlutterBinding.ensureInitialized();
  await Images.instance.load([
    assets.floorTiles.imagePath,
    assets.player.imagePath,
    assets.thrust.imagePath,
    assets.wallMetal.imagePath,
    assets.bulletExplosion.imagePath,
    assets.skull.imagePath,
  ]);
  final serverIP = Platform.isAndroid
      ? 'http://192.168.1.7:$PORT'
      : 'http://localhost:$PORT';

  final universe = Universe.create(serverHost: serverIP);
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
        } else if (snapshot.data.kind == UserStates.GameRunning) {
          return GameRunningWidget(game: snapshot.data.game);
        }
        return null;
      },
      stream: universe.userState$,
    );
  }
}
