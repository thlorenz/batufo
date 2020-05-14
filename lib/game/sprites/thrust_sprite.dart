import 'dart:math';
import 'dart:ui' show Canvas, Offset;

import 'package:batufo/engine/sprite_sheet.dart';
import 'package:batufo/engine/sprite_sheet_animation.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/assets/image_asset.dart';
import 'package:flutter/foundation.dart';

class ThrustSprite {
  static ImageAsset asset = assets.thrust;
  final SpriteSheetAnimation _spriteSheetAnimation;
  final double width;
  final double height;

  ThrustSprite(
      {@required this.width,
      @required this.height,
      @required double animationDurationMs})
      : _spriteSheetAnimation = SpriteSheetAnimation(
          SpriteSheet.fromImageAsset(asset),
          animationDurationMs,
          loop: false,
        );

  bool get done => _spriteSheetAnimation.done;

  void update(double dt) {
    _spriteSheetAnimation.update(dt);
  }

  void render(Canvas canvas, Offset playerCenter, double playerWidth) {
    if (done) return;
    final center = Offset(playerCenter.dx - playerWidth / 2, playerCenter.dy);
    canvas.save();
    {
      canvas
        ..translate(center.dx, center.dy)
        ..rotate(pi / 2);
      _spriteSheetAnimation.sprite.render(
        canvas,
        Offset.zero,
        width: width,
        height: height,
      );
    }
    canvas.restore();
  }

  void reset() {
    _spriteSheetAnimation.reset();
  }
}
