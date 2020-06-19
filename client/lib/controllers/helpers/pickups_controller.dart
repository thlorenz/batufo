import 'package:batufo/arena/pickup.dart';
import 'package:batufo/controllers/helpers/colliders.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/game/entities/pickups.dart';
import 'package:batufo/models/pickups_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class PickupsController {
  final SoundController soundController;
  final PickupsModel pickups;
  final Pickups pickupsEntity;
  final Colliders colliders;

  PickupsController({
    @required this.pickups,
    @required this.pickupsEntity,
    @required this.colliders,
    @required this.soundController,
  });

  void update(PlayerModel player) {
    final pickup = colliders.playerPickingUpAt(player.tilePosition);
    if (pickup == null) return;
    switch (pickup.type) {
      case PickupType.Medkit:
        break;
      case PickupType.Shield:
        soundController.playerPickedUpShield(pickup.tilePosition);
        break;
      default:
        throw Exception('Unknown pickup type ${pickup.type}');
    }
  }

  void removePickup(String id) {
    pickups.removePickup(id);
    pickupsEntity.update();
  }
}
