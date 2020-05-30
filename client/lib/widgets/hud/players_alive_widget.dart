import 'package:flutter/material.dart';

class PlayersAliveWidget extends StatelessWidget {
  final int totalPlayers;
  final int playersAlive;
  const PlayersAliveWidget({
    @required this.totalPlayers,
    @required this.playersAlive,
  }) : super();

  Widget build(BuildContext context) {
    return Text(
      '$playersAlive/$totalPlayers  🎮',
      style: TextStyle(color: Colors.amber),
    );
  }
}
