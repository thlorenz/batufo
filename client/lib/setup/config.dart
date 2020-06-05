import 'dart:io';

import 'package:flutter/foundation.dart';

enum PlatformType { MacOS, Android, Linux, Windows, IOS, Fuchsia, Web }

PlatformType getPlatform() {
  try {
    if (Platform.isLinux) return PlatformType.Linux;
    if (Platform.isMacOS) return PlatformType.MacOS;
    if (Platform.isWindows) return PlatformType.Windows;
    if (Platform.isAndroid) return PlatformType.Android;
    if (Platform.isIOS) return PlatformType.IOS;
    if (Platform.isFuchsia) return PlatformType.Fuchsia;
    return PlatformType.Web;
    // ignore: avoid_catches_without_on_clauses, empty_catches
  } catch (err) {
    return PlatformType.Web;
  }
}

class Config {
  final String title;
  final PlatformType platform;
  Config({
    @required this.title,
    @required this.platform,
  });
}

Config getConfig({PlatformType platform}) {
  final envVars = {'TITLE': 'batufo'};
  try {
    final platEnvTitle = Platform.environment['TITLE'];
    final stringEnvTitle = String.fromEnvironment(
      'TITLE',
      defaultValue: envVars['TITLE'],
    );
    envVars['TITLE'] = platEnvTitle != null && platEnvTitle.isNotEmpty
        ? platEnvTitle
        : stringEnvTitle;
    // ignore: avoid_catches_without_on_clauses, empty_catches
  } catch (err) {}
  final platform = getPlatform();
  return Config(
    title: envVars['TITLE'],
    platform: platform ?? getPlatform(),
  );
}
