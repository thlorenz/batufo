import { strict as assert } from 'assert'
import { EMPTY, TileKey } from './tilemap'
// @ts-ignore
import { encode, decode, SEPARATOR } from '6bit-encoder'

type LevelTile = TileKey | '\n'
const tileToHex: Map<LevelTile, number> = new Map([
  [EMPTY, 0x0],
  ['\n', 0x1],
  ['x', 0x2],
  ['p', 0x3],
  ['=', 0x4],
  ['+', 0x5],
  ['s', 0x6],
  ['b', 0x7],
  ['1', 0x8],
  ['2', 0x9],
  ['3', 0xa],
  ['4', 0xb],
  ['5', 0xc],
  ['6', 0xd],
  ['7', 0xe],
  ['8', 0xf],
])

// @ts-ignore
const hexToTile: Map<number, LevelTile> = (() => {
  const map = new Map<number, LevelTile>()
  for (const [k, v] of tileToHex) map.set(v, k)
  return map
})()

const MAX_REPEAT = 64
/**
 * Encode a string of chars that represents a level as follows.
 *
 * Each data point is either two URL safe chars or the separator (*).
 *
 * First pass, consolidate each line:
 * - kind:count: `5=` means 5 '=' characters
 *
 * Second pass, convert lines to URL safe chars:
 * - `7=` becomes something like `64` (subtrace 1 since we never have 0 of something)
 *
 * Third pass, concatenate lines separating by `*`
 */
export class LevelEncoder {
  _consolidate(level: string): [number, LevelTile][] {
    const pairs: [number, LevelTile][] = []
    const lines = level.split('\n')
    for (const line of lines) {
      let currentTile: LevelTile | null = null
      let count: number = 0

      for (const c of line) {
        if (currentTile == null) {
          currentTile = c as LevelTile
          count = 1
          continue
        }
        if (currentTile === c && count < MAX_REPEAT) {
          count++
          continue
        }
        // new kind of tile or exceeded max count
        if (count > 0) {
          pairs.push([count - 1, currentTile])
          currentTile = c as LevelTile
          count = 1
          continue
        }
      }
      if (currentTile != null) {
        pairs.push([count - 1, currentTile])
      }
      pairs.push([0, '\n'])
    }
    return pairs
  }

  _stringify6Bit(consolidated: [number, LevelTile][]): string {
    return consolidated.reduce((acc: string, [count, tile]) => {
      if (tile === '\n') return `${acc}${SEPARATOR}`
      const encodedCount = encode(count)
      // if we encounter something unknown we fill it with space
      const tileHex = tileToHex.get(tile) || tileToHex.get(EMPTY)
      const encodedTile = encode(tileHex!)
      return `${acc}${encodedCount}${encodedTile}`
    }, '')
  }

  encode(level: string) {
    const consolidated = this._consolidate(level)
    const s = this._stringify6Bit(consolidated)
    // remove trailing new lines
    return s.replace(/\*+$/, '')
  }

  decode(encoded: string) {
    let idx = 0
    let level = ''
    while (idx < encoded.length) {
      const fst = encoded[idx++]
      if (fst === SEPARATOR) {
        level += '\n'
        continue
      }
      const tileHex = decode(encoded[idx++])
      const count = decode(fst) + 1
      const tileString = hexToTile.get(tileHex)
      assert(tileString != null, `unkown tile code ${tileHex}`)
      level += tileString.repeat(count)
    }
    return level
  }
}

/*
const terrain: string = `=======================
=         p           =
=                     =
=====  1        p     =
    =     ====        =
    =   s =  =        =
    =     ====        =
=====  1              ====
=   +   p  b    p        =
=                     ====
=======================
`

const encoder = new LevelEncoder()
const encoded = encoder.encode(terrain)
const decoded = encoder.decode(encoded)

console.log(encoded)
console.log(decoded)
*/
