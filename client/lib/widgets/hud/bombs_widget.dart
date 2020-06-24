import 'dart:math';

import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/widgets/hud/labeled_scalar_widget.dart';
import 'package:flutter/material.dart';

class BombsWidget extends StatelessWidget {
  final int nbombs;
  final double fontSize;
  final double screenWidthPercent;
  const BombsWidget({
    @required this.nbombs,
    this.screenWidthPercent = 1.0,
    this.fontSize = 10,
  }) : super();

  Widget build(BuildContext context) {
    return LabeledScalarWidget(
      screenWidthPercent: screenWidthPercent,
      scalar: Text(
        '$nbombs',
        style: TextStyle(color: Colors.greenAccent, fontSize: fontSize),
      ),
      labelWidget: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: RotatedBox(
          quarterTurns: 2,
          child: Image.asset(
            assets.bomb.imagePath,
            width: 18.0,
          ),
        ),
      ),
      labelFontSize: fontSize,
    );
  }
}
