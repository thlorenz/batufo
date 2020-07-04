import { strict as assert } from 'assert'
import { Point } from '../rpc/packing-types'
import { PackedTeleport } from '../generated/message_bus_pb'

export class Teleport {
  constructor(readonly portA: Point, readonly portB: Point) {}

  pack(): PackedTeleport {
    const packedTeleport = new PackedTeleport()
    packedTeleport.setPorta(this.portA.pack())
    packedTeleport.setPortb(this.portB.pack())
    return packedTeleport
  }

  static unpack(data: PackedTeleport): Teleport {
    const packedPortA = data.getPorta()
    const packedPortB = data.getPortb()

    assert(packedPortA != null, 'data was missing portA')
    assert(packedPortB != null, 'data was missing portB')

    const portA = Point.unpack(packedPortA)
    const portB = Point.unpack(packedPortB)
    return new Teleport(portA, portB)
  }
}
