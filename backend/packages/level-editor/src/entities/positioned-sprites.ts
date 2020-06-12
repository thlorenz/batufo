import { Canvas } from '../visual/canvas'
import { Positioned } from './positioned'
import { Rect } from '../visual/rect'

export class PositionedSprites extends Positioned {
  constructor(readonly _image: HTMLImageElement) {
    super()
  }

  renderRect(canvas: Canvas, rect: Rect) {
    canvas.drawImage(rect, this._image)
  }
}
