import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/sound/enabled_sound.dart';
import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart'
    show setWindowMaxSize, setWindowMinSize;

Future<void> destopMainEntry(String serverIP) async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = getConfig();
  final minSize = Size(640, 640);
  // Once we go beyond this size fps can half so we try to avoid that.
  final maxSize = Size(1920, 1080);
  try {
    setWindowMinSize(minSize);
    setWindowMaxSize(maxSize);
    // ignore: avoid_catches_without_on_clauses, empty_catches
  } catch (err) {}

  final sound = await EnabledSound.create(audioAssets);
  return mainEntry(
    serverIP: serverIP,
    config: config,
    sound: sound,
  );
}
