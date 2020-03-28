import 'package:batufo/dart_types.dart';
import 'package:batufo/engine/tile_position.dart';

typedef TilePositionPredicate = bool Function(TilePosition);

@immutable
class Tuple<T, U> {
  final T first;
  final U second;
  Tuple(this.first, this.second);
}
