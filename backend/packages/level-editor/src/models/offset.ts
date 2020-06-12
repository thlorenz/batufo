export class Offset {
  constructor(readonly x: number, readonly y: number) {}

  equals(other: Offset) {
    if (other == null) return false
    return other.x === this.x && other.y === this.y
  }

  static get empty() {
    return new Offset(0, 0)
  }
}
