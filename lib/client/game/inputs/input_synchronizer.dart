import 'dart:math';

import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/messaging/player_inputs.dart';
import 'package:batufo/shared/models/player_model.dart';

final _log = Log<InputSynchronizer>();

class InputSynchronizer {
  double timeToNextSync = 0;
  final double syncInterval;
  final Function(PlayerInputs playerInputs) submitPlayerInputs;
  PlayerInputs _lastSentInputs;

  InputSynchronizer(this.submitPlayerInputs, this.syncInterval);

  void update(
    double dt,
    PlayerModel player,
  ) {
    timeToNextSync = max(0, timeToNextSync - dt);

    final inputs = PlayerInputs(
      angle: player.angle,
      appliedThrust: player.appliedThrust,
      shotBullet: player.shotBullet,
    );
    if (_lastSentInputs == inputs) return;

    final forceSync = inputs.appliedThrust || inputs.shotBullet;

    if (forceSync || timeToNextSync <= 0) {
      submitPlayerInputs(inputs);

      timeToNextSync = syncInterval;
      _lastSentInputs = inputs.cloneWithoutEvents();
    }
  }
}
