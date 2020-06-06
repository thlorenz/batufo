import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';
import 'package:flutter/material.dart';

Future<void> destopMainEntry(String serverIP) {
  WidgetsFlutterBinding.ensureInitialized();
  final config = getConfig();
  return mainEntry(
    serverIP: serverIP,
    config: config,
  );
}
