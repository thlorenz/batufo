import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// alternative ⏏️
// return Container(
//   width: width, child: Text('⚙️', style: TextStyle(fontSize: 14)));

class ExitGameWidget extends StatelessWidget {
  final void Function() onExit;

  const ExitGameWidget({this.onExit}) : super();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.08;
    const height = 18.0;
    return Container(
      width: width,
      height: height,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onExit,
          child: Icon(
            Icons.exit_to_app,
            size: height,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
