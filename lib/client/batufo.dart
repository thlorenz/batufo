import 'dart:io';

import 'package:batufo/client/engine/game_widget.dart';
import 'package:batufo/client/engine/images.dart';
import 'package:batufo/client/game/assets/assets.dart';
import 'package:batufo/client/game/client_game.dart';
import 'package:batufo/client/game/inputs/gestures.dart';
import 'package:batufo/client/rpc/client.dart';
import 'package:batufo/server/game/game_state.dart';
import 'package:batufo/shared/engine/world_position.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart'
    show GameStateEvent;
import 'package:batufo/shared/models/create_model.dart';
import 'package:batufo/shared/models/game_model.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Images.instance.load([
    assets.floorTiles.imagePath,
    assets.player.imagePath,
    assets.thrust.imagePath,
    assets.wallMetal.imagePath,
    assets.bulletExplosion.imagePath,
  ]);
  const level = 'simple';
  final serverIP = Platform.isAndroid ? '192.168.1.7' : 'localhost';
  final client = await Client.create(level, serverIP);

  WorldPosition.tileSize = GameProps.tileSize;
  final gameModel = createModel(client.arena, client.clientID);
  runApp(MyApp(
    gameModel: gameModel,
    gameStateEvent$: client.gameStateEvent$,
  ));
}

class MyApp extends StatefulWidget {
  final Stream<GameStateEvent> gameStateEvent$;
  final GameModel gameModel;

  const MyApp({this.gameStateEvent$, this.gameModel}) : super();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ClientGame game;
  RunningGame gameWidget;

  GameModel get gameModel => widget.gameModel;

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: StreamBuilder<GameStateEvent>(
          builder: _build,
          stream: widget.gameStateEvent$,
          initialData: null,
        )));
  }

  Widget _build(BuildContext context, AsyncSnapshot<GameStateEvent> snapshot) {
    if (snapshot.data == null) return WaitingForPlayers();
    final gameState = GameState.unpack(snapshot.data.gameState);
    if (game == null) {
      gameModel.updatePlayers(gameState.players);
      game = ClientGame(widget.gameModel);
      gameWidget = RunningGame(game: game);
    } else {
      gameModel.updatePlayers(gameState.players);
    }
    return gameWidget;
  }
}

class WaitingForPlayers extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(child: Text('Waiting for players'));
  }
}

class RunningGame extends StatelessWidget {
  final ClientGame game;
  const RunningGame({@required this.game});

  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onPanUpdate: GameGestures.instance.onPanUpdate,
        child: GameWidget(
          game,
          background: Colors.tealAccent,
        ),
      ),
      /*
          StreamBuilder(
            stream: gameModel.stats.update$,
            builder: (_, AsyncSnapshot<StatsModel> snapshot) =>
                HudWidget(model: snapshot.data),
            initialData: gameModel.stats,
          )
           */
    ]);
  }
}
