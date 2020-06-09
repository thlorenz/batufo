import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:batufo/engine/audio.dart';
import 'package:batufo/game/assets/audio_asset.dart';
import 'package:batufo/game/sound/sound.dart';

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

  Future<AudioPlayer> playPlayerHitWall(double volume) {
    return _audio.playSound(
      _audioAssets['player-hit-wall'].audioPath,
      volume: volume,
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
