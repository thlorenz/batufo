import 'package:batufo/models/player_model.dart';
import 'package:batufo/states/stats_state.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/hud/bombs_widget.dart';
import 'package:batufo/widgets/hud/bullets_widget.dart';
import 'package:batufo/widgets/hud/exit_game_widget.dart';
import 'package:batufo/widgets/hud/health_widget.dart';
import 'package:batufo/widgets/hud/players_alive_widget.dart';
import 'package:batufo/widgets/hud/ready_to_shoot.dart';
import 'package:batufo/widgets/hud/ready_to_thrust_widget.dart';
import 'package:batufo/widgets/hud/score_widget.dart';
import 'package:flutter/material.dart';

class HudWidget extends StatelessWidget {
  final Universe universe;
  const HudWidget({@required this.universe}) : super();

  Widget build(BuildContext context) {
    // TODO: ideally we wouldn't rebuild the health + player widgets
    //  whenever our percent to shoot/apply thrust changes, so we should
    // consider splitting these into separate streams.
    // This would also allow us to remove the throttle on those stats that
    // change often (see universe.dart).
    return StreamBuilder<StatsState>(
        stream: universe.statsState$,
        initialData: StatsState.empty,
        builder: (context, snapshot) {
          final stats = snapshot.data;
          assert(stats != null,
              'should only build this once game was created with stats');
          return Container(
            color: Color(0x66000000),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ScoreWidget(
                    score: stats.score,
                    screenWidthPercent: 0.1,
                  ),
                  BulletsWidget(
                    isActive: stats.weapon == Weapon.Bullet,
                    nbullets: stats.nbullets,
                    screenWidthPercent: 0.05,
                  ),
                  BombsWidget(
                    isActive: stats.weapon == Weapon.Bomb,
                    nbombs: stats.nbombs,
                    screenWidthPercent: 0.05,
                  ),
                  HealthWidget(health: stats.health),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReadyToThrustWidget(
                        percentReadyToThrust: stats.percentReadyToThrust,
                      ),
                      ReadyToShootWidget(
                        percentReadyToShoot: stats.percentReadyToShoot,
                      ),
                    ],
                  ),
                  PlayersAliveWidget(
                    totalPlayers: stats.totalPlayers,
                    playersAlive: stats.playersAlive,
                  ),
                  ExitGameWidget(onExit: universe.userPlayOtherLevel),
                ],
              ),
            ),
          );
        });
  }
}
