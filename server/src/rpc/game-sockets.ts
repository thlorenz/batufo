import { Server } from 'socket.io'
import { ServerGame } from '../server-game'

import socketio from 'socket.io'
import debug from 'debug'
const logDebug = debug('game-socket:debug')
const logError = debug('game-socket:error')
const logTrace = debug('game-socket:trace')

class GameSocket {
  private readonly _gameID: string
  constructor(readonly io: Server, readonly game: ServerGame) {
    this._gameID = `${game.gameID}`
  }
  addSocket(socket: socketio.Socket, clientID: number) {
    socket
      .on('game:client-update', (data: Buffer) => {
        logTrace('got playing client message -> broadcasting')
        try {
          const array = Uint8Array.from(data)
          socket.broadcast
            .to(this._gameID)
            .emit('game:client-update', array.toString())
        } catch (err) {
          logError('game:client-update', err)
        }
      })
      .on('game:spawned-bullet', (data: Buffer) => {
        logTrace('got spawned bullet message -> broadcasting')
        try {
          const array = Uint8Array.from(data)
          socket.broadcast
            .to(this._gameID)
            .emit('game:spawned-bullet', array.toString())
        } catch (err) {
          logError('game:spawned-bullet', err)
        }
      })
      .on('game:leave', (_data: Buffer) => {
        logDebug('client [%d] is leaving', clientID)
        socket.leave(this._gameID)
      })
      .join(this._gameID)

    this._tellClientsIfGameIsReady()
  }

  _tellClientsIfGameIsReady() {
    logTrace(
      `game has ${this.game.clientIDs.length}/${this.game.nplayers} players`
    )
    if (!this.game.full) return
    logDebug('game is full, sending game:started')
    try {
      this.io.sockets.in(this._gameID).emit('game:started')
    } catch (err) {
      logError('game:started', err)
    }
  }
}

export class GameSockets {
  readonly gameSockets: Map<number, GameSocket> = new Map()

  addSocketFor(
    io: Server,
    socket: socketio.Socket,
    game: ServerGame,
    clientID: number
  ) {
    const gameSocket =
      this.gameSockets.get(game.gameID) ?? new GameSocket(io, game)
    this.gameSockets.set(game.gameID, gameSocket)
    gameSocket.addSocket(socket, clientID)
  }
}
