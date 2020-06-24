import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final double size;
  final String icon;

  const IconWidget({@required this.icon, this.size = 20.0}) : super();

  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/icons/$icon.png',
      width: size,
    );
  }
}
