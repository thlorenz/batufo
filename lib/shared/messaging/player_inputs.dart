import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart';
import 'package:batufo/shared/messaging/packing_types.dart';

class PlayerInputs {
  final double angle;
  PlayerInputs({@required this.angle});

  PackedPlayerInputs pack() {
    return PackedPlayerInputs()..angle = packFourDecimals(angle);
  }

  factory PlayerInputs.unpack(PackedPlayerInputs data) {
    final a = unpackFourDecimals(data.angle);
    return PlayerInputs(angle: a);
  }
}
