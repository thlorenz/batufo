import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int score;
  const ScoreWidget({
    @required this.score,
  }) : super();

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.1;
    return Container(
      width: width,
      child: Text(
        ' 🏆  $score',
        style: TextStyle(color: Colors.greenAccent, fontSize: 10),
      ),
    );
  }
}
