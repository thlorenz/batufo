import 'dart:math' show max;

import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/bomb_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

class BombsController {
  final List<BombModel> _bombs;
  final SoundController soundController;
  final double bombStartExplosionStrength;
  final double bombTimeExploding;
  final double bombExplosionRadiusSquared;
  final double bombDealtDamageFromStrengthFactor;
  final double bombReducedShieldFromStrengthFactor;
  final double bombScoreFromStrengthFactor;
  final void Function(int score) onScored;

  BombsController(
    this._bombs, {
    @required this.soundController,
    @required this.bombStartExplosionStrength,
    @required this.bombTimeExploding,
    @required this.bombExplosionRadiusSquared,
    @required this.bombDealtDamageFromStrengthFactor,
    @required this.bombReducedShieldFromStrengthFactor,
    @required this.bombScoreFromStrengthFactor,
    @required this.onScored,
  });

  void update(double dt, PlayerModel hero, Iterable<PlayerModel> opponents) {
    final exploded = <BombModel>[];
    for (final bomb in _bombs) {
      if (bomb.hasExploded) exploded.add(bomb);
      if (bomb.isExploding) _updateExplodingBomb(bomb, hero, opponents, dt);
      _updateSpawnedBomb(bomb, dt);
    }
    for (final bomb in exploded) {
      _updateExplodedBomb(bomb);
    }
  }

  double explosionStrength(TilePosition targetTilePosition) {
    double strength = 0.0;
    final target = targetTilePosition.toWorldOffset();
    for (final bomb in _bombs.where((x) => x.isExploding)) {
      final dst = (target - bomb.worldOffset).distanceSquared;
      strength += _strength(dst, bomb.timeLeftExplodingMs);
    }
    return strength;
  }

  double _strength(double distance, double timeLeftExploding) {
    final explodedPercent = timeLeftExploding / bombTimeExploding;
    final explosionRadiusPercent = (1 / distance) * bombExplosionRadiusSquared;
    return bombStartExplosionStrength *
        explodedPercent *
        explosionRadiusPercent;
  }

  void _updateSpawnedBomb(BombModel bomb, double dt) {
    bomb.timeToExplodeMs -= dt;
  }

  double _bombStrengthOn(PlayerModel player, BombModel bomb) {
    final dst = (player.tilePosition.toWorldOffset() - bomb.worldOffset)
        .distanceSquared;
    return _strength(dst, bomb.timeLeftExplodingMs);
  }

  int _calculateScore(Iterable<PlayerModel> opponents, BombModel bomb) {
    double score = 0.0;
    for (final player in opponents) {
      final strength = _bombStrengthOn(player, bomb);
      score += strength * bombScoreFromStrengthFactor;
    }
    return score.floor();
  }

  void _updateExplodingBomb(
    BombModel bomb,
    PlayerModel hero,
    Iterable<PlayerModel> opponents,
    double dt,
  ) {
    bomb.timeLeftExplodingMs -= dt;
    if (!bomb.explosionHandled) {
      final strength = _bombStrengthOn(hero, bomb);
      if (hero.hasShield) {
        final reduction = strength * bombReducedShieldFromStrengthFactor;
        hero.shieldRemainingMs = max(hero.shieldRemainingMs - reduction, 0.0);
      } else {
        final damage = strength * bombDealtDamageFromStrengthFactor;
        hero.health = max(hero.health - damage, 0.0);
      }

      if (bomb.spawnedByHero) {
        final score = _calculateScore(opponents, bomb);
        if (score > 0) onScored(score);
      }

      bomb.explosionHandled = true;
      soundController.bombExplodingAt(bomb.tilePosition);
    }
  }

  void _updateExplodedBomb(BombModel bomb) {
    _bombs.remove(bomb);
  }
}
