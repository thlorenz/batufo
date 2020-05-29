import { strict as assert } from 'assert'
import { Namespace, Server } from 'socket.io'
import { ServerGame } from '../server-game'
import { PlayingClientEvent } from '../generated/message_bus_pb'

import socketio from 'socket.io'
import debug from 'debug'
const logDebug = debug('game-socket:debug')

// TODO: https://socket.io/docs/rooms-and-namespaces/
class GameSocket {
  readonly nsp: Namespace
  constructor(readonly io: Server, readonly game: ServerGame) {
    this.nsp = io.of(`/${game.gameID}`)
    this.nsp
      .on('connection', (socket: socketio.Socket) => {
        logDebug(
          'namespaced connection game: %s, socket: %s',
          game.gameID,
          socket.id
        )
      })
      .on('client:update', this._onPlayingClientMessage)
  }

  _onPlayingClientMessage = (data: Uint8Array) => {
    logDebug('got a message')
    const req = PlayingClientEvent.deserializeBinary(data)
    const gameID = req.getGameid()
    assert(
      gameID === this.game.gameID,
      `${gameID} needs to match ${this.game.gameID}`
    )
    logDebug(req)
  }
}

export class GameSockets {
  readonly gameSockets: Map<number, GameSocket> = new Map()

  addSocketFor(io: Server, game: ServerGame) {
    // TODO: what if it already exists?
    const gameSocket = new GameSocket(io, game)
    this.gameSockets.set(game.gameID, gameSocket)
  }
}
