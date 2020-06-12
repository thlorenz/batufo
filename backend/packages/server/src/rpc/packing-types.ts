import { DoubleTwoDecimals, PackedFractionalPoint, PackedPoint } from '../generated/message_bus_pb'

const doubleToInt = (value: number, factor: number) =>
  Math.floor(value * factor)

export function packTwoDecimals(value: number): DoubleTwoDecimals {
  const d2d = new DoubleTwoDecimals()
  d2d.setValue(doubleToInt(value, 1e2))
  return d2d
}

export function packFourDecimals(value: number): DoubleTwoDecimals {
  const d4d = new DoubleTwoDecimals()
  d4d.setValue(doubleToInt(value, 1e4))
  return d4d
}

export function unpackTwoDecimals(data: DoubleTwoDecimals): number {
  return data.getValue() / 1e2
}

export function unpackFourDecimals(data: DoubleTwoDecimals): number {
  return data.getValue() / 1e4
}

export class Point {
  constructor(readonly x: number, readonly y: number) {}

  // 0000 0000 0000 0000 1111 1111 1111 1111
  static mask = 0xffff
  static shift = 16

  pack(): PackedPoint {
    const xy = (this.x << Point.shift) | this.y
    const point = new PackedPoint()
    point.setXy(xy)
    return point
  }

  static unpack(data: PackedPoint): Point {
    const xy = data.getXy()
    const y = xy & Point.mask
    const x = xy >> Point.shift
    return new Point(x, y)
  }

  toString(): string {
    return `Point { x: ${this.x}, y: ${this.y} }`
  }
}

export class FractionalPoint {
  static mask = 0xffff
  static signMask = 0x8000
  static unsignMask = 0x7fff

  static factor = 1e2

  constructor(readonly x: number, readonly y: number) {}

  pack(): PackedFractionalPoint {
    const sintX = Math.floor(this.x * FractionalPoint.factor)
    const sintY = Math.floor(this.y * FractionalPoint.factor)

    const signX = sintX < 0 ? FractionalPoint.signMask : 0
    const signY = sintY < 0 ? FractionalPoint.signMask : 0
    const intX = Math.abs(sintX) | signX
    const intY = Math.abs(sintY) | signY
    const xy = (intX << 16) | intY
    const fp = new PackedFractionalPoint()
    fp.setXy(xy)
    return fp
  }

  static unpack(data: PackedFractionalPoint): FractionalPoint {
    const xy = data.getXy()
    const intY = xy & FractionalPoint.mask
    const intX = xy >> 16
    const xSigned = (intX & FractionalPoint.signMask) > 0
    const ySigned = (intY & FractionalPoint.signMask) > 0
    const x = xSigned ? -(intX & FractionalPoint.unsignMask) : intX
    const y = ySigned ? -(intY & FractionalPoint.unsignMask) : intY
    return new FractionalPoint(
      x / FractionalPoint.factor,
      y / FractionalPoint.factor
    )
  }
}
