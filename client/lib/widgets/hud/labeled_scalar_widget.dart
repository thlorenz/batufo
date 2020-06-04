import 'package:flutter/material.dart';

class LabeledScalarWidget extends StatelessWidget {
  final Widget scalar;
  final String label;
  final double labelFontSize;
  final double screenWidthPercent;

  const LabeledScalarWidget(
      {@required this.scalar,
      @required this.label,
      @required this.screenWidthPercent,
      this.labelFontSize = 10})
      : super();

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * screenWidthPercent;
    return Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: labelFontSize),
            ),
            scalar
          ],
        ));
  }
}
