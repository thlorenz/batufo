import 'dart:math';

import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/widgets/screens/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        onTap: (idx) {
          switch (idx) {
            case 0:
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(Routes.UNIVERSE);
              break;
            case 1:
              throw UnimplementedError(
                  'need to create and link instruction video');
            default:
              throw UnimplementedError('menu item $idx');
          }
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: _Keyboard()),
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
        'Rotate the UFO into the desired direction'
        ' then accelerate by applying thrust'
        ' or fire a bullet.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
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
            letter: 'W',
            instruction: 'Apply Thrust',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          _KeyboardKey(
            icon: Icons.keyboard_arrow_right,
            instruction: 'Rotate Right',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          _KeyboardKey(
            letter: 'A',
            instruction: 'Rotate Left',
            keyFontSize: keyFontSize,
            labelFontSize: labelFontSize,
          ),
          RotatedBox(
            quarterTurns: -1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(assets.player.imagePath),
            ),
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
            instruction: 'Fire',
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
