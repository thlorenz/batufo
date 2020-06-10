import 'package:batufo/widgets/screens/router.dart';
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
    );
  }
}
