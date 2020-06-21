import { strict as assert } from 'assert'
import faceOffLevel from './builtins/face-off'
import practiceArenaLevel from './builtins/practice-arena'
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
  [practiceArenaLevel.name, practiceArenaLevel],
  [faceOffLevel.name, faceOffLevel],
])

export const levelNames: string[] = Array.from(levels.keys())
export const validLevel = (levelName: string) => levels.has(levelName)
