import { Canvas } from '../visual/canvas'
import { Positioned } from './positioned'
import { Rect } from '../visual/rect'

export class Floors extends Positioned {
  renderRect(canvas: Canvas, rect: Rect) {
    canvas.fillRect(rect, 'antiquewhite')
  }
}
