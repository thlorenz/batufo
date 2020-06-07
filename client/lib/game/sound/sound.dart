import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:batufo/engine/audio.dart';
import 'package:batufo/game/assets/audio_asset.dart';

class Sound {
  final Audio _audio;
  final Map<String, AudioAsset> _audioAssets;
  AudioPlayer _thrust;

  Sound(this._audioAssets) : _audio = Audio.instance;

  Future<List<File>> _load() {
    return _audio.loadAll(_audioAssets.values.map((x) => x.audioPath).toList());
  }

  Future<void> playThrust() async {
    if (_thrust != null) {
      await _thrust.stop();
      await _thrust.seek(Duration.zero);
      await _thrust.resume();
    } else {
      _thrust = await _audio.playSound(_audioAssets['thrust'].audioPath);
    }
  }

  Future<void> stopThrust() {
    if (_thrust == null) return Future.value();
    return _thrust.stop();
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
