import 'dart:ui' show Canvas, Rect;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game_props.dart';
import 'package:flutter/material.dart';

Paint _debugHitTilePaint = Paint()
  ..color = Colors.red
  ..strokeWidth = 0.5
  ..style = PaintingStyle.stroke;

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

  void render(Canvas canvas, Rect visibleRect) {
    for (final rect in _rects) {
      if (!rect.overlaps(visibleRect)) continue;
      _sprite.renderRect(canvas, rect);
      _renderDebugHitTile(canvas, rect);
    }
  }

  void _renderDebugHitTile(Canvas canvas, Rect rect) {
    if (!GameProps.debugWallHitTile) return;
    canvas.drawRect(rect, _debugHitTilePaint);
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
