import 'dart:math';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/sound_model.dart';

// final _log = Log<SoundController>();

const audibleDistanceFactor = 60e3;

class SoundController {
  final Sound _sound;
  final SoundModel _soundModel;

  SoundController(this._sound) : _soundModel = SoundModel();

  void setPlayerPosition(TilePosition position) {
    _soundModel.playerPosition = position;
  }

  void playerFiredBullet({TilePosition bulletPosition}) {
    if (!GameProps.soundEnabled) return;
    _soundModel.playerFiredBulletVolume = bulletPosition == null
        ? GameProps.maxFiredBulletVolume
        : _firedBulletVolumeFromPosition(bulletPosition);
  }

  void playerAppliedThrust() {
    if (!GameProps.soundEnabled) return;
    _soundModel.playerAppliedThrustVolume = GameProps.appliedThrustVolume;
  }

  void bulletExplodedAt(TilePosition bulletPosition) {
    if (!GameProps.soundEnabled) return;
    final distance = _distanceToPlayer(bulletPosition);
    final volume = min(
        audibleDistanceFactor / distance, GameProps.maxBulletExplodedVolume);
    if (volume < 0.01) return;
    _soundModel.bulletExplodedVolume = volume;
  }

  void playerHitWallWithForce(TilePosition playerPosition, double force) {
    if (!GameProps.soundEnabled) return;
    final distance = min(_distanceToPlayer(playerPosition), 1.0);
    final fullForceVolume = min(audibleDistanceFactor / distance, 1.0);
    final volume = min(
      fullForceVolume * force,
      GameProps.maxPlayerHitWallVolume,
    );
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

  double _distanceToPlayer(TilePosition position) {
    assert(_soundModel.playerPosition != null,
        'need player position to calculate distance');
    final player = _soundModel.playerPosition.toWorldOffset();
    final wp = position.toWorldOffset();
    final diff = player - wp;
    return diff.distanceSquared;
  }

  double _firedBulletVolumeFromPosition(TilePosition bulletPosition) {
    final distance = _distanceToPlayer(bulletPosition);
    final volume =
        min(audibleDistanceFactor / distance, GameProps.maxFiredBulletVolume);
    return volume < 0.01 ? null : volume;
  }
}
