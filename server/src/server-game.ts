import { strict as assert } from 'assert'
import { Arena, levelNames } from './arena'
import { Level } from './arena/level'

function generateID() {
  const now = new Date(Date.now())
  const millis =
    now.getHours() * 3600 * 1e3 +
    now.getMinutes() * 60 * 1e3 +
    now.getSeconds() * 1e3 +
    now.getMilliseconds()
  return millis + Math.floor(Math.random() * 1e3)
}

export class ServerStats {}

export class ServerGame {
  readonly clientIDs: number[] = []
  readonly deadClientIDs: number[] = []
  constructor(readonly gameID: number, readonly nplayers: number) {}

  get full() {
    return this.clientIDs.length === this.nplayers
  }

  get finished() {
    return this.deadClientIDs.length === this.nplayers
  }

  addClient(clientID: number): number {
    assert(!this.full, 'cannot add players to a full game')
    this.clientIDs.push(clientID)
    return this.clientIDs.length - 1
  }

  declareClientDead(clientID: number) {
    this.deadClientIDs.push(clientID)
  }
}

export class ServerGames {
  readonly _gamesByLevel: Map<string, Map<number, ServerGame>> = new Map()
  readonly _arenasByLevel: Map<string, Arena> = new Map()
  readonly _gamesByID: Map<number, ServerGame> = new Map()

  constructor(levels: string[], tileSize: number) {
    for (const level of levels) {
      this._gamesByLevel.set(level, new Map())
      this._arenasByLevel.set(level, Arena.forLevel(level, tileSize))
    }
  }

  private _addGame(
    gameID: number,
    game: ServerGame,
    gamesForLevel: Map<number, ServerGame>
  ) {
    gamesForLevel.set(gameID, game)
    this._gamesByID.set(gameID, game)
  }

  private _clearGameIfFinished(gameID: number, game: ServerGame) {
    if (!game.finished) return
    this._gamesByID.delete(gameID)
    for (const gamesForLevel of this._gamesByLevel.values()) {
      gamesForLevel.delete(gameID)
    }
  }

  private _vacantGame(level: Level): ServerGame {
    const gamesForLevel = this._gamesByLevel.get(level.name)
    assert(gamesForLevel != null, `games for level ${level} don't exist`)
    for (const game of gamesForLevel.values()) {
      if (!game.full && !game.finished) return game
    }
    const gameID = generateID()
    const game = new ServerGame(gameID, level.nplayers)
    this._addGame(gameID, game, gamesForLevel)
    return game
  }

  addClientToGame(level: Level) {
    const game = this._vacantGame(level)
    const clientID = generateID()
    const playerIndex = game.addClient(clientID)
    const arena = this._arenasByLevel.get(level.name)
    assert(arena != null, `missing arena for level ${level.name}`)
    return { game, clientID, arena, playerIndex }
  }

  declareClientDead(gameID: number, clientID: number) {
    const game = this._gamesByID.get(gameID)
    if (game == null) return
    game.declareClientDead(clientID)
    this._clearGameIfFinished(gameID, game)
  }

  totals() {
    const totalGames = this._gamesByID.size
    const runningLevelsCounts: Map<string, number> = new Map()
    const waitingForLevelsCounts: Map<string, number> = new Map()
    let totalPlayers = 0
    for (const [k, map] of this._gamesByLevel) {
      runningLevelsCounts.set(k, map.size)
      for (const game of map.values()) {
        const players = game.clientIDs.length
        totalPlayers += players
        if (game.full) continue
        waitingForLevelsCounts.set(k, players)
      }
    }
    return {
      totalGames,
      totalPlayers,
      runningLevelsCounts,
      waitingForLevelsCounts,
    }
  }
}

export const games = new ServerGames(levelNames, Arena.TILE_SIZE)
