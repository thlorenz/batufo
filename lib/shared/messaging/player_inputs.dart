import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart';
import 'package:batufo/shared/messaging/packing_types.dart';

class PlayerInputFlag {
  /* 0000 0000 */ static const None = 0x0;
  /* 0000 0001 */ static const AppliedThrust = 0x1;
  /* 0000 0010 */ static const Bullet = 0x2;
}

class PlayerInputFlags {
  int bits;

  PlayerInputFlags({this.bits = 0x0});

  void add(int key) => bits = bits | key;
  bool contains(int key) => key & bits != 0;

  static int pack({bool appliedThrust}) {
    final flags = PlayerInputFlags();
    if (appliedThrust) flags.add(PlayerInputFlag.AppliedThrust);

    return flags.bits;
  }
}

class PlayerInputs {
  final double angle;
  final bool appliedThrust;
  PlayerInputs({@required this.angle, @required this.appliedThrust});

  PackedPlayerInputs pack() {
    return PackedPlayerInputs()
      ..angle = packFourDecimals(angle)
      ..inputFlags = PlayerInputFlags.pack(appliedThrust: appliedThrust);
  }

  factory PlayerInputs.unpack(PackedPlayerInputs data) {
    final a = unpackFourDecimals(data.angle);
    final playerInputFlags = PlayerInputFlags(bits: data.inputFlags);
    final appliedThrust = playerInputFlags.contains(
      PlayerInputFlag.AppliedThrust,
    );
    return PlayerInputs(
      angle: a,
      appliedThrust: appliedThrust,
    );
  }

  String toString() {
    return 'PlayerInputs{angle: ${angle.toStringAsFixed(2)}, '
        'appliedThrust: $appliedThrust}';
  }
}
