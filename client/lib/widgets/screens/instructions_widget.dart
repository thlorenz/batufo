import 'dart:math';

import 'package:batufo/setup/config.dart';
import 'package:batufo/types.dart';
import 'package:batufo/widgets/screens/router.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const DESKTOP_INSTRUCTIONS = 'https://youtu.be/sk3bITPiSeA';
const MOBILE_INSTRUCTIONS = 'https://youtu.be/fTOnVhHM0e4';

Tuple<bool, bool> _controlsToShow(PlatformType platform) {
  switch (platform) {
    case PlatformType.MacOS:
    case PlatformType.Linux:
    case PlatformType.Windows:
      return Tuple(true, false);
    case PlatformType.Android:
    case PlatformType.IOS:
      return Tuple(false, true);
    case PlatformType.Fuchsia:
    case PlatformType.Web:
      return Tuple(true, true);
    default:
      throw UnimplementedError('Do not know platform $platform');
  }
}

String _instructionsURL(PlatformType platform) {
  switch (platform) {
    case PlatformType.MacOS:
    case PlatformType.Linux:
    case PlatformType.Windows:
    case PlatformType.Web:
      return DESKTOP_INSTRUCTIONS;
    case PlatformType.Android:
    case PlatformType.IOS:
    case PlatformType.Fuchsia:
      return MOBILE_INSTRUCTIONS;
    default:
      throw UnimplementedError('Do not know platform $platform');
  }
}

class InstructionsWidget extends StatelessWidget {
  final PlatformType platform;
  const InstructionsWidget({@required this.platform}) : super();

  @override
  Widget build(BuildContext context) {
    final show = _controlsToShow(platform);
    final showKeyboard = show.first;
    final showGestures = show.second;
    final instructionsURL = _instructionsURL(platform);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black.withAlpha(0x66),
        title: Text(
          'Instructions',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            title: Text('Play'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            title: Text('Watch Instructions'),
          ),
        ],
        onTap: (idx) async {
          switch (idx) {
            case 0:
              Navigator.of(context).pop();
              await Navigator.of(context).pushReplacementNamed(Routes.UNIVERSE);
              break;
            case 1:
              if (await canLaunch(instructionsURL))
                await launch(instructionsURL);
              break;
            default:
              throw UnimplementedError('menu item $idx');
          }
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (showKeyboard) Expanded(child: _Keyboard()),
            if (showGestures) Expanded(child: _Gestures()),
            _Description(),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(0xaa),
        border: Border.all(width: 1.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Text(
        'Rotate the UFO into the desired direction and '
        ' then accelerate by applying thrust'
        ' or fire a weapon.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Gestures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = min(MediaQuery.of(context).size.width * 0.8, 300.0);
    return Container(
      width: width,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(0xaa),
        border: Border.all(width: 1.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: GridView.count(
        padding: const EdgeInsets.all(10),
        childAspectRatio: 1.0,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 3,
        children: <Widget>[
          Container(),
          _Gesture(icon: MdiIcons.gestureSwipeUp, label: 'Apply Thrust'),
          Container(),
          _Gesture(icon: MdiIcons.gestureSwipeLeft, label: 'Rotate Left'),
          _Gesture(icon: Icons.touch_app, label: 'Fire Weapon'),
          _Gesture(icon: MdiIcons.gestureSwipeRight, label: 'Rotate Right'),
          Container(),
          _Gesture(icon: MdiIcons.gestureSwipeDown, label: 'Switch Weapon'),
        ],
      ),
    );
  }
}

class _Gesture extends StatelessWidget {
  final IconData icon;
  final String label;
  final double iconSize;
  final double labelSize;

  const _Gesture(
      {@required this.icon,
      @required this.label,
      this.iconSize = 56.0,
      this.labelSize = 12.0})
      : super();

  Widget build(BuildContext context) {
    const Color textColor = Colors.white;
    const Color iconColor = Colors.greenAccent;
    return Column(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
        Text(label,
            style: TextStyle(
              fontSize: labelSize,
              fontStyle: FontStyle.italic,
              color: textColor,
            )),
      ],
    );
  }
}

class _Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = min(MediaQuery.of(context).size.width * 0.8, 300.0);
    final keyFontSize = width * 0.1;
    final labelFontSize = keyFontSize * 0.4;
    return Container(
      width: width,
      child: GridView.count(
        padding: const EdgeInsets.all(10),
        childAspectRatio: 1.4,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 3,
        children: <Widget>[
          Container(),
          _KeyboardKey(
            icon: Icons.keyboard_arrow_up,
            instruction: 'Apply Thrust',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          Container(),
          _KeyboardKey(
            icon: Icons.keyboard_arrow_left,
            instruction: 'Rotate Left',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          _KeyboardKey(
            icon: Icons.keyboard_arrow_down,
            instruction: 'Switch Weapon',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          _KeyboardKey(
            icon: Icons.keyboard_arrow_right,
            instruction: 'Rotate Right',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          Container(),
          _KeyboardKey(
            letter: 'W',
            instruction: 'Apply Thrust',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          Container(),
          _KeyboardKey(
            letter: 'A',
            instruction: 'Rotate Left',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          _KeyboardKey(
            letter: 'S',
            instruction: 'Switch Weapon',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          _KeyboardKey(
            letter: 'D',
            instruction: 'Rotate Right',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          _KeyboardKey(
            letter: '',
            instruction: '',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
            borderRadius: 0.0,
            flat: true,
          ),
          _KeyboardKey(
            letter: 'Space',
            instruction: 'Fire Weapon',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
            borderRadius: 0.0,
            flat: true,
          ),
          _KeyboardKey(
            letter: '',
            instruction: '',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
            borderRadius: 0.0,
            flat: true,
          ),
        ],
      ),
    );
  }
}

class _KeyboardKey extends StatelessWidget {
  final String letter;
  final IconData icon;
  final double borderRadius;
  final Color color;
  final double keyFontSize;
  final double labelFontSize;
  final String instruction;
  final bool flat;
  const _KeyboardKey({
    this.letter,
    this.icon,
    this.flat = false,
    @required this.keyFontSize,
    @required this.labelFontSize,
    @required this.instruction,
    this.borderRadius = 5,
    this.color = Colors.black,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final key = letter != null
        ? Text(letter,
            style: TextStyle(color: Colors.white, fontSize: keyFontSize))
        : Icon(icon, color: Colors.white, size: keyFontSize * 1.4);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Color(0xff2e2e2e),
        gradient: flat
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xff1c1c1c), Color(0xff383838)],
              ),
      ),
      child: Padding(
        padding: flat ? EdgeInsets.all(0.0) : const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            color: Color(0xff1a1a1a),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xff303030), Color(0xff1a1a1a)]),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                key,
                Text(
                  instruction,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: labelFontSize,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
