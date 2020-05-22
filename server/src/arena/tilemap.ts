import { strict as assert } from 'assert'
import { UnreachableCaseError } from '../types'

export enum Tile {
  /* 0 */ OutOfBounds,
  /* 1 */ Empty,
  /* 2 */ Boundary,
  /* 3 */ Wall,
  /* 4 */ Player,
  /* 5 */ Diamond,
  /* 6 */ Medkit,
}

const BOUNDS_START = '('
const BOUNDS_END = ')'
const EMPTY = ' '

const TileKeys = [
  BOUNDS_START,
  BOUNDS_END,
  EMPTY,
  '1',
  '2',
  'p',
  '|',
  '-',
  'd',
  '+',
] as const

type TileKey = typeof TileKeys[number]

const charToTile: Map<TileKey, Tile> = new Map([
  [BOUNDS_START, Tile.Boundary],
  [BOUNDS_END, Tile.Boundary],
  [EMPTY, Tile.Empty],
  ['1', Tile.Player],
  ['2', Tile.Player],
  ['p', Tile.Player],
  ['|', Tile.Wall],
  ['-', Tile.Wall],
  ['d', Tile.Diamond],
  ['+', Tile.Medkit],
])

function tileFromChar(char: TileKey) {
  const tile = charToTile.get(char)
  assert(tile != null, '$char needs to be in charToTile map')
  return tile
}

function isTileKey(s: string): s is TileKey {
  return TileKeys.includes(s as TileKey)
}

export class Tilemap {
  constructor(
    readonly tiles: Tile[],
    readonly nrows: number,
    readonly ncols: number
  ) {}

  static build(terrain: string): Tilemap {
    const lines: string[] = terrain
      .split('\n')
      .filter((s: string) => s.length > 0)

    const nrows = lines.length
    let ncols = 0
    for (const line of lines) {
      ncols = Math.max(line.length, ncols)
    }

    const ntiles = nrows * ncols
    const tiles: Tile[] = new Array(ntiles).fill(Tile.OutOfBounds)

    for (let row = 0; row < nrows; row++) {
      const line = lines[row]
      let seenBoundsStart = false
      // Our tilemap has 0,0 at the left bottom corner
      const tileRow = nrows - row - 1
      for (let col = 0; col < ncols; col++) {
        const char = line[col]
        assert(isTileKey(char), `unknown tile key ${char}`)

        seenBoundsStart = seenBoundsStart || char === BOUNDS_START
        if (seenBoundsStart) {
          const idx = tileRow * ncols + col
          assert(idx < tiles.length)
          tiles[idx] = tileFromChar(char)
        }
        if (char === BOUNDS_END) break
      }
    }

    return new Tilemap(tiles, nrows, ncols)
  }

  static coversBackground(tile: Tile): boolean {
    switch (tile) {
      case Tile.OutOfBounds:
      case Tile.Boundary:
      case Tile.Wall:
        return true
      case Tile.Empty:
      case Tile.Player:
      case Tile.Diamond:
      case Tile.Medkit:
        return false
      default:
        throw new UnreachableCaseError(tile)
    }
  }

  get _tilesString(): string {
    assert(
      this.tiles.length == this.nrows * this.ncols,
      'incorrectly sized tiles'
    )
    let s = ''
    for (let row = this.nrows - 1; row >= 0; row--) {
      s += '  ( '
      for (let col = 0; col < this.ncols; col++) {
        const tile = this.tiles[row * this.ncols + col]
        const char =
          tile == Tile.OutOfBounds ? 'X' : tile == Tile.Empty ? ' ' : tile
        s += `${char} `
      }
      s += row == 0 ? ')' : ')\n'
    }
    return s
  }

  toString(): string {
    return `Tilemap (${this.ncols} x ${this.nrows})
  ----------------------
${this._tilesString}
  ----------------------
`
  }
}

const terrain: string = `
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
`

const tilemap = Tilemap.build(terrain)
console.log(tilemap.toString())
