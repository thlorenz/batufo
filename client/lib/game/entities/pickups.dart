import 'dart:ui';

import 'package:batufo/arena/pickup.dart';
import 'package:batufo/engine/sprite.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/models/pickups_model.dart';

class PickupEntity {
  final String id;
  final Rect rect;
  final Sprite sprite;
  PickupEntity(this.id, this.rect, this.sprite);

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}

class Pickups {
  final Sprite _medkitSprite;
  final Sprite _shieldSprite;
  final PickupsModel _pickups;
  final List<PickupEntity> _pickupEntities;

  final int _tileSize;

  Pickups(this._pickups, this._tileSize)
      : _medkitSprite = Sprite.fromImageAsset(assets.medkit),
        _shieldSprite = Sprite.fromImageAsset(assets.shield),
        _pickupEntities = <PickupEntity>[] {
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

  Sprite _spriteFor(PickupType type) {
    switch (type) {
      case PickupType.Medkit:
        return _medkitSprite;
      case PickupType.Shield:
        return _shieldSprite;
      default:
        throw Exception('Unknown pickup type $type');
    }
  }

  void _initRects() {
    _pickupEntities.clear();
    final w = _tileSize.toDouble() * 0.7;
    for (final pickup in _pickups.pickups) {
      final wp = pickup.tilePosition.toWorldPosition();
      final rect = Rect.fromLTWH(wp.x - w / 2, wp.y - w / 2, w, w);
      final sprite = _spriteFor(pickup.type);
      _pickupEntities.add(PickupEntity(pickup.id, rect, sprite));
    }
  }
}
