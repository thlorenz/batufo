import 'dart:math';

import 'package:batufo/arena/teleport.dart';
import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/teleportation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _ActiveTeleport {
  final TilePosition entryPort;
  final TilePosition exitPort;

  _ActiveTeleport(this.entryPort, this.exitPort);
}

class _TeleportHitArea {
  final Teleport teleport;
  final int hitTileRadius;
  final List<TilePosition> hitTilesA;
  final List<TilePosition> hitTilesB;

  _TeleportHitArea(this.teleport, this.hitTileRadius)
      : hitTilesA = <TilePosition>[],
        hitTilesB = <TilePosition>[] {
    _addHitTilesFor(teleport.portA, hitTilesA);
    _addHitTilesFor(teleport.portB, hitTilesB);
  }

  void _addHitTilesFor(
    TilePosition tp,
    List<TilePosition> hitTiles,
  ) {
    final minCol = tp.col - hitTileRadius;
    final maxCol = tp.col + hitTileRadius;
    final minRow = tp.row - hitTileRadius;
    final maxRow = tp.row + hitTileRadius;
    for (int row = minRow; row <= maxRow; row++) {
      for (int col = minCol; col <= maxCol; col++) {
        hitTiles.add(TilePosition(col, row, 0.0, 0.0));
      }
    }
  }

  _ActiveTeleport getActiveTeleport(TilePosition tp) {
    for (final tile in hitTilesA) {
      if (tile.isSameTileAs(tp)) {
        return _ActiveTeleport(
          teleport.portA,
          teleport.portB,
        );
      }
    }
    for (final tile in hitTilesB) {
      if (tile.isSameTileAs(tp)) {
        return _ActiveTeleport(
          teleport.portB,
          teleport.portA,
        );
      }
    }
    return null;
  }
}

class TeleportsController {
  final List<Teleport> teleports;
  final int tileHitRadius;
  final SoundController soundController;
  final List<_TeleportHitArea> _teleportHitAreas;
  final double teleportTotalTimeInMs;

  TeleportsController({
    @required this.teleports,
    @required this.tileHitRadius,
    @required this.teleportTotalTimeInMs,
    @required this.soundController,
  }) : _teleportHitAreas = <_TeleportHitArea>[] {
    for (final teleport in teleports) {
      _teleportHitAreas.add(_TeleportHitArea(teleport, tileHitRadius));
    }
  }

  void update(double dt, PlayerModel hero) {
    if (hero.teleportation.isActive) {
      _updateTeleportation(dt, hero);
      return;
    }
    for (final hitArea in _teleportHitAreas) {
      final activeTeleport = hitArea.getActiveTeleport(hero.tilePosition);
      if (activeTeleport != null) {
        _handleTeleportation(hero, activeTeleport);
        return;
      }
    }
    hero.teleportation = TeleportationModel.empty();
  }

  void _handleTeleportation(PlayerModel hero, _ActiveTeleport teleport) {
    final teleportation = hero.teleportation;
    if (teleport.entryPort == teleportation.teleportExit) return;

    hero.teleportation = TeleportationModel.start(
      teleport.exitPort,
      teleportTotalTimeInMs,
    );

    hero
      ..velocity = Offset.zero
      ..tilePosition = teleport.entryPort;

    soundController.playerTeleported();
  }

  void _updateTeleportation(double dt, PlayerModel hero) {
    final teleport = hero.teleportation;
    if (teleport.isEntering) {
      teleport.timeLeftToEnterTeleport = max(
        teleport.timeLeftToEnterTeleport - dt,
        0.0,
      );
      if (teleport.timeLeftToEnterTeleport == 0.0) {
        hero.tilePosition = teleport.teleportExit;
      }
    } else {
      teleport.timeLeftToExitTeleport = max(
        teleport.timeLeftToExitTeleport - dt,
        0.0,
      );
    }
  }
}
