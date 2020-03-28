import 'package:batufo/dart_types/dart_types.dart';

class AggregatedGestures {
  final double rotation;
  final double thrust;

  AggregatedGestures({
    @required this.rotation,
    @required this.thrust,
  });
}

class GameKey {
  /* 0000 0000 */ static const None = 0x0;
  /* 0000 0001 */ static const Left = 0x1;
  /* 0000 0010 */ static const Right = 0x2;
  /* 0000 0100 */ static const Up = 0x4;
  /* 0000 1000 */ static const Fire = 0x8;
}

class GameKeys {
  int _keys = 0x0;

  void add(int key) => _keys = _keys | key;
  bool contains(int key) => key & _keys == key;

  String toString() {
    return 'GameKeys { _keys: ${_keys.toRadixString(2)} }';
  }
}
