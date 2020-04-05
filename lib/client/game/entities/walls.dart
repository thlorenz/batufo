import 'dart:ui' show Canvas, Rect;

import 'package:batufo/client/engine/sprite.dart';
import 'package:batufo/client/game/assets/assets.dart';
import 'package:batufo/shared/engine/tile_position.dart';

class Walls {
  final Sprite _sprite;
  final List<TilePosition> _walls;
  final List<Rect> _rects;
  final double _tileSize;

  Walls(this._walls, this._tileSize)
      : _sprite = Sprite.fromImageAsset(assets.wallMetal),
        _rects = <Rect>[] {
    _initRects();
  }

  void render(Canvas canvas) {
    for (final rect in _rects) {
      _sprite.renderRect(canvas, rect);
    }
  }

  void _initRects() {
    _rects.clear();
    final w = _tileSize;
    for (final wall in _walls) {
      final wp = wall.toWorldPosition();
      final rect = Rect.fromLTWH(wp.x - w / 2, wp.y - w / 2, w, w);
      _rects.add(rect);
    }
  }
}
