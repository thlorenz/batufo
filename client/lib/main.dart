import 'dart:async';
import 'dart:io';

import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/images.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/game/game_created_widget.dart';
import 'package:batufo/widgets/game/menu_widget.dart';
import 'package:flutter/material.dart';

const PORT = 2222;

Future<void> main() async {
  Log.activateConsole();
  Log.rootLevel = Level.FINE;
  Log.messageFilter = (String s) => !s.contains('socket_io_client:engine');

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

  final universe = Universe.instance;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: UniverseWidget(
        serverIP: serverIP,
        universe: universe,
      ),
    ),
  ));
}

class UniverseWidget extends StatelessWidget {
  final String serverIP;
  final Universe universe;

  const UniverseWidget({
    @required this.serverIP,
    @required this.universe,
  }) : super();

  Widget build(BuildContext context) {
    return Scaffold(body: _selectWidget(context));
  }

  Widget _selectWidget(BuildContext context) {
    return StreamBuilder(
      initialData: universe.initalState,
      builder: (BuildContext context, AsyncSnapshot<UniverseState> snapshot) {
        if (!snapshot.hasData ||
            snapshot.data.kind == StateOfTheUniverse.SelectingLevel) {
          return MenuWidget(
            serverIP: serverIP,
            universe: universe,
          );
        } else if (snapshot.data.kind == StateOfTheUniverse.GameCreated) {
          return GameCreatedWidget();
        }
        return null;
      },
      stream: universe.state$,
    );
  }
}
