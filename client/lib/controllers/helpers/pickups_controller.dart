import 'package:batufo/arena/pickup.dart';
import 'package:batufo/controllers/helpers/colliders.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/models/pickups_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class PickupsController {
  final SoundController soundController;
  final PickupsModel pickups;
  final Colliders colliders;
  final void Function(Pickup pickup) onPickedUp;
  final double shieldDurationSeconds;

  PickupsController({
    @required this.pickups,
    @required this.colliders,
    @required this.soundController,
    @required this.onPickedUp,
    @required this.shieldDurationSeconds,
  }) {
    colliders.initPickups(pickups.pickups);
  }

  void update(PlayerModel player) {
    final pickup = colliders.playerPickingUpAt(player.tilePosition);
    if (pickup == null) return;
    switch (pickup.type) {
      case PickupType.Medkit:
        break;
      case PickupType.Shield:
        player.shieldSecondsRemaining = shieldDurationSeconds;
        soundController.playerPickedUpShield(pickup.tilePosition);
        break;
      default:
        throw Exception('Unknown pickup type ${pickup.type}');
    }
    _removePickup(pickup);
    onPickedUp(pickup);
  }

  void removePickupAt(int col, int row) {
    final pickup = pickups.findByColRow(col, row);
    if (pickup != null) _removePickup(pickup);
  }

  void _removePickup(Pickup pickup) {
    pickups.removePickup(pickup.id);
    colliders.removePickup(pickup);
  }
}
