import 'package:batufo/shared/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/shared/engine/tile_position.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart'
    show PackedBulletModel;
import 'package:batufo/shared/messaging/packing_types.dart';
import 'package:flutter/foundation.dart';

class BulletModel {
  TilePosition tilePosition;
  Offset velocity;
  bool collided;

  BulletModel({
    @required this.tilePosition,
    @required this.velocity,
    this.collided = false,
  });

  PackedBulletModel pack() {
    final tp = tilePosition.pack();
    final v = FractionalPoint(velocity.dx, velocity.dy).pack();
    return PackedBulletModel()
      ..tilePosition = tp
      ..velocity = v;
  }

  factory BulletModel.unpack(PackedBulletModel data) {
    final tp = TilePosition.unpack(data.tilePosition);
    final p = FractionalPoint.unpack(data.velocity);
    final v = Offset(p.x, p.y);
    return BulletModel(
      tilePosition: tp,
      velocity: v,
    );
  }

  BulletModel clone() {
    return BulletModel(
      tilePosition: tilePosition.copyWith(),
      velocity: Offset(velocity.dx, velocity.dy),
    );
  }

  String toString() {
    return 'BulletModel [ $tilePosition, $velocity, $collided ]';
  }
}
