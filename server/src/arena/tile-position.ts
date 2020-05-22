export class TilePosition {
  constructor(
    readonly col: number,
    readonly row: number,
    readonly relX: number,
    readonly relY: number
  ) {}

  toString() {
    return `TilePosition {
      col: ${this.col + this.relX}
      row: ${this.row + this.relY}
    }`;
  }
}
