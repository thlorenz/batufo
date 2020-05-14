import 'dart:async';

import 'package:logging/logging.dart';

export 'package:logging/logging.dart' show Level;

Type _typeOf<T>() => T;

String iconFromLevel(Level level) {
  if (level == Level.SHOUT) return '😱';
  if (level == Level.SEVERE) return '⛔';
  if (level == Level.WARNING) return '⚠️';
  if (level == Level.INFO) return '💡';
  if (level == Level.CONFIG) return '⚙️';
  if (level == Level.FINE) return '🔊';
  if (level == Level.FINER) return '🔉';
  if (level == Level.FINEST) return '🔈';
  return '';
}

String iconFromText(String msg) {
  if (msg.startsWith('creat')) return '🐥';
  if (msg.startsWith('dispos')) return '♻️';
  return null;
}

class Log<T extends Object> {
  Log() : _logger = Logger(_typeOf<T>().toString());
  final Logger _logger;

  static void filterObjectLifeTime() {
    messageFilter = (s) => s.startsWith('creat') || s.startsWith('dispos');
  }

  static bool Function(String) messageFilter;

  static set rootLevel(Level value) {
    Logger.root.level = value;
  }

  static DateTime startTime = DateTime.now();

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get shout => _logger.shout;

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get severe => _logger.severe;

  static void activateConsole() {
    Logger.root.onRecord.listen((record) {
      if (messageFilter != null && messageFilter(record.message)) {
        return;
      }
      final icon = iconFromText(record.message) ?? iconFromLevel(record.level);
      final timeDiff =
          record.time.difference(startTime).toString().substring(0, 10);
      String message = record.message;
      if (record.error != null) message += ' [${record.error}]';
      if (record.stackTrace != null) message += record.stackTrace.toString();
      print('$timeDiff $icon ${record.loggerName}: $message');
    });
  }

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get warning => _logger.warning;

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get info => _logger.info;

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get config => _logger.config;

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get fine => _logger.fine;

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get finer => _logger.finer;

  void Function(dynamic message, [Object error, StackTrace stackTrace])
      get finest => _logger.finest;

  Map<String, Logger> get children => _logger.children;
  void Function() get clearListeners => _logger.clearListeners;
  String get fullName => _logger.fullName;
  bool Function(Level value) get isLoggable => _logger.isLoggable;
  Level get level => _logger.level;
  String get name => _logger.name;
  Stream<LogRecord> get onRecord => _logger.onRecord;
  Logger get parent => _logger.parent;
}
