import 'package:flutter/material.dart';

class LabeledScalarWidget extends StatelessWidget {
  final Widget scalar;
  final String label;
  final Widget labelWidget;
  final double labelFontSize;
  final double screenWidthPercent;

  const LabeledScalarWidget(
      {@required this.scalar,
      @required this.screenWidthPercent,
      this.label,
      this.labelWidget,
      this.labelFontSize = 10})
      : assert(label != null || labelWidget != null,
            'need to provide either label or labelWidget'),
        super();

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * screenWidthPercent;
    final widget = labelWidget ??
        Text(
          label,
          style: TextStyle(fontSize: labelFontSize),
        );
    return Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [widget, scalar],
        ));
  }
}
