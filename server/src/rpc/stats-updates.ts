import socketio from 'socket.io'
import { ServerGames } from '../server-game'
import { ServerStatsUpdate } from '../generated/message_bus_pb'
import debug from 'debug'

const logDebug = debug('stats-updates:debug')

export class StatsUpdates {
  tickToken?: NodeJS.Timeout

  constructor(readonly io: socketio.Server, readonly games: ServerGames) {}

  start(intervalMs: number = 5000) {
    this.stop()
    this.tickToken = setInterval(this._emitGameStats, intervalMs)
  }

  stop() {
    if (this.tickToken != null) clearInterval(this.tickToken)
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
    logDebug('sending', totals)
    this.io.emit('server:stats', serverStatsUpdate.serializeBinary().toString())
  }
}
