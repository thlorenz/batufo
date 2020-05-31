import 'package:batufo/rpc/server_stats.dart';
import 'package:batufo/states/user_state.dart';
import 'package:batufo/universe.dart';
import 'package:flutter/material.dart';

class TotalStatsWidget extends StatelessWidget {
  final int totalGames;
  final int totalPlayers;

  const TotalStatsWidget(this.totalGames, this.totalPlayers);

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('🎲  $totalGames', style: totalsStyle),
            Text('Batufo', style: headerStyle),
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
    final levelBoxes =
        levels.map((LevelInfo level) => _levelBox(context, level)).toList();
    return Stack(
      children: [
        TotalStatsWidget(serverStats.totalGames, serverStats.totalPlayers),
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Wrap(children: levelBoxes),
        ),
      ],
    );
  }

  Widget _levelBox(BuildContext context, LevelInfo level) {
    final waiting = serverStats.waitingForLevesCounts[level.name] ?? 0;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            _onLevelSelected(level.name);
          },
          child: Column(
            children: [
              Text(level.name, style: TextStyle(fontSize: 18)),
              Padding(
                padding: const EdgeInsets.all(4.0),
              ),
              Text('${level.nplayers}', style: TextStyle(fontSize: 28)),
              Text('🚀', style: TextStyle(fontSize: 28)),
              Padding(
                padding: const EdgeInsets.all(4.0),
              ),
              Text('waiting $waiting ', style: TextStyle(fontSize: 14)),
              Padding(
                padding: const EdgeInsets.all(4.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLevelSelected([String level = 'simple']) {
    universe.userSelectedLevel(level);
  }
}
