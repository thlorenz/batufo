import 'package:batufo/game/sound/sound.dart';
import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';
import 'package:flutter/material.dart';

Future<void> webMainEntry(String serverIP) {
  WidgetsFlutterBinding.ensureInitialized();
  final config = getConfig(platform: PlatformType.Web);

  final sound = DisabledSound();
  return mainEntry(
    serverIP: serverIP,
    config: config,
    sound: sound,
  );
}
