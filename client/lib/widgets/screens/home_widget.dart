import 'package:batufo/widgets/screens/router.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _ATTRIBUTIONS_URL = 'https://thlorenz.com/batufo/#devlog-batufo-attrib';
const _SPONSOR_URL = 'https://thlorenz.com/batufo/#sponsor';
const _HOME_URL = 'https://thlorenz.com/batufo/';
const _EDITOR_URL = 'https://thlorenz.com/batufo/editor';
final _linkStyle = TextStyle(
  color: Colors.lightBlue[100],
  fontStyle: FontStyle.italic,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);

Future<void> _maybeLaunch(String url) async {
  if (await canLaunch(url))
    await launch(
      url,
      forceWebView: true,
      enableJavaScript: true,
    );
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/level-icon.png'),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _GameStoryWidget(),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              InkWell(
                  child: Text('Home Page', style: _linkStyle),
                  onTap: () => _maybeLaunch(_HOME_URL)),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              InkWell(
                  child: Text('Attributions', style: _linkStyle),
                  onTap: () => _maybeLaunch(_ATTRIBUTIONS_URL)),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              InkWell(
                  child: Text('Donate', style: _linkStyle),
                  onTap: () => _maybeLaunch(_SPONSOR_URL)),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              InkWell(
                  child: Text('Level Editor', style: _linkStyle),
                  onTap: () => _maybeLaunch(_EDITOR_URL)),
            ],
          ),
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
        onTap: (idx) {
          switch (idx) {
            case 0:
              Navigator.of(context).pushReplacementNamed(Routes.UNIVERSE);
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

class _GameStoryWidget extends StatelessWidget {
  final defaultStyle = TextStyle(
    fontSize: 16,
    color: Colors.yellowAccent,
    fontStyle: FontStyle.italic,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 18),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(0x66),
        border: Border.all(width: 2.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: RichText(
        text: TextSpan(
            style: defaultStyle.copyWith(
              fontSize: 24,
              fontStyle: FontStyle.normal,
            ),
            text: 'They\'re back ... ',
            children: [
              TextSpan(text: '\n\n'),
              TextSpan(
                  style: defaultStyle,
                  text: 'And this time they didn\'t come to negotiate.'),
              TextSpan(text: '\n\n'),
              TextSpan(
                style: defaultStyle,
                text: 'Some say the Lekdas never '
                    'wanted to negotiate. They just want to take, '
                    'take more and wage war.',
              ),
              TextSpan(style: defaultStyle, text: '\n\n'),
              TextSpan(
                style: defaultStyle,
                text: 'They entered the stratosphere of your planet, '
                    'their ships disguised to look like yours.',
              ),
              TextSpan(style: defaultStyle, text: '\n\n'),
              TextSpan(
                style: defaultStyle,
                text: 'All that remains now is to defend, defend ... '
                    'and finally prevail or life as we know it '
                    'will cease to exist.',
              ),
            ]),
      ),
    );
  }
}
