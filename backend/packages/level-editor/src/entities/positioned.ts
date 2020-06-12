import { Canvas } from '../visual/canvas'
import { TilePosition } from '@batufo/core/dist/arena'
import { Rect } from '../visual/rect'

export abstract class Positioned {
  readonly _rects: Rect[] = []
  readonly tiles: Set<String> = new Set()

  update(positions: TilePosition[], tileSize: number) {
    this._rects.length = 0
    this.tiles.clear()
    const w = tileSize
    for (const position of positions) {
      this.tiles.add(`${position.col}:${position.row}`)
      const wp = position.toWorldPosition(tileSize)
      const rect = Rect.fromLTWH(wp.x - w / 2, wp.y - w / 2, w, w)
      this._rects.push(rect)
    }
  }

  render(canvas: Canvas) {
    for (const rect of this._rects) {
      this.renderRect(canvas, rect)
    }
  }

  abstract renderRect(canvas: Canvas, rect: Rect): void
}
