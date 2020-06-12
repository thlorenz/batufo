import { strict as assert } from 'assert'
import { PackedTilePosition } from '../generated/message_bus_pb'
import { FractionalPoint, Point } from '../rpc/packing-types'
import { WorldPosition } from './world-position'

export class TilePosition {
  constructor(
    readonly col: number,
    readonly row: number,
    readonly relX: number,
    readonly relY: number
  ) {}

  toWorldPosition = (tileSize: number) => WorldPosition.fromTilePosition(this, tileSize)

  pack(): PackedTilePosition {
    const colRow = new Point(this.col, this.row).pack()
    const relXY = new FractionalPoint(this.relX, this.relY).pack()
    const packedTilePosition = new PackedTilePosition()
    packedTilePosition.setColrow(colRow)
    packedTilePosition.setRelxy(relXY)
    return packedTilePosition
  }

  static unpack(data: PackedTilePosition): TilePosition {
    const cr = data.getColrow()
    const xy = data.getRelxy()
    assert(cr != null, 'data was missing colRow')
    assert(xy != null, 'data was missing relXy')
    const colRow = Point.unpack(cr)
    const relXY = FractionalPoint.unpack(xy)
    return new TilePosition(colRow.x, colRow.y, relXY.x, relXY.y)
  }

  toString() {
    return `TilePosition {
      col: ${this.col + this.relX}
      row: ${this.row + this.relY}
    }`
  }
}
