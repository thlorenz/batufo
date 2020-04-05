import 'package:batufo/shared/dart_types/dart_types.dart';
import 'package:batufo/shared/engine/tile_position.dart';

class Colliders {
  final int nrows;
  final int ncols;
  final List<bool> _colliders;
  Colliders(this.nrows, this.ncols, {@required List<TilePosition> walls})
      : _colliders = List<bool>(nrows * ncols)
          ..fillRange(0, nrows * ncols, false) {
    for (final wall in walls) {
      _colliders[wall.row * ncols + wall.col] = true;
    }
  }

  bool colliderAt(TilePosition tp) {
    final idx = tp.row * ncols + tp.col;
    return idx >= _colliders.length || _colliders[idx];
  }
}
