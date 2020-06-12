import { Canvas } from '../visual/canvas'

const gridColor = 'gray'

export class Grid {
  constructor(
    readonly marginCols: number = 5.0,
    readonly marginRows: number = 5.0
  ) {}

  render(
    canvas: Canvas,
    tileSize: number,
    nrows: number,
    ncols: number,
  ) {
    const delta = tileSize
    const gameWidth = ncols * delta
    const gameHeight = nrows * delta
    const marginX = this.marginCols * delta
    const marginY = this.marginRows * delta
    const startX = -marginX
    const endX = gameWidth + marginX
    const startY = -marginY
    const endY = gameHeight + marginY

    for (let col = startX; col <= endX; col += delta) {
      canvas.drawLine(col, startY, col, endY, gridColor, 1)
    }
    for (let row = startY; row <= endY; row += delta) {
      canvas.drawLine(startX, row, endX, row, gridColor, 1)
    }
  }
}
