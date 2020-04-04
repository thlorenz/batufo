import 'dart:math';

enum Tile {
  /* 0 */ OutOfBounds,
  /* 1 */ Empty,
  /* 2 */ Boundary,
  /* 3 */ Wall,
  /* 4 */ Player,
  /* 5 */ Diamond,
  /* 6 */ Medkit,
}

const BOUNDS_START = '(';
const BOUNDS_END = ')';
const EMPTY = ' ';

const charToTile = <String, Tile>{
  BOUNDS_START: Tile.Boundary,
  BOUNDS_END: Tile.Boundary,
  EMPTY: Tile.Empty,
  '1': Tile.Player,
  '2': Tile.Player,
  'p': Tile.Player,
  '|': Tile.Wall,
  '-': Tile.Wall,
  'd': Tile.Diamond,
  '+': Tile.Medkit,
};

Tile _tileFromChar(String char) {
  final tile = charToTile[char];
  assert(tile != null, '$char needs to be in charToTile map');
  return tile;
}

class Tilemap {
  final List<Tile> tiles;
  // length x
  final int ncols;
  // length y
  final int nrows;

  Tilemap(this.tiles, this.nrows, this.ncols);

  static Tilemap build(String terrain) {
    final lines = terrain.split('\n').where((s) => s.isNotEmpty).toList();
    final nrows = lines.length;

    int ncols = 0;
    for (final line in lines) {
      ncols = max(line.length, ncols);
    }

    final ntiles = nrows * ncols;
    final tiles = List<Tile>(ntiles)..fillRange(0, ntiles, Tile.OutOfBounds);

    for (int row = 0; row < nrows; row++) {
      final line = lines[row];
      bool seenBoundsStart = false;
      // Our tilemap has 0,0 at the left bottom corner
      final tileRow = nrows - row - 1;
      for (int col = 0; col < ncols; col++) {
        final char = line[col];
        seenBoundsStart = seenBoundsStart || char == BOUNDS_START;
        if (seenBoundsStart) {
          final idx = tileRow * ncols + col;
          assert(idx < tiles.length);
          tiles[idx] = _tileFromChar(char);
        }
        if (char == BOUNDS_END) break;
      }
    }
    return Tilemap(tiles, nrows, ncols);
  }

  String get _tilesString {
    assert(tiles.length == nrows * ncols, 'incorrectly sized tiles');
    String s = '';
    for (int row = nrows - 1; row >= 0; row--) {
      s += '  ( ';
      for (int col = 0; col < ncols; col++) {
        final tile = tiles[row * ncols + col];
        final idx = Tile.values.indexOf(tile);
        final char =
            tile == Tile.OutOfBounds ? 'X' : tile == Tile.Empty ? ' ' : idx;
        s += '$char ';
      }
      s += row == 0 ? ')' : ')\n';
    }
    return s;
  }

  String toString() {
    return '''Tilemap ($ncols x $nrows)
  ----------------------
$_tilesString
  ----------------------
''';
  }

  static bool coversBackground(Tile tile) {
    switch (tile) {
      case Tile.OutOfBounds:
      case Tile.Boundary:
      case Tile.Wall:
        return true;
      case Tile.Empty:
      case Tile.Player:
      case Tile.Diamond:
      case Tile.Medkit:
        return false;
      default:
        throw Exception('Unknown tile type $tile');
    }
  }
}

const String terrain = '''
(---------------------)
(         p           )
(                     )
(----           p     )
    (     |--|        )
    (   d |  |        )
    (     |--|        )
(----                 ---)
(   +   p       p        )
(                     ---)
(---------------------)
''';

void main() {
  final tilemap = Tilemap.build(terrain);
  print('$tilemap');
}
