import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/engine/tile_position.dart';

typedef TilePositionPredicate = bool Function(TilePosition);

@immutable
class Tuple<T, U> {
  final T first;
  final U second;
  const Tuple(this.first, this.second);
}
