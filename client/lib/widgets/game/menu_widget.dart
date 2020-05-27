import 'package:batufo/universe.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final Universe universe;

  const MenuWidget({
    @required this.universe,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('Simple Level'),
        onPressed: _onLevelSelected,
      ),
    );
  }

  void _onLevelSelected([String level = 'simple']) {
    universe.userSelectedLevel(level);
  }
}
