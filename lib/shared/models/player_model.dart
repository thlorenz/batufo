import 'package:batufo/shared/dart_types/dart_types.dart';
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
  bool appliedThrust;
  PlayerModel({
    @required this.id,
    @required this.tilePosition,
    @required double angle,
    @required Offset velocity,
    @required bool appliedThrust,
  })  : angle = angle ?? 0.0,
        velocity = velocity ?? Offset.zero,
        appliedThrust = appliedThrust ?? false;

  PackedPlayerModel pack() {
    final tp = tilePosition.pack();
    final v = FractionalPoint(velocity.dx, velocity.dy).pack();
    final a = packFourDecimals(angle);
    return PackedPlayerModel()
      ..id = id
      ..tilePosition = tp
      ..velocity = v
      ..angle = a;
  }

  factory PlayerModel.unpack(PackedPlayerModel data) {
    final tp = TilePosition.unpack(data.tilePosition);
    final p = FractionalPoint.unpack(data.velocity);
    final v = Offset(p.x, p.y);
    final a = unpackFourDecimals(data.angle);
    return PlayerModel(
      id: data.id,
      tilePosition: tp,
      velocity: v,
      angle: a,
    );
  }

  @override
  String toString() {
    return '''PlayerModel {
     id: $id
     tilePosition: $tilePosition
     angle: $angle
     velocity: $velocity
     appliedThrust: $appliedThrust
   }''';
  }
}
