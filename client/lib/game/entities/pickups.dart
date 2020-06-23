import 'dart:ui';

import 'package:batufo/arena/pickup.dart';
import 'package:batufo/engine/sprite.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/models/pickups_model.dart';
import 'package:batufo/types.dart';

abstract class _Renderable {
  Rect get rect;
  void render(Canvas canvas);
}

class _PickupEntity implements _Renderable {
  final Rect rect;
  final Sprite sprite;
  _PickupEntity(this.rect, this.sprite);

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}

class _CircledPickupEntity implements _Renderable {
  final Rect rect;
  final Sprite circleSprite;
  final Sprite innerSprite;
  final Rect innerRect;

  _CircledPickupEntity(this.rect, this.circleSprite, this.innerSprite)
      : innerRect = Rect.fromCenter(
            center: rect.center,
            width: rect.width * 0.7,
            height: rect.height * 0.7);

  void render(Canvas canvas) {
    circleSprite.renderRect(canvas, rect);
    innerSprite.renderRect(canvas, innerRect);
  }
}

class Pickups {
  final Sprite _medkitSprite;
  final Sprite _shieldSprite;
  final Sprite _bombSprite;
  final Sprite _circleRedSprite;
  final PickupsModel _pickups;
  final List<_Renderable> _pickupEntities;

  final int _tileSize;

  Pickups(this._pickups, this._tileSize)
      : _medkitSprite = Sprite.fromImageAsset(assets.medkit),
        _shieldSprite = Sprite.fromImageAsset(assets.shield),
        _bombSprite = Sprite.fromImageAsset(assets.bomb),
        _circleRedSprite = Sprite.fromImageAsset(assets.circleRed),
        _pickupEntities = <_Renderable>[] {
    _initRects();
  }

  void render(Canvas canvas, Rect visibleRect) {
    for (final entity in _pickupEntities) {
      if (visibleRect != null && !entity.rect.overlaps(visibleRect)) continue;
      entity.render(canvas);
    }
  }

  void update() {
    if (_pickups.pickups.length == _pickupEntities.length) return;
    _initRects();
  }

  Tuple<Sprite, Sprite> _spritesFor(PickupType type) {
    switch (type) {
      case PickupType.Medkit:
        return Tuple(_medkitSprite, null);
      case PickupType.Shield:
        return Tuple(_shieldSprite, null);
      case PickupType.Bomb:
        return Tuple(_circleRedSprite, _bombSprite);
      default:
        throw Exception('Unknown pickup type $type');
    }
  }

  bool _drawLarge(PickupType type) {
    switch (type) {
      case PickupType.Medkit:
      case PickupType.Shield:
        return false;
      case PickupType.Bomb:
        return true;
      default:
        throw Exception('Unknown pickup type $type');
    }
  }

  void _initRects() {
    _pickupEntities.clear();
    final fw = _tileSize.toDouble() * 0.85;
    final sw = fw * 0.7;
    for (final pickup in _pickups.pickups) {
      final wp = pickup.tilePosition.toWorldPosition();
      final w = _drawLarge(pickup.type) ? fw : sw;
      final rect = Rect.fromLTWH(wp.x - w / 2, wp.y - w / 2, w, w);
      final sprites = _spritesFor(pickup.type);
      final entity = sprites.second == null
          ? _PickupEntity(rect, sprites.first)
          : _CircledPickupEntity(rect, sprites.first, sprites.second);
      _pickupEntities.add(entity);
    }
  }
}
