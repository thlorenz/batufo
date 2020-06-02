import 'package:flutter/material.dart';

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
      child: IconButton(
        color: Colors.blueGrey,
        icon: Icon(Icons.exit_to_app),
        iconSize: height,
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.topCenter,
        onPressed: onExit,
      ),
    );
  }
}
