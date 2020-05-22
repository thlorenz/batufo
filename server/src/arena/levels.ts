import { strict as assert } from 'assert'
import { Tilemap } from './tilemap'
const levels: Map<string, string> = new Map()

// TODO(thlorenz): add levels, i.e.
// [[file:/Volumes/d/dev/gdev/flutter/ufo-2d/batufo/client/lib/arena/test/simple.dart::const simpleLevel = '''][simple level]]
export class Levels {
  static tilemapForLevel(levelName: string): Tilemap {
    const level = levels.get(levelName)
    assert(level != null, 'cannot find level $levelName')
    return Tilemap.build(level)
  }
}
