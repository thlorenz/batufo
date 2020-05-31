import { Namespace, Server } from 'socket.io'
import { ServerGame } from '../server-game'

import socketio from 'socket.io'
import debug from 'debug'
const logDebug = debug('game-socket:debug')
const logError = debug('game-socket:error')
const logTrace = debug('game-socket:trace')

// TODO: https://socket.io/docs/rooms-and-namespaces/
class GameSocket {
  readonly nsp: Namespace
  constructor(readonly io: Server, readonly game: ServerGame) {
    this.nsp = io.of(`/${game.gameID}`)
    this.nsp.on('connection', (socket: socketio.Socket) => {
      logDebug(
        'namespaced connection game: %s, socket: %s',
        game.gameID,
        socket.id
      )
      this._tellClientsIfGameIsReady()

      socket.on('game:client-update', (data: Buffer) => {
        logTrace('got playing client message -> broadcasting')
        try {
          const array = Uint8Array.from(data)
          socket.broadcast.emit('game:client-update', array.toString())
        } catch (err) {
          logError('game:client-update', err)
        }
      })
      socket.on('game:spawned-bullet', (data: Buffer) => {
        logTrace('got spawned bullet message -> broadcasting')
        try {
          const array = Uint8Array.from(data)
          socket.broadcast.emit('game:spawned-bullet', array.toString())
        } catch (err) {
          logError('game:spawned-bullet', err)
        }
      })
    })
  }

  _tellClientsIfGameIsReady() {
    if (!this.game.full) return
    logDebug('game is full, sending game:started')
    try {
      this.nsp.emit('game:started')
    } finally {
    }
  }
}

export class GameSockets {
  readonly gameSockets: Map<number, GameSocket> = new Map()

  addSocketFor(io: Server, game: ServerGame) {
    if (this.gameSockets.has(game.gameID)) return
    const gameSocket = new GameSocket(io, game)
    this.gameSockets.set(game.gameID, gameSocket)
  }
}
