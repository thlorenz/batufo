import { strict as assert } from 'assert'
import { Floors, Grid } from '../entities'

import {
  Arena,
  Pickup,
  PickupType,
  TilePosition,
  WorldPosition,
} from '@batufo/core'
import { Canvas } from './canvas'
import { Images } from './images'
import { Rect } from './rect'

import EventEmitter from 'eventemitter3'
import { relativeOffset } from './util'
import { Cursor, Offset } from '../models'
import { UpdateOrigin } from '../types'
import { PositionedSprites } from '../entities/positioned-sprites'

export type TileSelectedEventArgs = { tile: Offset; cursor: Cursor }

const origin: UpdateOrigin = 'visual'

function pickupPositionsForType(pickups: Pickup[], type: PickupType) {
  return pickups.filter((x) => x.type === type).map((x) => x.tilePosition)
}

export class Level extends EventEmitter {
  arena?: Arena
  highlightedPosition?: WorldPosition
  hoveredTilePosition?: TilePosition
  private readonly _grid: Grid
  private readonly _walls: PositionedSprites
  private readonly _floors: Floors
  private readonly _players: PositionedSprites
  private readonly _shields: PositionedSprites
  private readonly _bombs: PositionedSprites
  private readonly _medkits: PositionedSprites
  private readonly _empties: PositionedSprites

  constructor(readonly images: Images) {
    super()
    this._empties = new PositionedSprites(images.getImage('empty'))
    this._grid = new Grid()
    this._walls = new PositionedSprites(images.getImage('wall'))
    this._floors = new Floors()
    this._players = new PositionedSprites(images.getImage('player'))
    this._shields = new PositionedSprites(images.getImage('shield'))
    this._bombs = new PositionedSprites(images.getImage('bomb'))
    this._medkits = new PositionedSprites(images.getImage('medkit'))
  }

  private _canvas?: Canvas

  get canvas(): Canvas | undefined {
    return this._canvas
  }

  set canvas(canvas: Canvas | undefined) {
    assert(canvas != null, 'cannot set invalid canvas')

    canvas.on('clicked', (e: MouseEvent) => {
      this.emit('canvas-clicked', e)
      this._handleCanvasClicked(e)
    })
    canvas.on('hover', (e: MouseEvent) => {
      this.emit('canvas-hover', e)
      this._handleCanvasHover(e)
    })
    canvas.on('draw', (e: MouseEvent) => {
      this.emit('canvas-draw', e)
      this._handleCanvasDraw(e)
    })
    canvas.on('shift:down', (e: KeyboardEvent) =>
      this.emit('canvas-shift:down', e)
    )
    canvas.on('shift:up', (e: KeyboardEvent) => this.emit('canvas-shift:up', e))

    this._canvas = canvas
  }

  updateArena(arena: Arena) {
    this.arena = arena

    const shields = pickupPositionsForType(arena.pickups, PickupType.Shield);
    const bombs = pickupPositionsForType(arena.pickups, PickupType.Bomb);
    const medkits = pickupPositionsForType(arena.pickups, PickupType.Medkit);

    this._walls.update(arena.walls, arena.tileSize)
    this._floors.update(arena.floorTiles, arena.tileSize)
    this._players.update(arena.players, arena.tileSize)
    this._shields.update(shields, arena.tileSize)
    this._bombs.update(bombs, arena.tileSize)
    this._medkits.update(medkits, arena.tileSize)

    const emptyTiles = this._determineEmptyTiles(arena)
    this._empties.update(emptyTiles, arena.tileSize)
  }

  updateHiglightedTileFromCursor(offset: Offset) {
    if (this.arena == null) return
    const tp = new TilePosition(offset.x, this.arena.nrows - offset.y - 1, 0, 0)
    this.updateHiglightedTileFromTilePosition(tp)
  }

  updateHiglightedTileFromTilePosition(tilePosition: TilePosition) {
    if (this.arena == null) return
    this.highlightedPosition = tilePosition.toWorldPosition(this.arena.tileSize)
  }

  render() {
    if (this.arena == null) return
    if (this.canvas == null) return
    const ncols = this.arena.ncols
    const nrows = this.arena.nrows
    const tileSize = this.arena.tileSize
    this.canvas.width = ncols * tileSize
    this.canvas.height = nrows * tileSize

    this.canvas.originLowerLeft()
    this._empties.render(this.canvas)
    this._walls.render(this.canvas)
    this._floors.render(this.canvas)
    this._players.render(this.canvas)
    this._shields.render(this.canvas)
    this._bombs.render(this.canvas)
    this._medkits.render(this.canvas)
    this._grid.render(
      this.canvas,
      this.arena.tileSize,
      this.arena.nrows,
      this.arena.ncols
    )
    this._renderHighlightTile()
  }

  private _renderHighlightTile() {
    if (this.canvas == null) return
    if (this.highlightedPosition == null) return
    if (this.arena == null) return
    const rect = Rect.fromLTWH(
      this.highlightedPosition.x,
      this.highlightedPosition.y,
      this.arena.tileSize,
      this.arena.tileSize
    )
    this.canvas.drawRect(rect, 'darkblue', 4)
  }

  private _determineEmptyTiles(arena: Arena) {
    const emptyTiles = []
    const rel = arena.tileSize / 2
    for (let col = 0; col < arena.ncols; col++) {
      for (let row = 0; row < arena.nrows; row++) {
        const tile = `${col}:${row}`
        if (this._walls.tiles.has(tile)) continue
        if (this._floors.tiles.has(tile)) continue
        if (this._players.tiles.has(tile)) continue
        emptyTiles.push(new TilePosition(col, row, rel, rel))
      }
    }
    return emptyTiles
  }

  private _trulyInsideTile(tilePosition: TilePosition) {
    // consider changing tiles only once we are close enough to the center
    // this prevents unwanted tile changes, i.e. when trying to draw diagonal
    // this is only applied when drawing
    if (this.arena == null) return false
    const delta = this.arena.tileSize * 0.7
    if (Math.abs(tilePosition.relX) > delta) return false
    if (Math.abs(tilePosition.relY) > delta) return false
    return true
  }

  private _tileAndCursorFromEvent(e: MouseEvent) {
    if (this.arena == null) return
    const offset = relativeOffset(e)
    const wp = new WorldPosition(offset.x, offset.y)
    const tilePosition = wp.toTilePosition(this.arena.tileSize)
    if (this.canvas?.isMouseDown && !this._trulyInsideTile(tilePosition)) return
    const tile = new Offset(
      Math.floor(tilePosition.col),
      this.arena.nrows - Math.floor(tilePosition.row) - 1
    )
    const cursor = new Cursor(
      new Offset(Math.floor(tilePosition.col), Math.floor(tilePosition.row)),
      origin
    )
    return { tile, cursor }
  }

  private _handleCanvasClicked(e: MouseEvent) {
    const res = this._tileAndCursorFromEvent(e)
    if (res == null) return
    this.emit('tile-selected', res)
  }

  private _handleCanvasHover(e: MouseEvent) {
    const res = this._tileAndCursorFromEvent(e)
    if (res == null) return
    this.emit('tile-hover', res)
  }

  private _handleCanvasDraw(e: MouseEvent) {
    const res = this._tileAndCursorFromEvent(e)
    if (res == null) return
    this.emit('tile-draw', res)
  }
}
