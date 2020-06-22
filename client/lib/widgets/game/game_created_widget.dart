import 'package:batufo/engine/game_widget.dart';
import 'package:batufo/game/client_game.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/hud/hud_widget.dart';
import 'package:flutter/material.dart';

class GameCreatedWidget extends StatelessWidget {
  final ClientGame game;
  final Universe universe;

  const GameCreatedWidget({@required this.universe, @required this.game})
      : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        GameWidget(game),
        Container(
          color: Colors.black.withAlpha(0x55),
          child: Center(
            child: Text(
              'Waiting for players ...',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 18,
              ),
            ),
          ),
        ),
        HudWidget(universe: universe),
      ]),
    );
  }
}
