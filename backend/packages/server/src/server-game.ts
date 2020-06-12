import { strict as assert } from 'assert'
import { Arena, levelNames, Level } from '@batufo/core'
import { EventEmitter } from 'events'
import debug from 'debug'
import { Platforms } from './types'

function generateID() {
  const now = new Date(Date.now())
  const millis =
    now.getHours() * 3600 * 1e3 +
    now.getMinutes() * 60 * 1e3 +
    now.getSeconds() * 1e3 +
    now.getMilliseconds()
  return millis + Math.floor(Math.random() * 1e3)
}

const logDebug = debug('game:debug')

export class ServerGame extends EventEmitter {
  readonly clientIDs: Set<number> = new Set()
  readonly playerIndexes: Map<number, number> = new Map()
  readonly availablePlayerIndexes: Set<number> = new Set()
  readonly platformsByID: Map<number, number> = new Map()

  private readonly _communications: Map<number, number> = new Map()

  started: boolean = false

  constructor(readonly gameID: number, readonly nplayers: number) {
    super()
    for (let i = 0; i < nplayers; i++) this.availablePlayerIndexes.add(i)
  }

  get full() {
    return this.clientIDs.size === this.nplayers
  }

  get finished() {
    return this.clientIDs.size === 0
  }

  _getNextPlayerIndex() {
    const val = this.availablePlayerIndexes.values().next().value
    this.availablePlayerIndexes.delete(val)
    return val
  }

  addClient(clientID: number, platform: number): number {
    assert(!this.full, 'cannot add players to a full game')
    this.clientIDs.add(clientID)
    const playerIndex = this._getNextPlayerIndex()
    assert(playerIndex != null, 'should still have player index')
    this.playerIndexes.set(clientID, playerIndex)
    this.platformsByID.set(clientID, platform)
    return playerIndex
  }

  departClient(clientID: number) {
    const playerIndex = this.playerIndexes.get(clientID)
    assert(playerIndex != null, 'departing client should have a player index')
    this.clientIDs.delete(clientID)
    this.playerIndexes.delete(clientID)
    this.platformsByID.delete(clientID)
    this.availablePlayerIndexes.add(playerIndex)
    this._disposeIfFinished()
  }

  clientCommunicated(clientID: number) {
    const now = Date.now()
    this._communications.set(clientID, now)
  }

  lastClientCommunication(clientID: number) {
    const timestamp = this._communications.get(clientID)
    return timestamp == null ? 0 : timestamp
  }

  lastOverallCommunication() {
    let max = 0
    for (const timestamp of this._communications.values()) {
      max = Math.max(max, timestamp)
    }
    return max
  }

  _disposeIfFinished() {
    if (!this.finished) return
    logDebug('disposing')
    this.emit('disposed', this.gameID)
  }
}

export class ServerGames {
  readonly _arenasByLevel: Map<string, Arena> = new Map()
  readonly _gamesByLevel: Map<string, Map<number, ServerGame>> = new Map()
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
    game.once('disposed', (gameID) => {
      logDebug('removing game %d', gameID)
      this._gamesByID.delete(gameID)
      gamesForLevel.delete(gameID)
    })
  }

  private _vacantGame(level: Level): ServerGame {
    const gamesForLevel = this._gamesByLevel.get(level.name)
    assert(gamesForLevel != null, `games for level ${level} don't exist`)
    for (const game of gamesForLevel.values()) {
      if (!game.full && !game.finished && !game.started) return game
    }
    const gameID = generateID()
    const game = new ServerGame(gameID, level.nplayers)
    this._addGame(gameID, game, gamesForLevel)
    return game
  }

  addClientToGame(level: Level, platform: number) {
    const game = this._vacantGame(level)
    const clientID = generateID()
    const playerIndex = game.addClient(clientID, platform)
    const arena = this._arenasByLevel.get(level.name)
    assert(arena != null, `missing arena for level ${level.name}`)
    return { game, clientID, arena, playerIndex }
  }

  totals() {
    const totalGames = this._gamesByID.size
    const runningLevelsCounts: Map<string, number> = new Map()
    const waitingForLevelsCounts: Map<string, number> = new Map()
    let totalPlayers = 0
    for (const [k, map] of this._gamesByLevel) {
      runningLevelsCounts.set(k, map.size)
      for (const game of map.values()) {
        const players = game.clientIDs.size
        totalPlayers += players
        if (game.full || game.started) continue
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

  platforms() {
    if (this._gamesByID.size === 0) return null
    const sums: number[] = Array(Platforms.length).fill(0)
    for (const game of this._gamesByID.values()) {
      for (const platform of game.platformsByID.values()) {
        sums[platform] = sums[platform] + 1
      }
    }

    let msg = ''
    for (let idx = 0; idx < sums.length; idx++) {
      const sum = sums[idx]
      if (sum === 0) continue
      const label = Platforms[idx]
      msg += ` ${label}: ${sum}`
    }
    return msg
  }
}

export const games = new ServerGames(levelNames, Arena.TILE_SIZE)
