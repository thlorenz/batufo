import 'dart:math';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/sound_model.dart';
import 'package:batufo/universe.dart';

// final _log = Log<SoundController>();

const audibleDistanceFactor = 60e3;

class SoundController {
  Universe universe;
  final Sound _sound;
  final SoundModel _soundModel;

  SoundController(this._sound) : _soundModel = SoundModel();

  double _volumeForPosition(TilePosition position, double maxVolume) {
    final distance = _distanceToPlayer(position);
    final volume = min(audibleDistanceFactor / distance, maxVolume);
    return volume < 0.01 ? null : volume;
  }

  void setPlayerPosition(TilePosition position) {
    _soundModel.playerPosition = position;
  }

  void playerFiredBullet({TilePosition bulletPosition}) {
    if (!universe.userSettings.soundEffectsEnabled) return;
    _soundModel.playerFiredBulletVolume = bulletPosition == null
        ? GameProps.maxFiredBulletVolume
        : _firedBulletVolumeFromPosition(bulletPosition);
  }

  void playerAppliedThrust() {
    if (!universe.userSettings.soundEffectsEnabled) return;
    _soundModel.playerAppliedThrustVolume = GameProps.appliedThrustVolume;
  }

  void bulletExplodedAt(TilePosition bulletPosition) {
    if (!universe.userSettings.soundEffectsEnabled) return;
    _soundModel.bulletExplodedVolume =
        _volumeForPosition(bulletPosition, GameProps.maxBulletExplodedVolume);
  }

  void bombExplodingAt(TilePosition bombPosition) {
    if (!universe.userSettings.soundEffectsEnabled) return;
    _soundModel.bombExplodingVolume =
        _volumeForPosition(bombPosition, GameProps.maxBombExplodingVolume);
  }

  void playerHitWallWithForce(TilePosition playerPosition, double force) {
    if (!universe.userSettings.soundEffectsEnabled) return;
    final distance = min(_distanceToPlayer(playerPosition), 1.0);
    final fullForceVolume = min(audibleDistanceFactor / distance, 1.0);
    final volume = min(
      fullForceVolume * force,
      GameProps.maxPlayerHitWallVolume,
    );
    if (volume < 0.01) return;
    _soundModel.playerHitWallVolume = volume;
  }

  void playerPickedUpMedkit(TilePosition playerPosition) {
    if (!universe.userSettings.soundEffectsEnabled) return;
    _soundModel.playerPickedUpMedkitVolume =
        _volumeForPosition(playerPosition, GameProps.maxPickupMedkitVolume);
  }

  void playerPickedUpShield(TilePosition playerPosition) {
    if (!universe.userSettings.soundEffectsEnabled) return;
    _soundModel.playerPickedUpShieldVolume =
        _volumeForPosition(playerPosition, GameProps.maxPickupShieldVolume);
  }

  void playerPickedUpBomb(TilePosition playerPosition) {
    if (!universe.userSettings.soundEffectsEnabled) return;
    _soundModel.playerPickedUpBombVolume =
        _volumeForPosition(playerPosition, GameProps.maxPickupBombVolume);
  }

  void playerSwitchedWeapon() {
    _soundModel.playerSwitchedWeapon = true;
  }

  void playerTeleported() {
    _soundModel.playerTeleported = true;
  }

  void processSounds() {
    if (_soundModel.playerFiredBullet)
      _sound.playBullet(_soundModel.playerFiredBulletVolume);
    if (_soundModel.bulletExploded)
      _sound.playBulletExploded(_soundModel.bulletExplodedVolume);
    if (_soundModel.bombExploding)
      _sound.playBombExploding(_soundModel.bombExplodingVolume);
    if (_soundModel.playerAppliedThrust)
      _sound.playThrust(_soundModel.playerAppliedThrustVolume);
    if (_soundModel.playerHitWall)
      _sound.playPlayerHitWall(_soundModel.playerHitWallVolume);
    if (_soundModel.playerPickedUpMedkit)
      _sound.playPickupMedkit(_soundModel.playerPickedUpMedkitVolume);
    if (_soundModel.playerPickedUpShield)
      _sound.playPickupShield(_soundModel.playerPickedUpShieldVolume);
    if (_soundModel.playerPickedUpBomb)
      _sound.playPickupBomb(_soundModel.playerPickedUpBombVolume);
    if (_soundModel.playerSwitchedWeapon) _sound.playSwitchWeapon();
    if (_soundModel.playerTeleported) _sound.playTeleport();
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
