import 'package:batufo/widgets/components/icon_widget.dart';
import 'package:batufo/widgets/hud/labeled_scalar_widget.dart';
import 'package:flutter/material.dart';

class PlayersAliveWidget extends StatelessWidget {
  final int totalPlayers;
  final int playersAlive;
  const PlayersAliveWidget({
    @required this.totalPlayers,
    @required this.playersAlive,
  }) : super();

  Widget build(BuildContext context) {
    return LabeledScalarWidget(
      screenWidthPercent: 0.1,
      scalar: Text(
        '$playersAlive/$totalPlayers',
        style: TextStyle(color: Colors.amber, fontSize: 10),
      ),
      labelWidget: IconWidget(icon: 'game-pad', size: 16),
    );
  }
}
