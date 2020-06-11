import 'package:batufo/game_props.dart';
import 'package:flutter/material.dart';

Color healthColor(double health) {
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
