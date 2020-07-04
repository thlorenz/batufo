import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:batufo/engine/audio.dart';
import 'package:batufo/game/assets/audio_asset.dart';
import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/game_props.dart';

class EnabledSound implements Sound {
  final Audio _audio;
  final Map<String, AudioAsset> _audioAssets;

  EnabledSound(this._audioAssets) : _audio = Audio.instance;

  Future<List<File>> _load() {
    return _audio.loadAll(_audioAssets.values.map((x) => x.audioPath).toList());
  }

  Future<void> playThrust(double volume) {
    return _audio.playSound(
      _audioAssets['thrust'].audioPath,
      volume: volume,
    );
  }

  Future<void> playBullet(double volume) {
    return _audio.playSound(
      _audioAssets['bullet'].audioPath,
      volume: volume,
    );
  }

  Future<void> playBulletExploded(double volume) {
    return _audio.playSound(
      _audioAssets['bullet-exploded'].audioPath,
      volume: volume,
    );
  }

  Future<void> playBombExploding(double volume) {
    return _audio.playSound(
      _audioAssets['bomb-exploding'].audioPath,
      volume: volume,
    );
  }

  Future<AudioPlayer> playPlayerHitWall(double volume) {
    return _audio.playSound(
      _audioAssets['player-hit-wall'].audioPath,
      volume: volume,
    );
  }

  Future<AudioPlayer> playPickupShield(double volume) {
    return _audio.playSound(
      _audioAssets['pickup-shield'].audioPath,
      volume: volume,
    );
  }

  Future<AudioPlayer> playPickupBomb(double volume) {
    return _audio.playSound(
      _audioAssets['pickup-bomb'].audioPath,
      volume: volume,
    );
  }

  Future<AudioPlayer> playPickupMedkit(double volume) {
    return _audio.playSound(
      _audioAssets['pickup-medkit'].audioPath,
      volume: volume,
    );
  }

  Future<AudioPlayer> playSwitchWeapon() {
    return _audio.playSound(
      _audioAssets['switch-weapon'].audioPath,
      volume: GameProps.switchWeaponVolume,
    );
  }

  Future<AudioPlayer> playTeleport() {
    return _audio.playSound(
      _audioAssets['teleport'].audioPath,
      volume: GameProps.teleportVolume,
    );
  }

  void disableLog() {
    _audio.disableLog();
  }

  static EnabledSound _instance;
  static Sound get instance => _instance;
  static Future<Sound> create(Map<String, AudioAsset> audioAssets) async {
    assert(_instance == null, 'only one audio instance allowed');
    _instance = EnabledSound(audioAssets);
    await _instance._load();
    return _instance;
  }
}
