import 'package:batufo/engine/tile_position.dart';
import 'package:flutter/foundation.dart';

class TeleportationModel {
  final TilePosition teleportExit;
  double timeLeftToEnterTeleport;
  double timeLeftToExitTeleport;

  TeleportationModel._({
    @required this.teleportExit,
    this.timeLeftToEnterTeleport = 0.0,
    this.timeLeftToExitTeleport = 0.0,
  });

  factory TeleportationModel.empty() {
    return TeleportationModel._(teleportExit: TilePosition.zero());
  }

  factory TeleportationModel.start(
    TilePosition teleportExit,
    double timeLeftToCompleteTeleport,
  ) {
    return TeleportationModel._(
      teleportExit: teleportExit,
      timeLeftToEnterTeleport: timeLeftToCompleteTeleport / 2,
      timeLeftToExitTeleport: timeLeftToCompleteTeleport / 2,
    );
  }

  bool get isActive =>
      timeLeftToEnterTeleport > 0.0 || timeLeftToExitTeleport > 0.0;

  bool get isEntering => timeLeftToEnterTeleport > 0.0;
}
