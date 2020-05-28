export class Level {
  private constructor(
    readonly name: string,
    readonly levelString: string,
    readonly nplayers: number
  ) {}

  static fromLevelString(name: string, levelString: string): Level {
    let nplayers = 0
    for (const char of levelString) {
      if (char === 'p') nplayers++
    }
    return new Level(name, levelString, nplayers)
  }
}
