import 'dart:math';
import 'dart:ui' show Canvas, Offset, Paint, PaintingStyle, Rect;

import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/sprites/thrust_sprite.dart';
import 'package:batufo/game/visuals.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;

const pipi = 2 * pi;

Paint _debugHitTilePaint = Paint()
  ..color = Colors.amberAccent
  ..strokeWidth = 0.5
  ..style = PaintingStyle.stroke;

Paint _healthPaint = Paint()
  ..strokeWidth = 3.0
  ..style = PaintingStyle.stroke;

Paint _shieldPaint = Paint()
  ..color = Colors.green
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

  void render(Canvas canvas, PlayerModel player, bool isHero) {
    final playerTilePosition = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    final playerSprite =
        PlayerStatus.isDead(player) ? deadPlayerSprite : alivePlayerSprite;
    canvas.save();
    {
      canvas
        ..translate(center.x, center.y)
        ..rotate(player.angle);

      if (!isHero) _renderPlayerHealth(canvas, player);
      if (player.hasShield) {
        _renderShield(canvas, player.shieldSecondsRemaining);
      }

      playerSprite.render(
        canvas,
        Offset.zero,
        width: tileSize,
        height: tileSize,
      );
      _renderDebugHitTile(canvas, player);

      thrustSprite.render(canvas, Offset.zero, tileSize);
    }
    canvas.restore();
  }

  void _renderDebugHitTile(Canvas canvas, PlayerModel player) {
    if (!GameProps.debugPlayerHitTile) return;
    final radius = hitSize / 2;
    final rect = Rect.fromLTWH(-radius, -radius, hitSize, hitSize);
    canvas.drawRect(rect, _debugHitTilePaint);
  }

  void _renderPlayerHealth(Canvas canvas, PlayerModel player) {
    final color = healthColor(player.health);
    _renderArcIndicatingPercent(
      canvas,
      hitSize / 2 * 1.1,
      player.health / GameProps.playerTotalHealth,
      _healthPaint..color = color,
    );
  }

  void _renderArcIndicatingPercent(
      Canvas canvas, double radius, double percent, Paint paint) {
    final remaining = 2 * pi * percent;
    final missing = 2 * pi - remaining;
    final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
    canvas.drawArc(rect, missing / 2, remaining, false, paint);
  }

  void _renderShield(Canvas canvas, double shieldSecondsRemaining) {
    final width =
        (shieldSecondsRemaining / GameProps.shieldDurationSeconds) * 5.0;
    final paint = _shieldPaint..strokeWidth = width;

    final radius = hitSize / 2 * 1.7;
    final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
    canvas.drawArc(rect, 0, pipi, false, paint);
  }
}
