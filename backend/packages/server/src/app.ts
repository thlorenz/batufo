import debug from 'debug'
import http from 'http'
import socketio from 'socket.io'
import { GameCreated, PlayRequest, InfoResponse, levels, LevelInfo } from '@batufo/core'
import { games } from './server-game'
import { GameSockets } from './rpc/game-sockets'
import { StatsUpdates } from './rpc/stats-updates'

const PORT = process.env.PORT || 2222
const logInfo = debug('app:info')
const logDebug = debug('app:debug')
const logError = debug('app:error')

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
  .on('listening', () => logInfo('listening on port %d', PORT))

const io = socketio(app)
const statsUpdates = new StatsUpdates(io, games)
statsUpdates.start(1e3, 30e3)

function onRequest(_req: http.IncomingMessage, res: http.ServerResponse) {
  res.writeHead(404)
  res.end('Not a real server, please connect via a socket.io client instead')
}

const gameSockets = new GameSockets()

io.on('connection', (socket: socketio.Socket) => {
  logDebug('on:connection')
  socket
    .on('info:request', () => {
      logInfo('got info request')
      try {
        socket.emit('info:response', info.serializeBinary().toString())
      } catch (err) {
        logError('info:request', err)
      }
    })
    .on('play:request', (data) => {
      try {
        const req = PlayRequest.deserializeBinary(data)
        logInfo('got play request for level [%s]', req.getLevelname())

        const levelName = req.getLevelname()
        const level = levels.get(levelName)
        if (level == null) {
          // TODO: socket.emit('error:level-not-found') or something similar
          return
        }
        let platform = 0
        try {
          platform = req.getPlatform()
        } catch (err) {
          logError('play:request.getting platform', err)
        }

        const { game, clientID, arena, playerIndex } = games.addClientToGame(
          level,
          platform
        )

        const createdGame = new GameCreated()
        createdGame.setGameid(game.gameID)
        createdGame.setClientid(clientID)
        createdGame.setArena(arena.pack())
        createdGame.setPlayerindex(playerIndex)

        socket.emit('game:created', createdGame.serializeBinary().toString())
        gameSockets.addSocketFor(io, socket, game, clientID, playerIndex)
      } catch (err) {
        logError('play:request', err)
      }
    })
})

process.on('uncaughtException', (err: Error) => {
  logError('unhandled', err)
})

app.listen(PORT)
