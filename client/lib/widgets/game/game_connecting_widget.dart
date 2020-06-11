import 'package:batufo/widgets/screens/router.dart';
import 'package:batufo/widgets/styles.dart';
import 'package:flutter/material.dart';

class GameConnectingWidget extends StatelessWidget {
  final String appTitle;

  const GameConnectingWidget({@required this.appTitle}) : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withAlpha(0x66),
        title: Text(appTitle, style: headerStyle),
      ),
      body: Container(
        color: Colors.black.withAlpha(0xaa),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Trying to connect to the Game',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 18,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Icon(
                Icons.perm_scan_wifi,
                color: Colors.white,
                size: 56.0,
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                'Make sure you are connected the Internet',
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('Instructions'),
          ),
        ],
        onTap: (idx) {
          switch (idx) {
            case 0:
              Navigator.of(context).pushReplacementNamed(Routes.HOME);
              break;
            case 1:
              Navigator.of(context).pushNamed(Routes.INSTRUCTIONS);
              break;
            default:
              throw UnimplementedError('menu item $idx');
          }
        },
      ),
    );
  }
}
