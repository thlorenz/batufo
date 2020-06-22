import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/sound/enabled_sound.dart';
import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> mobileMainEntry(String serverIP) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  final config = getConfig();

  final sound = await EnabledSound.create(audioAssets);

  return mainEntry(
    serverIP: serverIP,
    config: config,
    sound: sound,
  );
}
