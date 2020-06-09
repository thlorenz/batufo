import 'dart:math';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/sound_model.dart';

// final _log = Log<SoundController>();

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
    _soundModel.playerAppliedThrustVolume = GameProps.appliedThrustVolume;
  }

  void bulletExplodedAt(TilePosition tilePosition) {
    assert(_soundModel.playerPosition != null,
        'need player position to calculate explosion volume');
    final player = _soundModel.playerPosition.toWorldOffset();
    final bullet = tilePosition.toWorldOffset();
    final diff = player - bullet;
    final distance = diff.distanceSquared;
    final volume = min(60e3 / distance, GameProps.maxBulletExplodedVolume);
    if (volume < 0.01) return;
    _soundModel.bulletExplodedVolume = volume;
  }

  void playerHitWallWithForce(double force) {
    final volume = min(force, GameProps.maxPlayerHitWallVolume);
    if (volume < 0.01) return;
    _soundModel.playerHitWallVolume = volume;
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
