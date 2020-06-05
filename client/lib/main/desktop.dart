import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';

Future<void> destopMainEntry(String serverIP) {
  final config = getConfig();
  return mainEntry(
    serverIP: serverIP,
    config: config,
  );
}
