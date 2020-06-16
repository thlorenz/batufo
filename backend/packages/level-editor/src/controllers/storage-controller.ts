import { LevelEncoder } from '@batufo/core'
import debounce from 'debounce'
import EventEmitter from 'eventemitter3'

const CURRENT_LEVEL = 'current-level'
export class StorageController extends EventEmitter {
  private readonly _storage: Storage
  private readonly _levelEncoder: LevelEncoder
  private readonly _syncLevel: () => void

  private _syncedLevel: string
  private _currentLevel: string

  constructor(readonly syncWait: number = 3e3) {
    super()
    this._storage = window.localStorage
    this._levelEncoder = new LevelEncoder()
    this._syncedLevel = ''
    this._currentLevel = ''

    this._syncLevel = debounce(this._doSyncLevel, syncWait)
  }

  setCurrentLevel = (level: string) => {
    this._currentLevel = level
    this._syncLevel()
  }

  getCurrentLevel(): string | null {
    const encoded = this._storage.getItem(CURRENT_LEVEL)
    if (encoded == null) return null
    try {
      const decoded = this._levelEncoder.decode(encoded)
      return decoded
    } catch (err) {
      console.error(err)
      return null
    }
  }

  setConfig<T extends string>(key: string, value: T) {
    this._storage.setItem(key, value)
  }
  getConfig<T extends string>(key: string, defaultVal: T): T {
    return (this._storage.getItem(key) || defaultVal) as T
  }

  _doSyncLevel = () => {
    if (this._syncedLevel == this._currentLevel) return
    const encoded = this._levelEncoder.encode(this._currentLevel)
    this._storage.setItem(CURRENT_LEVEL, encoded)
    this.emit('synced-level', encoded)
    this._syncedLevel = this._currentLevel
  }
}
