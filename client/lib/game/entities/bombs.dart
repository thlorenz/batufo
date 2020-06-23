import 'dart:ui' show Canvas;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/models/bomb_model.dart';
import 'package:flutter/foundation.dart';

class Bombs {
  final Sprite _bombSprite;
  final double tileSize;
  Bombs({@required this.tileSize})
      : _bombSprite = Sprite.fromImageAsset(assets.bomb);

  void render(Canvas canvas, Iterable<BombModel> bombs) {
    for (final bomb in bombs) {
      if (bomb.isExploding || bomb.hasExploded) return;
      _renderBomb(canvas, bomb);
    }
  }

  void _renderBomb(Canvas canvas, BombModel bomb) {
    final center = bomb.tilePosition.toWorldPosition().toOffset();
    final r = tileSize * 0.8;
    _bombSprite.render(canvas, center, width: r, height: r);
  }
}
