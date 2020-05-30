import 'dart:ui' show Canvas, Offset, Paint, PaintingStyle, Rect;

import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/sprites/thrust_sprite.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;

Paint _debugHitTilePaint = Paint()
  ..color = Colors.amberAccent
  ..strokeWidth = 0.5
  ..style = PaintingStyle.stroke;

class Player {
  Sprite alivePlayerSprite;
  Sprite deadPlayerSprite;
  ThrustSprite thrustSprite;
  final double tileSize;
  final double hitSize;

  Player({
    @required String playerImagePath,
    @required String deadPlayerImagePath,
    @required this.tileSize,
    @required this.hitSize,
    @required double thrustAnimationDurationMs,
  }) {
    alivePlayerSprite = Sprite(playerImagePath);
    deadPlayerSprite = Sprite(deadPlayerImagePath);
    thrustSprite = ThrustSprite(
      width: tileSize / 2,
      height: tileSize / 2,
      animationDurationMs: thrustAnimationDurationMs,
    );
  }

  void updateSprites(PlayerModel player, double dt) {
    if (PlayerStatus.isDead(player)) return;
    if (player.appliedThrust) thrustSprite.reset();
    thrustSprite.update(dt);
  }

  void render(Canvas canvas, PlayerModel player) {
    final playerTilePosition = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    final playerSprite =
        PlayerStatus.isDead(player) ? deadPlayerSprite : alivePlayerSprite;
    canvas.save();
    {
      canvas
        ..translate(center.x, center.y)
        ..rotate(player.angle);
      playerSprite.render(
        canvas,
        Offset.zero,
        width: tileSize,
        height: tileSize,
      );
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
