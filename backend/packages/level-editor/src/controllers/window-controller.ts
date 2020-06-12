import EventEmitter from 'eventemitter3'
import { KeyEvent } from '../types'

export class WindowController extends EventEmitter {
  constructor() {
    super()
    window.onkeypress = (e: KeyboardEvent) => {
      const event: KeyEvent = {
        code: e.code,
        key: e.key,
        shift: e.shiftKey,
        ctrl: e.ctrlKey,
        alt: e.altKey,
        meta: e.metaKey,
        event: e,
      }
      this.emit('keypress', event)
    }
  }
}
