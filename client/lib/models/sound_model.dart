import 'package:batufo/engine/tile_position.dart';

class SoundModel {
  TilePosition playerPosition;
  double playerFiredBulletVolume;
  double playerHitWallVolume;
  double playerAppliedThrustVolume;
  double bulletExplodedVolume;
  double bombExplodingVolume;
  double playerPickedUpMedkitVolume;
  double playerPickedUpShieldVolume;
  double playerPickedUpBombVolume;
  bool playerSwitchedWeapon = false;
  bool playerTeleported = false;

  SoundModel() {
    clear();
  }

  bool get playerFiredBullet => playerFiredBulletVolume != null;
  bool get playerAppliedThrust => playerAppliedThrustVolume != null;
  bool get playerHitWall => playerHitWallVolume != null;
  bool get bulletExploded => bulletExplodedVolume != null;
  bool get bombExploding => bombExplodingVolume != null;
  bool get playerPickedUpMedkit => playerPickedUpMedkitVolume != null;
  bool get playerPickedUpShield => playerPickedUpShieldVolume != null;
  bool get playerPickedUpBomb => playerPickedUpBombVolume != null;

  void clear() {
    playerHitWallVolume = null;
    playerAppliedThrustVolume = null;
    playerFiredBulletVolume = null;
    bulletExplodedVolume = null;
    bombExplodingVolume = null;
    playerPickedUpShieldVolume = null;
    playerPickedUpMedkitVolume = null;
    playerPickedUpBombVolume = null;
    playerSwitchedWeapon = false;
    playerTeleported = false;
  }
}
