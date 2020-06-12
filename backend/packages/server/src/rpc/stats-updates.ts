import socketio from 'socket.io'
import debug from 'debug'
import { ServerGames } from '../server-game'
import { ServerStatsUpdate } from '@batufo/core'

const logTrace = debug('stats:trace')
const logInfo = debug('stats:info')

export class StatsUpdates {
  private _gameTickToken?: NodeJS.Timeout
  private _serverTickToken?: NodeJS.Timeout

  constructor(readonly io: socketio.Server, readonly games: ServerGames) {}

  start(gameStatsIntervalMs: number, serverStatsIntervalMs: number) {
    this.stop()
    this._gameTickToken = setInterval(this._emitGameStats, gameStatsIntervalMs)
    this._serverTickToken = setInterval(
      this._dumpServerStats,
      serverStatsIntervalMs
    )
  }

  stop() {
    if (this._gameTickToken != null) clearInterval(this._gameTickToken)
    if (this._serverTickToken != null) clearInterval(this._serverTickToken)
  }

  _emitGameStats = () => {
    const totals = this.games.totals()
    const serverStatsUpdate = new ServerStatsUpdate()
    serverStatsUpdate.setTotalgames(totals.totalGames)
    serverStatsUpdate.setTotalplayers(totals.totalPlayers)
    let map = serverStatsUpdate.getRunninglevelscountsMap()
    for (const [k, v] of totals.runningLevelsCounts) map.set(k, v)
    map = serverStatsUpdate.getWaitingforlevelscountsMap()
    for (const [k, v] of totals.waitingForLevelsCounts) map.set(k, v)
    logTrace('sending', totals)
    this.io.emit('server:stats', serverStatsUpdate.serializeBinary().toString())
  }

  _dumpServerStats = () => {
    if (!logInfo.enabled) return
    const msg = this.games.platforms()
    if (msg != null) logInfo(msg)
  }
}
