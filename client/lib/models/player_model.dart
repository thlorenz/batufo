import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedPlayerModel;
import 'package:batufo/rpc/packing_types.dart';
import 'package:flutter/foundation.dart';

const int VELOCITY_FACTOR = 1000;

class PlayerModel {
  int id;
  TilePosition tilePosition;
  Offset velocity;
  double angle;
  double health;
  bool appliedThrust;
  bool shotBullet;
  PlayerModel({
    @required this.id,
    @required this.tilePosition,
    @required this.health,
    @required double angle,
    @required Offset velocity,
    bool appliedThrust,
    bool shotBullet,
  })  : angle = angle ?? 0.0,
        velocity = velocity ?? Offset.zero,
        appliedThrust = appliedThrust ?? false,
        shotBullet = shotBullet ?? false;

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
      ..health = h;
  }

  factory PlayerModel.unpack(PackedPlayerModel data) {
    final tp = TilePosition.unpack(data.tilePosition);
    final p = FractionalPoint.unpack(data.velocity, factor: VELOCITY_FACTOR);

    final v = Offset(p.x, p.y);
    final a = unpackFourDecimals(data.angle);
    final h = unpackTwoDecimals(data.health);
    return PlayerModel(
      id: data.id,
      tilePosition: tp,
      velocity: v,
      angle: a,
      health: h,
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
   }''';
  }
}
