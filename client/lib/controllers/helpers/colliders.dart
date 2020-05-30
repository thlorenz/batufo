import 'dart:math';

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';

bool didBulletHitPlayer(
  TilePosition player,
  TilePosition bullet,
  double playerRadius,
) {
  if (!player.isSameTileAs(bullet)) return false;
  final distanceX = (player.relX - bullet.relX).abs();
  if (distanceX > playerRadius) return false;
  final distanceY = (player.relY - bullet.relY).abs();
  return distanceY <= playerRadius;
}

class Colliders {
  final int nrows;
  final int ncols;
  final List<bool> _walls;
  final double playerRadius;
  final double bulletHitsPlayerHealthToll;
  Colliders(
    this.nrows,
    this.ncols, {
    @required List<TilePosition> walls,
    @required this.playerRadius,
    @required this.bulletHitsPlayerHealthToll,
  }) : _walls = List<bool>(nrows * ncols)..fillRange(0, nrows * ncols, false) {
    for (final wall in walls) {
      _walls[wall.row * ncols + wall.col] = true;
    }
  }

  bool bulletCollidingAt(Iterable<PlayerModel> players, TilePosition tp) {
    if (_wallAt(tp)) return true;
    for (final player in players) {
      if (didBulletHitPlayer(player.tilePosition, tp, playerRadius)) {
        player.health = max(player.health - bulletHitsPlayerHealthToll, 0.0);
        return true;
      }
    }
    return false;
  }

  bool playerCollidingAt(TilePosition tp) {
    return _wallAt(tp);
  }

  bool _wallAt(TilePosition tp) {
    final idx = tp.row * ncols + tp.col;
    return idx >= _walls.length || _walls[idx];
  }
}
