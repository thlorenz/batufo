import { strict as assert } from 'assert'
import faceOffLevel from './builtins/face-off'
import practiceArenaLevel from './builtins/practice-arena'
import troikaRingLevel from './builtins/troika-ring'
import troikaRing42Level from './builtins/troika-ring-42'
import coliseumLevel from './builtins/coliseum'
import mazeLevel from './builtins/the-maze'
import lonelyMazeLevel from './builtins/lonely-maze'
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
  [lonelyMazeLevel.name, lonelyMazeLevel],
  [faceOffLevel.name, faceOffLevel],
  [troikaRing42Level.name, troikaRing42Level],
  [mazeLevel.name, mazeLevel],
  [troikaRingLevel.name, troikaRingLevel],
  [coliseumLevel.name, coliseumLevel],
])

export const levelNames: string[] = Array.from(levels.keys())
export const validLevel = (levelName: string) => levels.has(levelName)
