import 'package:batufo/rpc/server_stats.dart';
import 'package:batufo/setup/user_settings.dart';
import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/components/text_icon_widget.dart';
import 'package:batufo/widgets/game/level_widget.dart';
import 'package:batufo/widgets/screens/router.dart';
import 'package:batufo/widgets/styles.dart';
import 'package:flutter/material.dart';

class TotalStatsWidget extends StatelessWidget {
  final String appTitle;
  final int totalGames;
  final int totalPlayers;

  const TotalStatsWidget({
    @required this.appTitle,
    @required this.totalGames,
    @required this.totalPlayers,
  });

  @override
  Widget build(BuildContext context) {
    final totalsStyle = TextStyle(
      color: Colors.green,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
    return Container(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextIconWidget(
                iconName: 'dice', posttext: '$totalGames', style: totalsStyle),
            Text(appTitle, style: headerStyle),
            TextIconWidget(
                pretext: '$totalPlayers',
                iconName: 'game-pad',
                style: totalsStyle),
          ],
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  final Universe universe;
  final List<LevelInfo> levels;
  final ServerStats serverStats;

  const MenuWidget({
    @required this.universe,
    @required this.levels,
    @required this.serverStats,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final levelBoxes = levels.map(_levelBox).toList();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black.withAlpha(0x66),
        title: TotalStatsWidget(
            appTitle: universe.appTitle,
            totalGames: serverStats.totalGames,
            totalPlayers: serverStats.totalPlayers),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: levelBoxes,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<UserSettings>(
        stream: universe.userSettings$,
        initialData: universe.initialUserSettings,
        builder: (context, snapshot) {
          final effectsIcon =
              snapshot.hasData && snapshot.data.soundEffectsEnabled
                  ? Icons.volume_up
                  : Icons.volume_off;
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(effectsIcon),
                title: Text('Sound Effects'),
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
                  universe.toggleSoundEffects();
                  break;
                case 2:
                  Navigator.of(context).pushNamed(Routes.INSTRUCTIONS);
                  break;
                default:
                  throw UnimplementedError('menu item $idx');
              }
            },
          );
        },
      ),
    );
  }

  Widget _levelBox(LevelInfo level) {
    final playersWaiting = serverStats.waitingForLevesCounts[level.name] ?? 0;
    return LevelWidget(
      level: level,
      onLevelSelected: _onLevelSelected,
      playersWaiting: playersWaiting,
    );
  }

  void _onLevelSelected(String level) {
    universe.userSelectedLevel(level);
  }
}
