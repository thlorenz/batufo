import debug from 'debug'
import http from 'http'
import socketio from 'socket.io'
import { Arena, levels } from './arena'
import {
  GameCreated,
  PlayRequest,
  InfoResponse,
  LevelInfo,
} from './generated/message_bus_pb'

const PORT = process.env.PORT || 2222
const logInfo = debug('app:info')
const logDebug = debug('app:debug')

const app = http
  .createServer(onRequest)
  .on('listening', () => logInfo('listening on http://locahost:%d', PORT))

const info = new InfoResponse()
info.setLevelsList(
  levels.map((x) => {
    const info = new LevelInfo()
    info.setName(x.name)
    info.setNplayers(x.nplayers)
    return info
  })
)

const io = socketio(app)

function onRequest(_req: http.IncomingMessage, res: http.ServerResponse) {
  res.writeHead(404)
  res.end('Not a real server, please connect via a socket.io client instead')
}

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
      const tileSize = 24
      const arena = Arena.forLevel(levelName, tileSize)
      const gameID = initOrUpdateGame()
      const clientID = 456
      const createdGame = initGame(gameID, clientID, arena)
      socket.emit('game:created', createdGame.serializeBinary().toString())
    })
})

// TODO(thlorenz): do this for real
function initOrUpdateGame() {
  const gameID = 123
  return gameID
}

function initGame(gameID: number, clientID: number, arena: Arena) {
  const createdGame = new GameCreated()
  createdGame.setGameid(gameID)
  createdGame.setClientid(clientID)
  createdGame.setArena(arena.pack())
  createdGame.setPlayerindex(0);
  return createdGame
}

app.listen(PORT)
