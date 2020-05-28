import { strict as assert } from 'assert'
import largeLevel from './levels/large'
import simpleLevel from './levels/simple'
import { Tilemap } from './tilemap'
import { Level } from './level'

export class Levels {
  static simple: Level = simpleLevel
  static large: Level = largeLevel

  static tilemapForLevel(levelName: string): Tilemap {
    const level = levels.get(levelName)
    assert(level != null, 'cannot find level $levelName')
    return Tilemap.build(level.levelString)
  }
}

export const levels: Map<string, Level> = new Map([
  ['simple', Levels.simple],
  ['large', Levels.large],
])

export const levelNames: string[] = Array.from(levels.keys())
export const validLevel = (levelName: string) => levels.has(levelName)
