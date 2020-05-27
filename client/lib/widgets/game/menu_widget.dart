import 'package:batufo/rpc/client.dart';
import 'package:batufo/universe.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final String serverIP;
  final Universe universe;

  const MenuWidget({
    @required this.serverIP,
    @required this.universe,
  }) : super();

  @override
  _MenuWidgetState createState() => _MenuWidgetState(
        serverIP: serverIP,
        universe: universe,
      );
}

class _MenuWidgetState extends State<MenuWidget> {
  final String serverIP;
  final Universe universe;
  Client client;

  _MenuWidgetState({
    @required this.serverIP,
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
    client = Client.create(universe, level, serverIP);
  }
}
