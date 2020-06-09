import 'package:batufo/engine/tile_position.dart';

class SoundModel {
  TilePosition playerPosition;
  double playerFiredBulletVolume;
  double playerHitWallVolume;
  double playerAppliedThrustVolume;
  double bulletExplodedVolume;

  SoundModel() {
    clear();
  }

  bool get playerFiredBullet => playerFiredBulletVolume != null;
  bool get playerAppliedThrust => playerAppliedThrustVolume != null;
  bool get playerHitWall => playerHitWallVolume != null;
  bool get bulletExploded => bulletExplodedVolume != null;

  void clear() {
    playerHitWallVolume = null;
    playerAppliedThrustVolume = null;
    playerFiredBulletVolume = null;
    bulletExplodedVolume = null;
  }
}
