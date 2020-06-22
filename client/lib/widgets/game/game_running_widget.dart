import 'package:batufo/engine/game_widget.dart';
import 'package:batufo/game/client_game.dart';
import 'package:batufo/game/inputs/gestures.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/hud/hud_widget.dart';
import 'package:flutter/material.dart';

class GameRunningWidget extends StatelessWidget {
  final ClientGame game;
  final Universe universe;

  const GameRunningWidget({@required this.universe, @required this.game})
      : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        GestureDetector(
            onPanUpdate: GameGestures.instance.onPanUpdate,
            onTap: GameGestures.instance.onTap,
            child: GameWidget(game)),
        HudWidget(universe: universe)
      ]),
    );
  }
}
