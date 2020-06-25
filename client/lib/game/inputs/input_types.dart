import 'package:flutter/foundation.dart';

class AggregatedGestures {
  final double rotation;
  final double thrust;
  final bool fire;
  final bool switchWeapon;

  AggregatedGestures({
    @required this.rotation,
    @required this.thrust,
    @required this.fire,
    @required this.switchWeapon,
  });
}

class GameKey {
  /* 0000 0000 */ static const None = 0x0;
  /* 0000 0001 */ static const Left = 0x1;
  /* 0000 0010 */ static const Right = 0x2;
  /* 0000 0100 */ static const Up = 0x4;
  /* 0000 1000 */ static const Down = 0x8;
  /* 0001 0000 */ static const Fire = 0x10;
}

class GameKeys {
  int bits;

  GameKeys({this.bits = 0x0});

  void add(int key) => bits = bits | key;
  bool contains(int key) => key & bits != 0;

  String toString() {
    return 'GameKeys { _keys: ${bits.toRadixString(2)} }';
  }
}
