import 'package:batufo/rpc/server_stats.dart';
import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/game/level_widget.dart';
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
    final headerStyle = TextStyle(
      color: Colors.blue,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );
    return Container(
      color: Color(0x66000000),
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('🎲  $totalGames', style: totalsStyle),
            Text(appTitle, style: headerStyle),
            Text('$totalPlayers  🎮', style: totalsStyle),
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
    return Column(
      children: [
        TotalStatsWidget(
            appTitle: universe.appTitle,
            totalGames: serverStats.totalGames,
            totalPlayers: serverStats.totalPlayers),
        Expanded(
          child: Container(
            child: ListView(
              children: levelBoxes,
            ),
          ),
        ),
      ],
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
