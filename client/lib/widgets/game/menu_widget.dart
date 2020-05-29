import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final Universe universe;
  final List<LevelInfo> levels;

  const MenuWidget({
    @required this.universe,
    @required this.levels,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final levelBoxes =
        levels.map((LevelInfo level) => _levelBox(context, level)).toList();
    return Wrap(children: levelBoxes);
  }

  Widget _levelBox(BuildContext context, LevelInfo level) {
    return RaisedButton(
      onPressed: () {
        _onLevelSelected(level.name);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(level.name, style: TextStyle(fontSize: 18)),
              // TODO(thlorenz): put image of level here
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              Text('${level.nplayers} players', style: TextStyle(fontSize: 14))
            ],
          ),
        ),
      ),
    );
  }

  void _onLevelSelected([String level = 'simple']) {
    universe.userSelectedLevel(level);
  }
}
