export class Grid {
  constructor(
    readonly _tileSize: number,
    readonly marginCols: number = 5.0,
    readonly marginRows: number = 5.0,
  ) {}

  _preparePaint(canvas: Canvas) {
    canvas.strokeStyle = 'black'
    canvas.lineWidth = 1
  }

  render(canvas: Canvas, nrows: number, ncols: number) {
    const delta = this._tileSize
    const gameWidth = ncols * delta
    const gameHeight = nrows * delta
    const marginX = this.marginCols * delta
    const marginY = this.marginRows * delta
    const startX = -marginX
    const endX = gameWidth + marginX
    const startY = -marginY
    const endY = gameHeight + marginY

    this._preparePaint(canvas)
    for (let col = startX; col <= endX; col += delta) {
      this._drawLine(canvas, col, startY, col, endY)
    }
    for (let row = startY; row <= endY; row += delta) {
      this._drawLine(canvas, startX, row, endX, row)
    }
  }

  _drawLine(canvas: Canvas, x1: number, y1: number, x2: number, y2: number) {
    canvas.beginPath()
    canvas.moveTo(x1, y1)
    canvas.lineTo(x2, y2)
    canvas.stroke()
  }
}
