import React from 'react'
import ReactDOM from 'react-dom'
import { AppComponent } from './components/app'
import { Images, Level } from './visual'
import {
  AppController,
  TextController,
  StorageController,
  QueryController,
} from './controllers'
import { WindowController } from './controllers/window-controller'
import { EditorLevel } from './types'
import { levels } from './models'

function getCurrentLevel(
  storageController: StorageController,
  queryController: QueryController
) {
  const queryLevel = queryController.getLevel()
  if (queryLevel != null) return queryLevel
  const currentLevel = storageController.getCurrentLevel()
  return currentLevel
}

const mountNode = document.getElementById('app')
async function main() {
  let editorLevel: EditorLevel = 'custom'

  const images = await Images.create()

  const storageController = new StorageController()
  const queryController = new QueryController()
  let currentLevel = getCurrentLevel(storageController, queryController)
  if (currentLevel == null) {
    editorLevel = 'square'
    currentLevel = levels.get(editorLevel)!
  }
  const textController = new TextController(currentLevel)
  const level = new Level(images)

  const windowController = new WindowController()
  const app = new AppController(
    windowController,
    textController,
    storageController,
    queryController,
    level,
    editorLevel,
    40,
    images
  )
  ReactDOM.render(<AppComponent app={app} />, mountNode)
}

main().catch((err) => console.error(err))
