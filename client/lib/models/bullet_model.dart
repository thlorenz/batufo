import 'dart:ui' show Offset;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart'
    show PackedBulletModel;
import 'package:batufo/rpc/packing_types.dart';
import 'package:flutter/foundation.dart';

class BulletModel {
  // Transmitted Properties
  final int clientID;
  TilePosition tilePosition;
  Offset velocity;

  // Local Properties
  bool collided;

  BulletModel({
    @required this.clientID,
    @required this.tilePosition,
    @required this.velocity,
    this.collided = false,
  });

  PackedBulletModel pack() {
    final tp = tilePosition.pack();
    final v = FractionalPoint(velocity.dx, velocity.dy).pack();
    return PackedBulletModel()
      ..clientID = clientID
      ..tilePosition = tp
      ..velocity = v;
  }

  factory BulletModel.unpack(PackedBulletModel data) {
    final clientID = data.clientID;
    final tp = TilePosition.unpack(data.tilePosition);
    final p = FractionalPoint.unpack(data.velocity);
    final v = Offset(p.x, p.y);
    return BulletModel(
      clientID: clientID,
      tilePosition: tp,
      velocity: v,
    );
  }

  String toString() {
    return 'BulletModel $clientID $tilePosition, $velocity, $collided';
  }
}
