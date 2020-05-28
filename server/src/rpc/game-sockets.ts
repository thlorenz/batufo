import { Namespace, Server } from 'socket.io'

// TODO: https://socket.io/docs/rooms-and-namespaces/
class GameSocket {
  readonly nsp: Namespace
  constructor(io: Server, readonly gameID: number) {
    this.nsp = io.of(`/${gameID}`)
  }
}

export class GameSockets {
  readonly gameSockets: Map<number, GameSocket> = new Map()
}
