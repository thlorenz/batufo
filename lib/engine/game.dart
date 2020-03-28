import 'dart:ui' show Canvas;

import 'package:batufo/engine/geometry/dart_geometry.dart' show Size;
import 'package:flutter/foundation.dart';

abstract class Game {
  /// dt: delta time since last update in ms with microsecond resolution
  /// ts: time since last epoch in ms with microsecond resolution
  void update(double dt, double ts);
  void render(Canvas canvas);
  void resize(Size size);

  @mustCallSuper
  void onAttach() {
    debugPrint('game attached');
  }

  @mustCallSuper
  void onDetach() {
    debugPrint('game detached');
  }
}
