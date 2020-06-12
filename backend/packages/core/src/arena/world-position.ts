import { TilePosition } from './tile-position'

export class WorldPosition {
  constructor(readonly x: number, readonly y: number) {}

  static fromTilePosition(tp: TilePosition, tileSize: number): WorldPosition {
    const t = tileSize
    const x = t * tp.col + tp.relX
    const y = t * tp.row + tp.relY
    return new WorldPosition(x, y)
  }

  toTilePosition(tileSize: number): TilePosition {
    const t = tileSize
    const col = this.x / t
    const row = this.y / t
    const relX = this.x % t
    const relY = this.y % t
    return new TilePosition(col, row, relX, relY)
  }
}
