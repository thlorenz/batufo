import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/models/sound_model.dart';

class SoundController {
  final Sound _sound;
  final SoundModel _soundModel;

  SoundController(this._sound) : _soundModel = SoundModel();

  void setPlayerPosition(TilePosition position) {
    _soundModel.playerPosition = position;
  }

  void playerFiredBullet({TilePosition position}) {
    _soundModel.playerFiredBulletVolume =
        position == null ? 0.8 : _firedBulletVolumeFromPosition(position);
  }

  void playerAppliedThrust() {
    _soundModel.playerAppliedThrustVolume = 0.4;
  }

  void bulletExplodedAt(TilePosition tilePosition) {
    assert(_soundModel.playerPosition != null,
        'need player position to calculate explosion volume');
    // TODO: calculate volume depending on how far away from player
    _soundModel.bulletExplodedVolume = 1.0;
  }

  void playerHitWallWithForce(double force) {
    // TODO: calculate volume from health toll
    _soundModel.playerHitWallVolume = 1.0;
  }

  void processSounds() {
    if (_soundModel.playerFiredBullet)
      _sound.playBullet(_soundModel.playerFiredBulletVolume);
    if (_soundModel.bulletExploded)
      _sound.playBulletExploded(_soundModel.bulletExplodedVolume);
    if (_soundModel.playerAppliedThrust)
      _sound.playThrust(_soundModel.playerAppliedThrustVolume);
    if (_soundModel.playerHitWall)
      _sound.playPlayerHitWall(_soundModel.playerHitWallVolume);
    _soundModel.clear();
  }

  double _firedBulletVolumeFromPosition(TilePosition position) {
    return 0.4;
  }
}
