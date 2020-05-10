import 'package:flutter/foundation.dart';
import 'package:batufo/shared/generated/message_bus.pb.dart';
import 'package:batufo/shared/messaging/packing_types.dart';

class PlayerInputFlag {
  /* 0000 0000 */ static const None = 0x0;
  /* 0000 0001 */ static const AppliedThrust = 0x1;
  /* 0000 0010 */ static const ShotBullet = 0x2;
}

class PlayerInputFlags {
  int bits;

  PlayerInputFlags({this.bits = 0x0});

  void add(int key) => bits = bits | key;
  bool contains(int key) => key & bits != 0;

  static int pack({@required bool appliedThrust, @required bool shotBullet}) {
    final flags = PlayerInputFlags();
    if (appliedThrust) flags.add(PlayerInputFlag.AppliedThrust);
    if (shotBullet) flags.add(PlayerInputFlag.ShotBullet);

    return flags.bits;
  }
}

class PlayerInputs {
  final double angle;
  final bool appliedThrust;
  final bool shotBullet;
  PlayerInputs({
    @required this.angle,
    @required this.appliedThrust,
    @required this.shotBullet,
  });

  PackedPlayerInputs pack() {
    return PackedPlayerInputs()
      ..angle = packFourDecimals(angle)
      ..inputFlags = PlayerInputFlags.pack(
        appliedThrust: appliedThrust,
        shotBullet: shotBullet,
      );
  }

  factory PlayerInputs.unpack(PackedPlayerInputs data) {
    final a = unpackFourDecimals(data.angle);
    final playerInputFlags = PlayerInputFlags(bits: data.inputFlags);
    final appliedThrust = playerInputFlags.contains(
      PlayerInputFlag.AppliedThrust,
    );
    final shotBullet = playerInputFlags.contains(
      PlayerInputFlag.ShotBullet,
    );
    return PlayerInputs(
      angle: a,
      appliedThrust: appliedThrust,
      shotBullet: shotBullet,
    );
  }

  PlayerInputs cloneWithoutEvents() {
    return PlayerInputs(
      angle: angle,
      appliedThrust: false,
      shotBullet: false,
    );
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerInputs &&
          runtimeType == other.runtimeType &&
          angle == other.angle &&
          appliedThrust == other.appliedThrust &&
          shotBullet == other.shotBullet;

  int get hashCode =>
      angle.hashCode ^ appliedThrust.hashCode ^ shotBullet.hashCode;

  String toString() {
    return 'PlayerInputs[ ${angle.toStringAsFixed(2)},'
        '$appliedThrust, $shotBullet ]';
  }
}
