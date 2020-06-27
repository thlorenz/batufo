import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/widgets/hud/labeled_scalar_widget.dart';
import 'package:flutter/material.dart';

class BombsWidget extends StatelessWidget {
  final int nbombs;
  final bool isActive;
  final double fontSize;
  final double screenWidthPercent;
  const BombsWidget({
    @required this.nbombs,
    @required this.isActive,
    this.screenWidthPercent = 1.0,
    this.fontSize = 10,
  }) : super();

  Widget build(BuildContext context) {
    final higlight = isActive ? Colors.yellowAccent : Colors.transparent;
    return LabeledScalarWidget(
      screenWidthPercent: screenWidthPercent,
      scalar: Text(
        '$nbombs',
        style: TextStyle(color: Colors.greenAccent, fontSize: fontSize),
      ),
      labelWidget: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: higlight),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        padding: EdgeInsets.all(2.0),
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
