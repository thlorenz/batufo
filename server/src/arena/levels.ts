import { strict as assert } from 'assert'
import largeLevel from './levels/large'
import simpleLevel from './levels/simple'
import { Tilemap } from './tilemap'

class Level {
  private constructor(readonly nplayers: number, readonly name: string) {}

  static fromLevelString(name: string, levelString: string): Level {
    let nplayers = 0
    for (const char of levelString) {
      if (char === 'p') nplayers++
    }
    return new Level(nplayers, name)
  }
}

export class Levels {
  static simple = simpleLevel
  static large = largeLevel

  static tilemapForLevel(levelName: string): Tilemap {
    const level = levelStrings.get(levelName)
    assert(level != null, 'cannot find level $levelName')
    return Tilemap.build(level)
  }
}

export const levelStrings: Map<string, string> = new Map([
  ['simple', Levels.simple],
  ['large', Levels.large],
])

export const levels: Level[] = Array.from(
  levelStrings
).map(([key, levelString]) => Level.fromLevelString(key, levelString))
