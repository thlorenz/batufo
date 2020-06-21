import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedPlayerModel;
import 'package:batufo/rpc/packing_types.dart';
import 'package:flutter/foundation.dart';

const int VELOCITY_FACTOR = 1000;

class PlayerFlags {
  /* 0000 0000 */ static const None = 0x0;
  /* 0000 0001 */ static const Shield = 0x1;
  /* 0000 0010 */
  /* 0000 0100 */
  /* 0000 1000 */

  int bits;

  PlayerFlags({this.bits = PlayerFlags.None});

  factory PlayerFlags.fromPlayerModel(PlayerModel model) {
    final flags = PlayerFlags();
    if (model.shieldSecondsRemaining > 0) {
      flags.add(PlayerFlags.Shield);
    }
    return flags;
  }

  void add(int key) => bits = bits | key;
  bool contains(int key) => key & bits != 0;
}

class PlayerModel {
  // State
  int id;
  TilePosition tilePosition;
  Offset velocity;
  double angle;
  double health;
  double shieldSecondsRemaining;

  // Events
  bool appliedThrust;
  bool shotBullet;
  PlayerModel({
    @required this.id,
    @required this.tilePosition,
    @required this.health,
    @required double angle,
    @required Offset velocity,
    @required double shieldSecondsRemaining,
    bool appliedThrust,
    bool shotBullet,
  })  : angle = angle ?? 0.0,
        velocity = velocity ?? Offset.zero,
        appliedThrust = appliedThrust ?? false,
        shotBullet = shotBullet ?? false,
        shieldSecondsRemaining = shieldSecondsRemaining ?? 0.0;

  bool get hasShield => shieldSecondsRemaining > 0.0;

  factory PlayerModel.forInitialPosition(
    int clientID,
    TilePosition tp,
    double initialHealth,
  ) {
    return PlayerModel(
      id: clientID,
      health: initialHealth,
      velocity: Offset.zero,
      tilePosition: tp,
      angle: 0,
      shieldSecondsRemaining: 0.0,
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
    final flags = PlayerFlags.fromPlayerModel(this);
    return PackedPlayerModel()
      ..id = id
      ..tilePosition = tp
      ..velocity = v
      ..angle = a
      ..health = h
      ..flags = flags.bits;
  }

  factory PlayerModel.unpack(PackedPlayerModel data) {
    final tp = TilePosition.unpack(data.tilePosition);
    final p = FractionalPoint.unpack(data.velocity, factor: VELOCITY_FACTOR);

    final v = Offset(p.x, p.y);
    final a = unpackFourDecimals(data.angle);
    final h = unpackTwoDecimals(data.health);
    final flags = PlayerFlags(bits: data.flags);
    // sent to us as a boolean and will be false once shield expires
    // so here we just give it 5 secs to show opponent's shield
    final shieldSecondsRemaining =
        flags.contains(PlayerFlags.Shield) ? 5.0 : 0.0;
    return PlayerModel(
      id: data.id,
      tilePosition: tp,
      velocity: v,
      angle: a,
      health: h,
      shieldSecondsRemaining: shieldSecondsRemaining,
    );
  }

  PlayerModel clone() {
    return PlayerModel(
      id: id,
      tilePosition: tilePosition.copyWith(),
      velocity: Offset(velocity.dx, velocity.dy),
      health: health,
      angle: angle,
      appliedThrust: appliedThrust,
      shieldSecondsRemaining: shieldSecondsRemaining,
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
     shieldSecondsRemaining: $shieldSecondsRemaining
   }''';
  }
}
