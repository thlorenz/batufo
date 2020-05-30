import 'package:flutter/material.dart';

class ReadyToShootWidget extends StatelessWidget {
  final int percentReadyToShoot;

  const ReadyToShootWidget({this.percentReadyToShoot}) : super();
// 🔫
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width * 0.2;
    final healthWidth = (percentReadyToShoot / 100) * totalWidth;
    return Row(
      children: [
        Container(
          height: 10,
          width: totalWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
              width: 2.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          child: Container(
            margin: EdgeInsets.only(right: totalWidth - healthWidth),
            color: Colors.blue,
          ),
        ),
        Text(' 🔫')
      ],
    );
  }
}
