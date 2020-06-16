import { LevelEncoder } from '@batufo/core'

function insertUrlQuery(key: string, value: string) {
  if (typeof history.pushState === 'function') {
    const searchParams = new URLSearchParams(window.location.search)
    searchParams.set(key, value)
    const url =
      `${window.location.protocol}//${window.location.host}` +
      `${window.location.pathname}?${searchParams}`
    window.history.pushState({ path: url }, '', url)
  }
}

function getUrlQuery(key: string) {
  const urlParams = new URLSearchParams(window.location.search)
  return urlParams.get(key)
}
export class QueryController {
  private readonly _levelEncoder: LevelEncoder
  constructor() {
    this._levelEncoder = new LevelEncoder()
  }

  syncLevel = (encodedLevel: string) => {
    insertUrlQuery('l', encodedLevel)
  }

  getLevel(): string | null {
    const encoded = getUrlQuery('l')
    if (encoded == null) return null

    try {
      const decoded = this._levelEncoder.decode(encoded)
      return decoded
    } catch (err) {
      console.error(err)
      return null
    }
  }
}
