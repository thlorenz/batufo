import { strict as assert } from 'assert'
import { Offset } from '../models'
import { PaintType } from '../types'
import { UnreachableCaseError } from '@batufo/core'

function charForPaint(paintType: PaintType) {
  switch (paintType) {
    case 'none':
      return null
    case 'wall':
      return '='
    case 'player':
      return 'p'
    case 'shield':
      return 's'
    case 'bomb':
      return 'b'
    case 'medkit':
      return '+'
    case 'empty':
      return 'x'
    case 'erase':
      return ' '
    default:
      throw new UnreachableCaseError(paintType)
  }
}

export class TextController {
  constructor(private _text: string) {}

  get text(): string {
    return this._text
  }

  set text(value: string) {
    assert(value != null, 'cannot set text to null')
    this._text = value
  }

  applyPaintAtCursor(cursor: Offset, paintType: PaintType) {
    const char = charForPaint(paintType)
    if (char == null) return this._text
    const rows = this._text.split('\n')
    const line = rows[cursor.y]
    const updated = `${line.slice(0, cursor.x)}${char}${line.slice(
      cursor.x + 1
    )}`
    rows[cursor.y] = updated
    return rows.join('\n')
  }

  getLeadingEmptyLines = () => {
    const lines = this._text.split('\n')
    for (let i = 0; i < lines.length; i++) {
      if (lines[i].trim().length > 0) return i
    }
    return lines.length - 1
  }
}
