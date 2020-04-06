import 'dart:ui' show Canvas, Offset, Paint, PaintingStyle, Rect;

import 'package:batufo/client/engine/sprite.dart';
import 'package:batufo/client/game/sprites/thrust_sprite.dart';
import 'package:batufo/shared/engine/world_position.dart';
import 'package:batufo/shared/game_props.dart';
import 'package:batufo/shared/models/player_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;

Paint _debugHitTilePaint = Paint()
  ..color = Colors.amberAccent
  ..strokeWidth = 0.5
  ..style = PaintingStyle.stroke;

class Player {
  Sprite playerSprite;
  ThrustSprite thrustSprite;
  final double tileSize;
  final double hitSize;

  Player({
    String playerImagePath,
    @required this.tileSize,
    @required this.hitSize,
    @required double thrustAnimationDurationMs,
  }) {
    playerSprite = Sprite(playerImagePath);
    thrustSprite = ThrustSprite(
      width: tileSize / 2,
      height: tileSize / 2,
      animationDurationMs: thrustAnimationDurationMs,
    );
  }

  void updateSprites(PlayerModel player, double dt) {
    if (player.appliedThrustForce != 0) thrustSprite.reset();
    thrustSprite.update(dt);
  }

  void render(Canvas canvas, PlayerModel player) {
    final playerTilePosition = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    canvas.save();
    {
      canvas
        ..translate(center.x, center.y)
        ..rotate(player.angle);
      playerSprite.render(canvas, Offset.zero,
          width: tileSize, height: tileSize);
      thrustSprite.render(canvas, Offset.zero, tileSize);
      _renderDebugHitTile(canvas, player);
    }
    canvas.restore();
  }

  void _renderDebugHitTile(Canvas canvas, PlayerModel player) {
    if (!GameProps.debugPlayerHitTile) return;
    final radius = hitSize / 2;
    final rect = Rect.fromLTWH(-radius, -radius, hitSize, hitSize);
    canvas.drawRect(rect, _debugHitTilePaint);
  }
}
