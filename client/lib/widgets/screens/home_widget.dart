import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black.withAlpha(0x66),
        title: Text('batufo'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg/level-icon.png'),
              fit: BoxFit.cover),
          color: Colors.white,
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: _GameStoryWidget()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            title: Text('Play'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('Instructions'),
          ),
        ],
        onTap: (idx) {},
      ),
    );
  }
}

class _GameStoryWidget extends StatelessWidget {
  final defaultStyle = TextStyle(fontSize: 16, color: Colors.yellowAccent);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(0x66),
        border: Border.all(width: 2.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: RichText(
        text: TextSpan(
            style: defaultStyle.copyWith(fontSize: 24),
            text: 'When the universe began ... ',
            children: [
              TextSpan(text: '\n\n'),
              TextSpan(style: defaultStyle, text: 'there were no UFOs.'),
              TextSpan(style: defaultStyle, text: '\n\n'),
              TextSpan(
                style: defaultStyle,
                text: 'Then there were many fighting fiercely for territory.',
              ),
              TextSpan(style: defaultStyle, text: '\n\n'),
              TextSpan(
                style: defaultStyle,
                text: 'You are one of them and know that you have'
                    ' exactly two options.',
              ),
              TextSpan(style: defaultStyle, text: '\n'),
            ]),
      ),
    );
  }
}
