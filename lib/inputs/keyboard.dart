import 'package:flutter/services.dart';

enum GameKey { Left, Right, Up, Fire }

class GameKeyboard {
  static Set<GameKey> get pressedKeys {
    return Set.from(RawKeyboard.instance.keysPressed
        .map(_toGameKey)
        .where((x) => x != null));
  }

  static GameKey _toGameKey(LogicalKeyboardKey e) {
    if (e == LogicalKeyboardKey.arrowLeft || e == LogicalKeyboardKey.keyA) {
      return GameKey.Left;
    }
    if (e == LogicalKeyboardKey.arrowRight || e == LogicalKeyboardKey.keyD) {
      return GameKey.Right;
    }
    if (e == LogicalKeyboardKey.arrowUp || e == LogicalKeyboardKey.keyW) {
      return GameKey.Up;
    }
    if (e == LogicalKeyboardKey.space) {
      return GameKey.Fire;
    }
    return null;
  }
}
