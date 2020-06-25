import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/sound/enabled_sound.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';
import 'package:flutter/material.dart';

// ATM results in the below, keeping this entry point to
// test regularly if things get fixed.

// Overflow on channel: plugins.flutter.io/path_provider.
// Messages on this channel are being discarded in FIFO fashion.
// The engine may not be running or you need to adjust
// the buffer size if of the channel.
Future<void> main() async {
  const serverIP = GameProps.localhost;
  WidgetsFlutterBinding.ensureInitialized();
  final config = getConfig(platform: PlatformType.Web);

  final sound = await EnabledSound.create(audioAssets);
  return mainEntry(
    serverIP: serverIP,
    config: config,
    sound: sound,
  );
}
