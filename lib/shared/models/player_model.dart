import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/shared/engine/tile_position.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart'
    show PackedPlayerModel;
import 'package:batufo/shared/messaging/packing_types.dart';

class PlayerFlags {
  static const None = 0;
  static const AppliedThrust = 0x1;

  int bits;

  PlayerFlags({this.bits = 0x0});

  void add(int flag) => bits = bits | flag;
  bool has(int flag) => flag & bits != 0;
}

class PlayerModel {
  int id;
  TilePosition tilePosition;
  Offset velocity;
  double angle;
  bool appliedThrust;
  PlayerModel({
    @required this.id,
    @required this.tilePosition,
    @required this.angle,
    @required this.velocity,
    @required this.appliedThrust,
  });

  PackedPlayerModel pack() {
    final tp = tilePosition.pack();
    final v = FractionalPoint(velocity.dx, velocity.dy).pack();
    final a = packFourDecimals(angle);
    final flags = PlayerFlags();
    if (appliedThrust) flags.add(PlayerFlags.AppliedThrust);
    return PackedPlayerModel()
      ..id = id
      ..tilePosition = tp
      ..velocity = v
      ..angle = a
      ..flags = flags.bits;
  }

  factory PlayerModel.unpack(PackedPlayerModel data) {
    final tp = TilePosition.unpack(data.tilePosition);
    final p = FractionalPoint.unpack(data.velocity);
    final v = Offset(p.x, p.y);
    final a = unpackFourDecimals(data.angle);
    final flags = PlayerFlags(bits: data.flags);
    return PlayerModel(
      id: data.id,
      tilePosition: tp,
      velocity: v,
      angle: a,
      appliedThrust: flags.has(PlayerFlags.AppliedThrust),
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
