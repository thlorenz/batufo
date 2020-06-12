import { Grid } from './grid'
import { Arena } from '@batufo/core'

class Level {
  readonly _grid: Grid
  arena: Arena

  constructor(
    readonly canvasElement: HTMLCanvasElement,
    readonly canvas: CanvasRenderingContext2D,
  ) {
    this._grid = new Grid(tileSize)
    this.arena = Arena.empty()
  }

  update(arena: Arena) {
    this.arena = arena
    const ncols = arena.ncols
    const nrows = arena.nrows
    const tileSize = arena.tileSize
    this.canvasElement.width = ncols * tileSize
    this.canvasElement.height = nrows * tileSize
  }

  render() {
    this._renderBackground()
    this._grid.render(this.canvas, this.arena.nrows, this.arena.ncols)
  }

  _renderBackground() {
    this.canvas.fillStyle = 'white'
    this.canvas.fillRect(0, 0, this.canvasElement.width,
      this.canvasElement.height)
  }
}

class Editor {
  constructor(
    readonly level: Level,
  ) {}

  update(arena: Arena) {
    this.level.update(arena)
    this.level.render()
  }
}

const tileSize = 40

const canvasElement: HTMLCanvasElement = document.getElementById(
  'canvas',
) as HTMLCanvasElement
const canvas = canvasElement.getContext('2d')!
const level = new Level(canvasElement, canvas)
const editor = new Editor(level)
const arena = Arena.forLevel('single player', tileSize)
editor.update(arena)

console.log('running')
