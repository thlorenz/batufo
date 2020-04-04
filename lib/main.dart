import 'dart:io';

import 'package:batufo/engine/ui/game_widget.dart';
import 'package:batufo/engine/ui/images.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/ui/batufo_game.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/grpc/client.dart';
import 'package:batufo/grpc/message_types/game_state_event.dart';
import 'package:batufo/inputs/gestures.dart';
import 'package:batufo/models/create_model.dart';
import 'package:batufo/models/game_model.dart';
import 'package:flutter/material.dart';

import 'generated/message_bus.pb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Images.instance.load([
    GameProps.assets.floorTiles.imagePath,
    GameProps.assets.player.imagePath,
    GameProps.assets.thrust.imagePath,
    GameProps.assets.wallMetal.imagePath,
    GameProps.assets.bulletExplosion.imagePath,
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
  BatufoGame game;
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
      game = BatufoGame(widget.gameModel);
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
  final BatufoGame game;
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
