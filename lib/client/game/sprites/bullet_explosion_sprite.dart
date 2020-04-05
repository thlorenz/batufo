import 'dart:ui' show Canvas, Offset;

import 'package:batufo/client/engine/sprite_sheet.dart';
import 'package:batufo/client/engine/sprite_sheet_animation.dart';
import 'package:batufo/client/game/assets/assets.dart';
import 'package:batufo/client/game/assets/image_asset.dart';
import 'package:batufo/shared/engine/geometry/conversions.dart';
import 'package:batufo/shared/engine/geometry/dart_geometry.dart' as geo;
import 'package:flutter/foundation.dart';

class BulletExplosionSprite {
  static ImageAsset asset = assets.bulletExplosion;
  final SpriteSheetAnimation _spriteSheetAnimation;
  final double width;
  final double height;
  Offset center;

  BulletExplosionSprite(
    geo.Offset center, {
    @required this.width,
    @required this.height,
    @required double animationDurationMs,
  }) : _spriteSheetAnimation = SpriteSheetAnimation(
          SpriteSheet.fromImageAsset(asset),
          animationDurationMs,
          loop: false,
        ) {
    this.center = uiOffset(center);
  }

  bool get done => _spriteSheetAnimation.done;

  void update(double dt) {
    _spriteSheetAnimation.update(dt);
  }

  void render(Canvas canvas) {
    if (done) return;
    _spriteSheetAnimation.sprite.render(
      canvas,
      center,
      width: width,
      height: height,
    );
  }
}
