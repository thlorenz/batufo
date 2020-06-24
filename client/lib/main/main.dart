import 'dart:async';

import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/engine/images.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/generated_batufo_version.dart';
import 'package:batufo/setup/config.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/screens/router.dart';
import 'package:flutter/material.dart';

final _log = Log();

Future<void> mainEntry({
  @required String serverIP,
  @required Config config,
  @required Sound sound,
  Level logLevel = Level.FINE,
}) async {
  Log.activateConsole();
  Log.rootLevel = logLevel;
  Log.loggerFilter = (String s) => !s.contains('socket_io');

  _log.info('batufo version $BATUFO_VERSION');

  await Images.instance.load([
    assets.floorTiles.imagePath,
    assets.planets.imagePath,
    assets.player.imagePath,
    assets.thrust.imagePath,
    assets.wallMetal.imagePath,
    assets.bulletExplosion.imagePath,
    assets.skull.imagePath,
    assets.medkit.imagePath,
    assets.shield.imagePath,
    assets.bomb.imagePath,
    assets.circleRed.imagePath,
  ]);

  sound.disableLog();

  final universe = Universe.create(
    platform: config.platform,
    appTitle: config.title,
    serverHost: serverIP,
    sound: sound,
    clientPlayerUpdateThrottle: Duration(milliseconds: 100),
  );
  final router = Router(universe: universe);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: config.title,
      onGenerateRoute: router.generateRoute,
      initialRoute: Routes.HOME,
    ),
  );

  _log.info('Connecting to $serverIP');
  universe.clientRequestInfo();
}
