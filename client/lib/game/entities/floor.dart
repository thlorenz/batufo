import 'dart:ui' show Canvas, Rect;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/sprite_sheet.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/assets/assets.dart';

class FloorTileSprite {
  final Rect rect;
  final Sprite sprite;

  FloorTileSprite(this.rect, this.sprite);

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}

class Floor {
  final SpriteSheet _spriteSheet;
  final List<TilePosition> _floorTiles;
  final List<FloorTileSprite> _backgroundSprites;
  final double _tileSize;
  final bool _isActive;
  Floor(this._floorTiles, this._tileSize, this._isActive)
      : _spriteSheet = SpriteSheet.fromImageAsset(assets.floorTiles),
        _backgroundSprites = <FloorTileSprite>[] {
    _initTiles();
  }

  void render(Canvas canvas, Rect visibleRect) {
    if (!_isActive) return;
    for (final bs in _backgroundSprites) {
      if (bs.rect.overlaps(visibleRect)) bs.render(canvas);
    }
  }

  void _initTiles() {
    if (!_isActive) return;

    _backgroundSprites.clear();

    final w = _tileSize;
    for (int i = 0; i < _floorTiles.length; i++) {
      final tile = _floorTiles[i];
      final wp = tile.toWorldPosition();
      final rect = Rect.fromLTWH(wp.x - w / 2, wp.y - w / 2, w, w);
      const nrows = 20;

      final sheetRow = i % 7;
      final sheetCol = (i ~/ nrows) % 7;
      final sprite = _spriteSheet.getRowCol(sheetRow, sheetCol);
      final backgroundSprite = FloorTileSprite(rect, sprite);
      _backgroundSprites.add(backgroundSprite);
    }
  }
}
