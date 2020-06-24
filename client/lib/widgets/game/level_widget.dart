import 'package:batufo/states/user_state.dart';
import 'package:batufo/widgets/components/text_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LevelWidget extends StatelessWidget {
  final int playersWaiting;
  final LevelInfo level;
  final void Function(String level) onLevelSelected;
  final Color textColor;

  const LevelWidget(
      {@required this.level,
      @required this.onLevelSelected,
      @required this.playersWaiting,
      this.textColor = Colors.white})
      : super();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            onLevelSelected(level.name);
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg/level-icon.png'),
                fit: BoxFit.fitWidth,
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                ),
                Text(level.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                    )),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                ),
                Center(
                  child: TextIconWidget(
                    pretext: '$playersWaiting',
                    iconName: 'rocket',
                    posttext: '${level.nplayers}',
                    iconSize: 40,
                    style: TextStyle(
                      fontSize: 28,
                      color: textColor,
                    ),
                    itemsAlignment: MainAxisAlignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
