import { strict as assert } from 'assert'
import largeLevel from './levels/large'
import simpleLevel from './levels/simple'
import { Tilemap } from './tilemap'

export class Levels {
  static simple = simpleLevel
  static large = largeLevel

  static tilemapForLevel(levelName: string): Tilemap {
    const level = levels.get(levelName)
    assert(level != null, 'cannot find level $levelName')
    return Tilemap.build(level)
  }
}

export const levels: Map<string, string> = new Map([
  ['simple', Levels.simple],
  ['large', Levels.large],
])
