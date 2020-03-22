import 'dart:math';
import 'dart:ui';

import 'package:batufo/engine/sprite_sheet.dart';
import 'package:batufo/game_props.dart';
import 'package:flutter/material.dart';

class ThrustSprite {
  static ImageAsset asset = GameProps.assets.thrust;
  final SpriteSheet _spriteSheet;
  final double width;
  final double height;

  ThrustSprite({@required this.width, @required this.height})
      : _spriteSheet = SpriteSheet.fromImageAsset(asset);

  void render(Canvas canvas, Offset playerCenter, double playerWidth) {
    final center = Offset(playerCenter.dx - playerWidth / 2, playerCenter.dy);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pi / 2);
    _spriteSheet.getIndex(10).render(
          canvas,
          Offset.zero,
          width: width,
          height: height,
        );
    canvas.restore();
  }
}
