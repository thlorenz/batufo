export class Rect {
  private constructor(
    readonly left: number,
    readonly top: number,
    readonly right: number,
    readonly bottom: number,
  ) {}

  get width() {
    return Math.abs(this.right - this.left)
  }

  get height() {
    return Math.abs(this.top - this.bottom)
  }

  static fromLTRB(left: number, top: number, right: number, bottom: number) {
    return new Rect(left, top, right, bottom)
  }

  static fromLTWH(left: number, top: number, width: number, height: number) {
    return Rect.fromLTRB(left, top, left + width, top + height)
  }
}
