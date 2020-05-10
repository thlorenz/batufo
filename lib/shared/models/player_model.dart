import 'package:flutter/foundation.dart';
import 'package:batufo/shared/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/shared/engine/tile_position.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart'
    show PackedPlayerModel;
import 'package:batufo/shared/messaging/packing_types.dart';

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
    final tp = tilePosition.pack();
    final v = FractionalPoint(velocity.dx, velocity.dy).pack();
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
    final p = FractionalPoint.unpack(data.velocity);
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
