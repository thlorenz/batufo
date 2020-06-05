import 'package:batufo/main/main.dart';
import 'package:batufo/setup/config.dart';

Future<void> webMainEntry(String serverIP) {
  final config = getConfig(platform: PlatformType.Web);

  return mainEntry(
    serverIP: serverIP,
    config: config,
  );
}
