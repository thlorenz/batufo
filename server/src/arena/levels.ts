import { strict as assert } from 'assert'
import largeLevel from './levels/large'
import simpleLevel from './levels/simple'
import singlePlayerLevel from './levels/single-player'
import { Tilemap } from './tilemap'
import { Level } from './level'

export class Levels {
  static tilemapForLevel(levelName: string): Tilemap {
    const level = levels.get(levelName)
    assert(level != null, 'cannot find level $levelName')
    return Tilemap.build(level.levelString)
  }
}

export const levels: Map<string, Level> = new Map([
  [singlePlayerLevel.name, singlePlayerLevel],
  [simpleLevel.name, simpleLevel],
  [largeLevel.name, largeLevel],
])

export const levelNames: string[] = Array.from(levels.keys())
export const validLevel = (levelName: string) => levels.has(levelName)
