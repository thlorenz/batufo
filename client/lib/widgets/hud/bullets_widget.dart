import 'package:batufo/widgets/components/icon_widget.dart';
import 'package:batufo/widgets/hud/labeled_scalar_widget.dart';
import 'package:flutter/material.dart';

class BulletsWidget extends StatelessWidget {
  final int nbullets;
  final bool isActive;
  final double fontSize;
  final double screenWidthPercent;
  const BulletsWidget({
    @required this.nbullets,
    @required this.isActive,
    this.screenWidthPercent = 1.0,
    this.fontSize = 10,
  }) : super();

  Widget build(BuildContext context) {
    final higlight = isActive ? Colors.yellowAccent : Colors.transparent;
    return LabeledScalarWidget(
      screenWidthPercent: screenWidthPercent,
      scalar: Text(
        '$nbullets',
        style: TextStyle(color: Colors.greenAccent, fontSize: fontSize),
      ),
      labelWidget: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: higlight),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        padding: EdgeInsets.all(2.0),
        child: IconWidget(icon: 'gun', size: 18),
      ),
      labelFontSize: fontSize,
    );
  }
}
