import 'package:batufo/widgets/hud/labeled_scalar_widget.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int score;
  const ScoreWidget({
    @required this.score,
  }) : super();

  Widget build(BuildContext context) {
    return LabeledScalarWidget(
      screenWidthPercent: 0.1,
      scalar: Text(
        '$score',
        style: TextStyle(color: Colors.greenAccent, fontSize: 10),
      ),
      label: '🏆',
    );
  }
}
