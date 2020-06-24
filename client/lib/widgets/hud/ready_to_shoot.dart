import 'package:batufo/widgets/components/icon_widget.dart';
import 'package:batufo/widgets/hud/ready_to_act_widget.dart';
import 'package:flutter/material.dart';

// 🔫   💣

class ReadyToShootWidget extends ReadyToActWidget {
  final int percentReadyToShoot;
  const ReadyToShootWidget({this.percentReadyToShoot})
      : super(
          label: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: IconWidget(icon: 'gun', size: 12),
          ),
          borderRadius: 2.0,
          height: 8,
          screenWidthPercent: 0.2,
          percentReadyToAct: percentReadyToShoot,
          fillColor: Colors.black,
        );
}
