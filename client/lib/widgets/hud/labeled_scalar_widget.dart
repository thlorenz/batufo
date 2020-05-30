import 'package:flutter/material.dart';

class LabeledScalarWidget extends StatelessWidget {
  final Widget scalar;
  final String label;
  final double screenWidthPercent;

  const LabeledScalarWidget({
    @required this.scalar,
    @required this.label,
    @required this.screenWidthPercent,
  }) : super();

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.1;
    return Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10),
            ),
            scalar
          ],
        ));
  }
}
