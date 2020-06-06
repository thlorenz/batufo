import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> mobileMainEntry(String serverIP) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  final config = getConfig();

  return mainEntry(
    serverIP: serverIP,
    config: config,
  );
}
