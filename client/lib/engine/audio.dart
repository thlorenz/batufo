import 'dart:io' show File;

import 'package:audioplayers/audio_cache.dart' show AudioCache;
import 'package:audioplayers/audioplayers.dart' show AudioPlayer, PlayerMode;

class Audio {
  final AudioCache _audioCache;

  Audio({String prefix = ''}) : _audioCache = AudioCache(prefix: prefix);

  Future<List<File>> loadAll(List<String> files) {
    return _audioCache.loadAll(files);
  }

  Future<AudioPlayer> playSound(String file, {double volume = 1.0}) {
    return _audioCache.play(file, volume: volume, mode: PlayerMode.LOW_LATENCY);
  }

  void disableLog() {
    _audioCache.disableLog();
  }

  static final _instance = Audio();
  static Audio get instance => _instance;
}
