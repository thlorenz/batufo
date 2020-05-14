import 'package:batufo/engine/tile_position.dart';
import 'package:flutter/foundation.dart';

typedef TilePositionPredicate = bool Function(TilePosition);

@immutable
class Tuple<T, U> {
  final T first;
  final U second;
  const Tuple(this.first, this.second);
}
