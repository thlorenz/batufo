import 'package:batufo/game_props.dart';
import 'package:flutter/material.dart';

class HealthWidget extends StatelessWidget {
  final double health;

  const HealthWidget({this.health}) : super();

  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width * 0.5;
    final healthWidth = (health / GameProps.playerTotalHealth) * totalWidth;
    return Container(
      height: 20,
      width: totalWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Container(
        margin: EdgeInsets.only(right: totalWidth - healthWidth),
        color: _healthColor(),
      ),
    );
  }

  Color _healthColor() {
    return health > GameProps.playerTotalHealth * 0.80
        ? Colors.greenAccent
        : health > GameProps.playerTotalHealth * 0.60
            ? Colors.green
            : health > GameProps.playerTotalHealth * 0.4
                ? Colors.orange
                : health > GameProps.playerTotalHealth * 0.2
                    ? Colors.redAccent
                    : Colors.red;
  }
}
