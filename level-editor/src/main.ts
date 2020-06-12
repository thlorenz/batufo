import { Grid } from './grid'

class Level {
  readonly _grid: Grid
  _nrows: number
  _ncols: number

  constructor(
    readonly canvasElement: HTMLCanvasElement,
    readonly canvas: CanvasRenderingContext2D,
    readonly _tileSize: number
  ) {
    this._grid = new Grid(tileSize)
    this._nrows = 0
    this._ncols = 0
  }

  update(nrows: number, ncols: number) {
    this._nrows = nrows
    this._ncols = ncols
    this.canvasElement.width = this._ncols * this._tileSize
    this.canvasElement.height = this._nrows * this._tileSize
  }

  render() {
    this._renderBackground()
    this._grid.render(this.canvas, this._nrows, this._ncols)
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

  update(nrows: number, ncols: number) {
    this.level.update(nrows, ncols)
    this.level.render()
  }
}

const tileSize = 40

const canvasElement: HTMLCanvasElement = document.getElementById(
  'canvas',
) as HTMLCanvasElement
const canvas = canvasElement.getContext('2d')!
const level = new Level(canvasElement, canvas, tileSize)
const editor = new Editor(level)
const nrows = 20
const ncols = 10
editor.update(nrows, ncols)

console.log('running')
