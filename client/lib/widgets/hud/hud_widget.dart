import 'package:batufo/states/stats_state.dart';
import 'package:batufo/universe.dart';
import 'package:batufo/widgets/hud/health_widget.dart';
import 'package:flutter/material.dart';

class HudWidget extends StatelessWidget {
  final Universe universe;
  const HudWidget({@required this.universe}) : super();

  Widget build(BuildContext context) {
    return StreamBuilder<StatsState>(
        stream: universe.statsState$,
        initialData: universe.initialStatsState,
        builder: (context, snapshot) {
          return Container(
            color: Color(0x66000000),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  HealthWidget(health: snapshot.data.health),
                ],
              ),
            ),
          );
        });
  }
}
