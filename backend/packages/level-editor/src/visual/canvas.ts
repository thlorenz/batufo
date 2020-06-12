import { Rect } from './rect'

import EventEmitter from 'eventemitter3'
export class Canvas extends EventEmitter {
  private _isMouseDown: boolean = false
  constructor(
    readonly canvasElement: HTMLCanvasElement,
    readonly context: CanvasRenderingContext2D
  ) {
    super()
    canvasElement.onclick = (e: MouseEvent) => {
      this.emit('clicked', e)
    }
    canvasElement.onmousedown = (_: MouseEvent) => (this._isMouseDown = true)
    canvasElement.onmouseup = (_: MouseEvent) => (this._isMouseDown = false)
    canvasElement.onmousemove = (e: MouseEvent) => {
      if (this._isMouseDown) {
        this.emit('draw', e)
      } else {
        this.emit('hover', e)
      }
    }
  }

  get isMouseDown(): boolean {
    return this._isMouseDown
  }

  get width() {
    return this.canvasElement.width
  }
  set width(value: number) {
    this.canvasElement.width = value
  }
  get height() {
    return this.canvasElement.height
  }
  set height(value: number) {
    this.canvasElement.height = value
  }

  originLowerLeft() {
    this.context.translate(0, this.height)
    this.context.scale(1, -1)
  }

  fillRect(rect: Rect, fillStyle: CanvasRenderingContext2D['fillStyle']) {
    this.context.fillStyle = fillStyle
    this.context.fillRect(rect.left, rect.top, rect.width, rect.height)
  }

  drawRect(
    rect: Rect,
    strokeStyle: CanvasRenderingContext2D['strokeStyle'],
    lineWidth: number
  ) {
    this.context.strokeStyle = strokeStyle
    this.context.lineWidth = lineWidth
    this.context.strokeRect(rect.left, rect.top, rect.width, rect.height)
  }

  drawLine(
    x1: number,
    y1: number,
    x2: number,
    y2: number,
    strokeStyle: CanvasRenderingContext2D['strokeStyle'],
    lineWidth: number
  ) {
    this.context.strokeStyle = strokeStyle
    this.context.lineWidth = lineWidth
    this.context.beginPath()
    this.context.moveTo(x1, y1)
    this.context.lineTo(x2, y2)
    this.context.stroke()
  }

  drawImage(rect: Rect, image: HTMLImageElement) {
    this.context.drawImage(image, rect.left, rect.top, rect.width, rect.height)
  }
}
