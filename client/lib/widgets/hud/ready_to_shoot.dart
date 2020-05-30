import 'package:batufo/widgets/hud/ready_to_act_widget.dart';
import 'package:flutter/material.dart';

// 🔫   💣

class ReadyToShootWidget extends ReadyToActWidget {
  final int percentReadyToShoot;
  const ReadyToShootWidget({this.percentReadyToShoot})
      : super(
          label: const Text(' 💣', style: TextStyle(fontSize: 10)),
          borderRadius: 2.0,
          height: 8,
          screenWidthPercent: 0.2,
          percentReadyToAct: percentReadyToShoot,
          fillColor: Colors.black,
        );
}
