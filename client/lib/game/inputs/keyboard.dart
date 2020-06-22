import 'package:batufo/game/inputs/input_types.dart';
import 'package:flutter/services.dart';

class GameKeyboard {
  static GameKeys get pressedKeys {
    final keys = GameKeys();
    for (final lk in RawKeyboard.instance.keysPressed) {
      final bits = _toGameKey(lk);
      if (bits != null) keys.add(bits);
    }
    return keys;
  }

  static int _toGameKey(LogicalKeyboardKey e) {
    if (e == LogicalKeyboardKey.arrowLeft || e == LogicalKeyboardKey.keyA) {
      return GameKey.Left;
    }
    if (e == LogicalKeyboardKey.arrowRight || e == LogicalKeyboardKey.keyD) {
      return GameKey.Right;
    }
    if (e == LogicalKeyboardKey.arrowUp || e == LogicalKeyboardKey.keyW) {
      return GameKey.Up;
    }
    if (e == LogicalKeyboardKey.arrowDown || e == LogicalKeyboardKey.keyS) {
      return GameKey.Down;
    }
    if (e == LogicalKeyboardKey.space) {
      return GameKey.Fire;
    }
    return null;
  }
}
