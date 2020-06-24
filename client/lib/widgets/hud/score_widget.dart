import 'package:batufo/widgets/components/icon_widget.dart';
import 'package:batufo/widgets/hud/labeled_scalar_widget.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int score;
  final double fontSize;
  final double screenWidthPercent;
  const ScoreWidget({
    @required this.score,
    this.screenWidthPercent = 1.0,
    this.fontSize = 10,
  }) : super();

  Widget build(BuildContext context) {
    return LabeledScalarWidget(
      screenWidthPercent: screenWidthPercent,
      scalar: Text(
        '$score',
        style: TextStyle(color: Colors.greenAccent, fontSize: fontSize),
      ),
      labelWidget: IconWidget(
        icon: 'trophy',
        size: 20.0,
      ),
      labelFontSize: fontSize,
    );
  }
}
