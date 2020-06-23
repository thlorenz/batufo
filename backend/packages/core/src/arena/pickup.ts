import { strict as assert } from 'assert'
import { TilePosition } from './tile-position'
import {
  PackedPickup,
  PackedPickupType,
  PackedPickupTypeMap,
} from '../generated/message_bus_pb'

export enum PickupType {
  Medkit,
  Shield,
  Bomb,
}

function unpackPickupType(
  data: typeof PackedPickupType[keyof PackedPickupTypeMap]
): PickupType {
  return data
}

function packPickupType(
  type: PickupType
): typeof PackedPickupType[keyof PackedPickupTypeMap] {
  return type
}

export class Pickup {
  constructor(readonly type: PickupType, readonly tilePosition: TilePosition) {}

  pack(): PackedPickup {
    const packedType = packPickupType(this.type)
    const packedTilePosition = this.tilePosition.pack()

    const packedPickup = new PackedPickup()
    packedPickup.setType(packedType)
    packedPickup.setTileposition(packedTilePosition)
    return packedPickup
  }

  static unpack(data: PackedPickup): Pickup {
    const type = unpackPickupType(data.getType())

    const packedTilePosition = data.getTileposition()
    assert(packedTilePosition != null, 'pickup cannot be missing tilePosition')
    const tilePosition = TilePosition.unpack(packedTilePosition)

    return new Pickup(type, tilePosition)
  }
}
