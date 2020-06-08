import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:batufo/engine/audio.dart';
import 'package:batufo/game/assets/audio_asset.dart';

class Sound {
  final Audio _audio;
  final Map<String, AudioAsset> _audioAssets;

  Sound(this._audioAssets) : _audio = Audio.instance;

  Future<List<File>> _load() {
    return _audio.loadAll(_audioAssets.values.map((x) => x.audioPath).toList());
  }

  Future<AudioPlayer> playThrust() {
    return _audio.playSound(
      _audioAssets['thrust'].audioPath,
      volume: 0.4,
    );
  }

  Future<AudioPlayer> playBullet() {
    return _audio.playSound(
      _audioAssets['bullet'].audioPath,
      volume: 0.6,
    );
  }

  // TODO: adjust volume depending on distance of hero player
  Future<AudioPlayer> playBulletHitWall() {
    return _audio.playSound(
      _audioAssets['bullet-hit-wall'].audioPath,
      volume: 0.4,
    );
  }

  // TODO: take power with which we hit the wall into acoount
  Future<AudioPlayer> playUfoHitWall() {
    return _audio.playSound(
      _audioAssets['ufo-hit-wall'].audioPath,
      volume: 0.6,
    );
  }

  static Sound _instance;
  static Sound get instance => _instance;
  static Future<Sound> create(Map<String, AudioAsset> audioAssets) async {
    assert(_instance == null, 'only one audio instance allowed');
    _instance = Sound(audioAssets);
    await _instance._load();
    return _instance;
  }
}
