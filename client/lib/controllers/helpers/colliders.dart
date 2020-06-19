import 'package:batufo/arena/pickup.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

enum BulletTargets { Wall, Player, None }

class BulletTarget {
  final BulletTargets kind;
  final PlayerModel player;

  BulletTarget._(this.kind, {this.player});

  factory BulletTarget.none() => BulletTarget._(BulletTargets.None);
  factory BulletTarget.wall() => BulletTarget._(BulletTargets.Wall);
  factory BulletTarget.player(PlayerModel player) =>
      BulletTarget._(BulletTargets.Player, player: player);
}

class Colliders {
  final int nrows;
  final int ncols;
  final List<bool> _walls;
  final List<Pickup> _pickups;
  final double playerRadius;
  Colliders(
    this.nrows,
    this.ncols, {
    @required List<TilePosition> walls,
    @required this.playerRadius,
  })  : _walls = List<bool>(nrows * ncols)..fillRange(0, nrows * ncols, false),
        _pickups = List<Pickup>(nrows * ncols)
          ..fillRange(0, nrows * ncols, null) {
    for (final wall in walls) {
      _walls[wall.row * ncols + wall.col] = true;
    }
  }

  void updatePickups(List<Pickup> pickups) {
    _pickups
      ..clear()
      ..fillRange(0, nrows * ncols, null);
    for (final pickup in pickups) {
      _pickups[pickup.tilePosition.row * ncols + pickup.tilePosition.col] =
          pickup;
    }
  }

  BulletTarget bulletCollidingAt(
    Iterable<PlayerModel> players,
    TilePosition tp,
  ) {
    if (_wallAt(tp)) return BulletTarget.wall();
    for (final player in players) {
      if (didBulletHitPlayer(
        player.tilePosition,
        tp,
        playerRadius,
      )) {
        return BulletTarget.player(player);
      }
    }
    return BulletTarget.none();
  }

  bool playerCollidingAt(TilePosition tp) {
    return _wallAt(tp);
  }

  bool _wallAt(TilePosition tp) {
    final idx = tp.row * ncols + tp.col;
    return idx >= _walls.length || _walls[idx];
  }

  Pickup playerPickingUpAt(TilePosition tp) {
    final idx = tp.row * ncols + tp.col;
    return idx >= _pickups.length ? null : _pickups[idx];
  }
}
