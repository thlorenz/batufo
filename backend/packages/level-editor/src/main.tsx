import React from 'react'
import ReactDOM from 'react-dom'
import { AppComponent } from './components/app'
import { Images, Level } from './visual'
import { AppController, TextController } from './controllers'
import { WindowController } from './controllers/window-controller'

const sample = `=======================
=                     =
=                     =
=====             =====
=     ====        =
=   d =  =        =
=     ====        =
=====             ========
=   +                    =
=    p                ====
=======================
`

const mountNode = document.getElementById('app')
async function main() {
  const images = await Images.create()

  const textController = new TextController(sample)
  const level = new Level(images)

  const windowController = new WindowController()
  const app = new AppController(
    windowController,
    textController,
    level,
    40,
    images
  )
  ReactDOM.render(<AppComponent app={app} />, mountNode)
}

main().catch((err) => console.error(err))
