import debug from 'debug'
import http from 'http'
import socketio from 'socket.io'
import { levels } from './arena'
import {
  GameCreated,
  PlayRequest,
  InfoResponse,
  LevelInfo,
} from './generated/message_bus_pb'
import { games } from './server-game'
import { GameSockets } from './rpc/game-sockets'

const PORT = process.env.PORT || 2222
const logInfo = debug('app:info')
const logDebug = debug('app:debug')

const info = new InfoResponse()
info.setLevelsList(
  Array.from(levels).map(([_k, x]) => {
    const info = new LevelInfo()
    info.setName(x.name)
    info.setNplayers(x.nplayers)
    return info
  })
)
const app = http
  .createServer(onRequest)
  .on('listening', () => logInfo('listening on http://locahost:%d', PORT))

const io = socketio(app)

function onRequest(_req: http.IncomingMessage, res: http.ServerResponse) {
  res.writeHead(404)
  res.end('Not a real server, please connect via a socket.io client instead')
}

const gameSockets = new GameSockets()

io.on('connection', (socket: socketio.Socket) => {
  logDebug('on:connection')
  socket
    .once('info:request', () => {
      logInfo('got info request')
      socket.emit('info:response', info.serializeBinary().toString())
    })
    .once('play:request', (data) => {
      const req = PlayRequest.deserializeBinary(data)
      logInfo('got play request for level [%s]', req.getLevelname())

      const levelName = req.getLevelname()
      const level = levels.get(levelName)
      if (level == null) {
        // TODO: socket.emit('error:level-not-found') or something similar
        return
      }
      const { game, clientID, arena, playerIndex } = games.addClientToGame(
        level
      )

      const createdGame = new GameCreated()
      createdGame.setGameid(game.gameID)
      createdGame.setClientid(clientID)
      createdGame.setArena(arena.pack())
      createdGame.setPlayerindex(playerIndex)

      socket.emit('game:created', createdGame.serializeBinary().toString())
      gameSockets.addSocketFor(io, game)
    })
})

app.listen(PORT)
