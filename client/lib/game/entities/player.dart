import 'dart:math';
import 'dart:ui' show Canvas, Offset, Paint, PaintingStyle, Rect;

import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/sprites/thrust_sprite.dart';
import 'package:batufo/game/visuals.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/teleportation_model.dart';
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
  ..style = PaintingStyle.stroke
  ..strokeWidth = 10.0;

class Player {
  Sprite alivePlayerSprite;
  Sprite deadPlayerSprite;
  ThrustSprite thrustSprite;
  final double tileSize;
  final double hitSize;
  final double teleportTotalTimeInMs;
  final double teleportStepTimeInMs;

  Player({
    @required String playerImagePath,
    @required String deadPlayerImagePath,
    @required this.tileSize,
    @required this.hitSize,
    @required double thrustAnimationDurationMs,
    @required this.teleportTotalTimeInMs,
  }) : teleportStepTimeInMs = teleportTotalTimeInMs / 2 {
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
    canvas.save();
    {
      canvas
        ..translate(center.x, center.y)
        ..rotate(player.angle);

      if (!isHero) _renderPlayerHealth(canvas, player);

      if (player.hasShield) {
        _renderShield(canvas, player.shieldRemainingMs);
      }

      _renderPlayer(canvas, player);
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

  void _renderShield(Canvas canvas, double shieldRemainingMs) {
    final alpha = (shieldRemainingMs / GameProps.shieldDurationMs) * 220;
    final paint = _shieldPaint..color = Colors.blue.withAlpha(alpha.floor());

    final radius = hitSize / 2 * GameProps.shieldRadiusFactor;
    final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
    canvas.drawArc(rect, 0, pipi, false, paint);
  }

  void _renderPlayer(Canvas canvas, PlayerModel player) {
    final playerSprite =
        PlayerStatus.isDead(player) ? deadPlayerSprite : alivePlayerSprite;

    final size = _playerSize(player.teleportation);

    playerSprite.render(
      canvas,
      Offset.zero,
      width: size,
      height: size,
    );
  }

  double _playerSize(TeleportationModel teleportation) {
    if (!teleportation.isActive) return tileSize;
    return teleportation.isEntering
        ? tileSize *
            (teleportation.timeLeftToEnterTeleport / teleportStepTimeInMs)
        : tileSize *
            ((teleportStepTimeInMs - teleportation.timeLeftToExitTeleport) /
                teleportStepTimeInMs);
  }
}
