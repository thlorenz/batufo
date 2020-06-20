import { strict as assert } from 'assert'
import largeLevel from './builtins/large'
import faceOffLevel from './builtins/face-off'
import crowdedLevel from './builtins/crowded'
import singlePlayerLevel from './builtins/single-player'
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
  [faceOffLevel.name, faceOffLevel],
  [crowdedLevel.name, crowdedLevel],
  [largeLevel.name, largeLevel],
])

export const levelNames: string[] = Array.from(levels.keys())
export const validLevel = (levelName: string) => levels.has(levelName)
