import 'package:batufo/client/widgets/hud/health_widget.dart';
import 'package:batufo/shared/models/game_model.dart';
import 'package:flutter/material.dart';

class HudWidget extends StatelessWidget {
  final Stats stats;

  const HudWidget({@required this.stats}) : super();

  Widget build(BuildContext context) {
    return Container(
      color: Color(0x66000000),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            HealthWidget(health: stats.health),
          ],
        ),
      ),
    );
  }
}
