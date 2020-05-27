import debug from 'debug'
import http from 'http'
import socketio from 'socket.io'
import { Arena } from './arena'
import { PlayingClient, PlayRequest } from './generated/message_bus_pb'

const PORT = process.env.PORT || 2222
const logInfo = debug('app:info')
const logDebug = debug('app:debug')

const app = http
  .createServer(onRequest)
  .on('listening', () => logInfo('listening on http://locahost:%d', PORT))

const io = socketio(app)

function onRequest(_req: http.IncomingMessage, res: http.ServerResponse) {
  res.writeHead(404)
  res.end('Not a real server, please connect via a socket.io client instead')
}

io.on('connection', (socket: socketio.Socket) => {
  logDebug('on:connection')
  socket.once('play:request', (data) => {
    const req = PlayRequest.deserializeBinary(data)
    logInfo('got play request for level [%s]', req.getLevelname())

    const levelName = 'simple'
    const tileSize = 24
    const arena = Arena.forLevel(levelName, tileSize)
    const gameID = initOrUpdateGame()
    const clientID = 456
    const playingClient = initPlayer(gameID, clientID, arena)
    socket.emit('game:created', playingClient.serializeBinary().toString())
  })
})

// TODO(thlorenz): do this for real
function initOrUpdateGame() {
  const gameID = 123
  return gameID
}

function initPlayer(gameID: number, clientID: number, arena: Arena) {
  const playingClient = new PlayingClient()
  playingClient.setGameid(gameID)
  playingClient.setClientid(clientID)
  playingClient.setArena(arena.pack())
  return playingClient
}

app.listen(PORT)
