import 'package:batufo/arena/pickup.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool didBulletHitPlayer(
  TilePosition player,
  TilePosition bullet,
  double radius,
) {
  if (!player.isSameTileAs(bullet)) return false;
  final distanceX = (player.relX - bullet.relX).abs();
  if (distanceX > radius) return false;
  final distanceY = (player.relY - bullet.relY).abs();
  return distanceY <= radius;
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
  final List<bool> _floorTiles;
  final List<bool> _walls;
  final List<Pickup> _pickupTiles;
  final double playerRadius;
  final double _radiusWithShield;
  Colliders(
    this.nrows,
    this.ncols, {
    @required List<TilePosition> walls,
    @required List<TilePosition> floorTiles,
    @required this.playerRadius,
    @required double shieldRadiusFactor,
  })  : _walls = List<bool>(nrows * ncols)..fillRange(0, nrows * ncols, false),
        _floorTiles = List<bool>(nrows * ncols)
          ..fillRange(0, nrows * ncols, false),
        _pickupTiles = List<Pickup>(nrows * ncols),
        _radiusWithShield = playerRadius * shieldRadiusFactor {
    for (final wall in walls) {
      _walls[wall.row * ncols + wall.col] = true;
    }
    for (final floorTile in floorTiles) {
      _floorTiles[floorTile.row * ncols + floorTile.col] = true;
    }
  }

  void initPickups(List<Pickup> pickups) {
    _pickupTiles.fillRange(0, nrows * ncols, null);
    for (final pickup in pickups) {
      _pickupTiles[pickup.tilePosition.row * ncols + pickup.tilePosition.col] =
          pickup;
    }
  }

  void removePickup(Pickup pickup) {
    _pickupTiles[pickup.tilePosition.row * ncols + pickup.tilePosition.col] =
        null;
  }

  bool isValidPosition(TilePosition tp) {
    // TODO(thlorenz): if we ever have areas where players can go even though
    // there is no floor tile then this needs to be adapted so that the arena
    // tells us which tiles are valid.
    return _floorTileAt(tp);
  }

  BulletTarget bulletCollidingAt(
    Iterable<PlayerModel> players,
    TilePosition tp,
  ) {
    if (_wallAt(tp)) return BulletTarget.wall();
    for (final player in players) {
      final radius = player.hasShield ? _radiusWithShield : playerRadius;
      if (didBulletHitPlayer(player.tilePosition, tp, radius)) {
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

  bool _floorTileAt(TilePosition tp) {
    final idx = tp.row * ncols + tp.col;
    return idx < _floorTiles.length && _floorTiles[idx];
  }

  Pickup playerPickingUpAt(TilePosition tp) {
    final idx = tp.row * ncols + tp.col;
    return idx >= _pickupTiles.length ? null : _pickupTiles[idx];
  }
}
