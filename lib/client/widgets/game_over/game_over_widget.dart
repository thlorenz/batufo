import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:flutter/material.dart';

final _log = Log<GameOverWidget>();

class GameOverWidget extends StatelessWidget {
  final VoidCallback newGameRequested;
  final bool won;

  const GameOverWidget({
    @required this.newGameRequested,
    @required this.won,
  }) : super();

  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                won ? 'You won!!' : 'Game Over',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              RaisedButton(
                onPressed: newGameRequested,
                child: Text('New Game'),
              )
            ],
          ),
        ),
        color: Color(0x66000000),
      ),
    );
  }
}
