import { strict as assert } from 'assert'
import { PaintType } from '../types'
import { UnreachableCaseError } from '@batufo/core'
const wallImageURL = require('../assets/wall-metal.png')
const cursorWallURL = require('../assets/cursor.wall-metal.png')
const playerImageURL = require('../assets/player.png')
const shieldImageURL = require('../assets/shield.png')
const bombImageURL = require('../assets/bomb.png')
const medkitImageURL = require('../assets/medkit.png')
const emptyImageURL = require('../assets/empty.png')
const cursorPlayerURL = require('../assets/cursor.player.png')
const cursorTrashURL = require('../assets/cursor.trash.png')
const cursorArrowURL = require('../assets/cursor.arrow.png')
const cursorShieldURL = require('../assets/cursor.shield.png')
const cursorBombURL = require('../assets/cursor.bomb.png')
const cursorMedkitURL = require('../assets/cursor.medkit.png')
const cursorEmptyURL = require('../assets/cursor.empty.png')

export class Images {
  private readonly _images: Map<string, HTMLImageElement> = new Map()

  private constructor() {}

  getImage(key: string) {
    if (!this._images.has(key)) throw new Error(`unknown image ${key}`)
    return this._images.get(key)!
  }

  loadAll() {
    return Promise.all(
      [
        { img: 'wall', url: wallImageURL },
        { img: 'cursor:wall', url: cursorWallURL },
        { img: 'player', url: playerImageURL },
        { img: 'shield', url: shieldImageURL },
        { img: 'bomb', url: bombImageURL },
        { img: 'medkit', url: medkitImageURL },
        { img: 'empty', url: emptyImageURL },
        { img: 'cursor:player', url: cursorPlayerURL },
        { img: 'cursor:shield', url: cursorShieldURL },
        { img: 'cursor:bomb', url: cursorBombURL },
        { img: 'cursor:medkit', url: cursorMedkitURL },
        { img: 'cursor:trash', url: cursorTrashURL },
        { img: 'cursor:arrow', url: cursorArrowURL },
        { img: 'cursor:empty', url: cursorEmptyURL },
      ].map((x) => this._load(x.img, x.url))
    )
  }

  iconForPaintType(paintType: PaintType) {
    switch (paintType) {
      case 'none':
        return this.getImage('cursor:arrow')
      case 'wall':
        return this.getImage('cursor:wall')
      case 'player':
        return this.getImage('cursor:player')
      case 'shield':
        return this.getImage('cursor:shield')
      case 'bomb':
        return this.getImage('cursor:bomb')
      case 'medkit':
        return this.getImage('cursor:medkit')
      case 'erase':
        return this.getImage('cursor:trash')
      case 'empty':
        return this.getImage('cursor:empty')
      default:
        throw new UnreachableCaseError(paintType)
    }
  }

  cursorForPaintType(paintType: PaintType) {
    if (paintType == 'none') return 'auto'
    const icon = this.iconForPaintType(paintType)
    return icon == null ? 'auto' : `url('${icon.currentSrc}') 15 15, auto`
  }

  _load(img: string, url: string) {
    return new Promise((resolve, reject) => {
      const image = new Image()
      image.onload = resolve
      image.onerror = reject
      image.src = url
      this._images.set(img, image)
    })
  }

  static _instance: Images | undefined

  static get instance(): Images {
    assert(Images._instance != null, 'images have not initialized yet')
    return Images._instance
  }

  static async create() {
    const images = new Images()
    await images.loadAll()
    Images._instance = images
    return images
  }
}
