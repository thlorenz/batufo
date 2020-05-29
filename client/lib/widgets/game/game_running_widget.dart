import 'package:batufo/engine/game_widget.dart';
import 'package:batufo/game/client_game.dart';
import 'package:flutter/material.dart';

class GameRunningWidget extends StatelessWidget {
  final ClientGame game;

  const GameRunningWidget({@required this.game}) : super();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GameWidget(game),
    ]);
  }
}
