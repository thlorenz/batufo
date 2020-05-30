import 'package:flutter/material.dart';

class ReadyToActWidget extends StatelessWidget {
  final Widget label;
  final double borderRadius;
  final double height;
  final double screenWidthPercent;
  final int percentReadyToAct;
  final Color fillColor;

  const ReadyToActWidget({
    @required this.screenWidthPercent,
    @required this.height,
    @required this.label,
    @required this.fillColor,
    @required this.borderRadius,
    @required this.percentReadyToAct,
  }) : super();

  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width * screenWidthPercent;
    final healthWidth = (percentReadyToAct / 100) * totalWidth;
    return Row(
      children: [
        Container(
          height: height,
          width: totalWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
              width: 2.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Container(
            margin: EdgeInsets.only(right: totalWidth - healthWidth),
            color: fillColor,
          ),
        ),
        label,
      ],
    );
  }
}
