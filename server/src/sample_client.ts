import io from 'socket.io-client'
const socket = io.connect('http://localhost:2222')

socket.on('game:started', (data: any) => {
  console.log(data)
  socket.emit('game:request', { my: 'data' })
})
