import { UpdateOrigin } from '../types'
import { Offset } from '../models'

export class Cursor {
  constructor(readonly position: Offset, readonly updateOrigin: UpdateOrigin) {}

  static get empty() {
    return new Cursor(Offset.empty, 'none')
  }

  equals(other: Cursor) {
    if (other == null) return false
    return (
      other.position === this.position &&
      other.updateOrigin === this.updateOrigin
    )
  }
}
