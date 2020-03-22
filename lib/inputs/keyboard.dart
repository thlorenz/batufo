import 'package:flutter/services.dart';

enum GameKey { Left, Right, Up }

class GameKeyboard {
  static Set<GameKey> get pressedKeys {
    return Set.from(RawKeyboard.instance.physicalKeysPressed
        .map(_toGameKey)
        .where((x) => x != null));
  }

  static GameKey _toGameKey(PhysicalKeyboardKey e) {
    if (e == PhysicalKeyboardKey.arrowLeft || e == PhysicalKeyboardKey.keyA) {
      return GameKey.Left;
    }
    if (e == PhysicalKeyboardKey.arrowRight || e == PhysicalKeyboardKey.keyD) {
      return GameKey.Right;
    }
    if (e == PhysicalKeyboardKey.arrowUp || e == PhysicalKeyboardKey.keyW) {
      return GameKey.Up;
    }
    return null;
  }
}
