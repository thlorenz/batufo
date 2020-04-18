import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:batufo/shared/messaging/player_inputs.dart';
import 'package:batufo/shared/models/player_model.dart';

final _log = Log<InputSynchronizer>();

class InputSynchronizer {
  double timeToNextSync = 0;
  final double syncInterval;
  final Function(PlayerInputs playerInputs) submitPlayerInputs;

  bool _appliedThrust = false;
  InputSynchronizer(this.submitPlayerInputs, this.syncInterval);

  void update(
    double dt,
    PlayerModel player,
  ) {
    _appliedThrust = _appliedThrust || player.appliedThrust;
    timeToNextSync -= dt;
    if (timeToNextSync > 0) return;

    final inputs = PlayerInputs(
      angle: player.angle,
      appliedThrust: _appliedThrust,
    );
    submitPlayerInputs(inputs);
    if (inputs.appliedThrust) {
      _log.finer('submitting $inputs');
    }

    timeToNextSync = syncInterval;
    _appliedThrust = false;
  }
}
