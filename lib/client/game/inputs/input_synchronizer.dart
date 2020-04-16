import 'package:batufo/shared/messaging/player_inputs.dart';
import 'package:batufo/shared/models/player_model.dart';

class InputSynchronizer {
  double timeToNextSync = 0;
  final double syncInterval;
  final Function(PlayerInputs playerInputs) submitPlayerInputs;

  InputSynchronizer(this.submitPlayerInputs, this.syncInterval);

  void update(
    double dt,
    PlayerModel player,
  ) {
    timeToNextSync -= dt;
    if (timeToNextSync > 0) return;

    final inputs = PlayerInputs(angle: player.angle);
    submitPlayerInputs(inputs);

    timeToNextSync = syncInterval;
  }
}