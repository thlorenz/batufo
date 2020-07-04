import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/models/teleportation_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedPlayerModel;
import 'package:batufo/rpc/packing_types.dart';
import 'package:flutter/foundation.dart';

const int VELOCITY_FACTOR = 1000;

enum Weapon { Bullet, Bomb }

Weapon nextWeapon(Weapon currentWeapon) {
  switch (currentWeapon) {
    case Weapon.Bullet:
      return Weapon.Bomb;
    case Weapon.Bomb:
      return Weapon.Bullet;
    default:
      throw ArgumentError('unknown weapon type $currentWeapon');
  }
}

class PlayerModel {
  // Transmitted State
  int id;
  TilePosition tilePosition;
  Offset velocity;
  double angle;
  double health;
  double shieldRemainingMs;

  // Local State
  int nbombs;
  int nbullets;
  Weapon currentWeapon;
  TeleportationModel teleportation;

  // Events
  bool appliedThrust;
  bool shotBullet;
  bool spawnedBomb;
  PlayerModel({
    @required this.id,
    @required this.tilePosition,
    @required this.health,
    @required double angle,
    @required Offset velocity,
    @required double shieldRemainingMs,
    Weapon currentWeapon,
    bool appliedThrust,
    bool shotBullet,
    bool spawnedBomb,
    int nbombs,
    int nbullets,
  })  : angle = angle ?? 0.0,
        velocity = velocity ?? Offset.zero,
        appliedThrust = appliedThrust ?? false,
        shotBullet = shotBullet ?? false,
        spawnedBomb = spawnedBomb ?? false,
        shieldRemainingMs = shieldRemainingMs ?? 0.0,
        currentWeapon = currentWeapon ?? Weapon.Bullet,
        nbombs = nbombs ?? 0,
        nbullets = nbullets ?? 0,
        teleportation = TeleportationModel.empty();

  bool get hasShield => shieldRemainingMs > 0.0;
  bool get hasBomb => nbombs > 0;

  factory PlayerModel.forInitialPosition(
    int clientID,
    TilePosition tp,
    double initialHealth,
    int nbombs,
    int nbullets,
  ) {
    return PlayerModel(
      id: clientID,
      health: initialHealth,
      velocity: Offset.zero,
      tilePosition: tp,
      nbombs: nbombs,
      nbullets: nbullets,
      angle: 0,
      shieldRemainingMs: 0.0,
    );
  }

  PackedPlayerModel pack() {
    assert(health >= 0, 'negative health will cause problems in the browser');
    assert(angle >= 0, 'negative angle will cause problems in the browser');
    final tp = tilePosition.pack();
    final v = FractionalPoint(
      velocity.dx,
      velocity.dy,
    ).pack(factor: VELOCITY_FACTOR);
    final a = packFourDecimals(angle);
    final h = packTwoDecimals(health);
    return PackedPlayerModel()
      ..id = id
      ..tilePosition = tp
      ..velocity = v
      ..angle = a
      ..health = h
      ..shieldRemainingMs = shieldRemainingMs.ceil();
  }

  factory PlayerModel.unpack(PackedPlayerModel data) {
    final tp = TilePosition.unpack(data.tilePosition);
    final p = FractionalPoint.unpack(data.velocity, factor: VELOCITY_FACTOR);

    final v = Offset(p.x, p.y);
    final a = unpackFourDecimals(data.angle);
    final h = unpackTwoDecimals(data.health);
    final s = data.shieldRemainingMs.toDouble();
    return PlayerModel(
      id: data.id,
      tilePosition: tp,
      velocity: v,
      angle: a,
      health: h,
      shieldRemainingMs: s,
    );
  }

  @override
  String toString() {
    return '''PlayerModel {
     id: $id
     tilePosition: $tilePosition
     angle: $angle
     velocity: $velocity
     health: $health
     appliedThrust: $appliedThrust
     shieldRemainingMs: $shieldRemainingMs
     weapon: $currentWeapon
     nbombs: $nbombs
     nbullets: $nbullets
   }''';
  }
}
