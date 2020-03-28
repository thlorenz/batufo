import 'package:batufo/dart_types.dart';

class AggregatedGestures {
  final double rotation;
  final double thrust;

  AggregatedGestures({
    @required this.rotation,
    @required this.thrust,
  });
}

enum GameKey { Left, Right, Up, Fire }
