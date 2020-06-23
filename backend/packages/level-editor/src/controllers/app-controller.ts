import { Canvas, Images, Level, TileSelectedEventArgs } from '../visual'
import EventEmitter from 'eventemitter3'
import { Arena, Tilemap } from '@batufo/core'
import { EditorLevel, EditorMode, KeyEvent, PaintType } from '../types'
import { TextController } from './text-controller'
import { Cursor, levels, Offset } from '../models'
import { Ace } from 'ace-builds'
import { WindowController } from './window-controller'
import { eventEffect } from './event-effect'
import { StorageController } from './storage-controller'
import { QueryController } from './query-controller'

const EDITOR_MODE = 'editor-mode'
export class AppController extends EventEmitter {
  private _cursor: Cursor
  private _paintType: PaintType
  private _editorMode: EditorMode
  private _aceEditor?: Ace.Editor

  constructor(
    private readonly _windowController: WindowController,
    private readonly _textController: TextController,
    private readonly _storageController: StorageController,
    private readonly _queryController: QueryController,
    private readonly _level: Level,
    private _currentLevel: EditorLevel,
    private _tileSize: number,
    readonly images: Images
  ) {
    super()
    this._cursor = Cursor.empty
    this._level
      .on('tile-selected', this._onEditorTileSelected)
      .on('tile-draw', this._onEditorTileSelected)
      .on('tile-hover', this._onEditorTileHover)

    this._windowController.on('keypress', this._onKeyPress)
    this._storageController.on('synced-level', this._queryController.syncLevel)

    this._paintType = 'none'
    this._editorMode = this._storageController.getConfig(EDITOR_MODE, 'vscode')
  }

  handleAceEditorLoaded = (aceEditor: Ace.Editor) => {
    this._aceEditor = aceEditor
    // TODO: how can we actually do this?
    // aceEditor.execCommand(':imap jk <Esc>')
  }

  moveEditorCursorToPosition(position: Offset) {
    this._aceEditor?.moveCursorToPosition({
      column: position.x,
      row: position.y,
    })
  }

  focusEditor() {
    this._aceEditor?.focus()
  }

  get isEditorFocused(): boolean {
    return this._aceEditor != null && this._aceEditor.isFocused()
  }

  //
  // Editor Text
  //
  useEditorText = () => {
    return eventEffect(
      this,
      'editor-text-changed',
      this._textController.text,
      (text: string) => {
        this._textController.text = text
        this._updateLevelArena()
        if (this._currentLevel === 'custom') return
        if (text !== levels.get(this._currentLevel)) {
          this.setCurrentLevel('custom')
        }
      }
    )
  }

  setEditorText(text: string) {
    this.emit('editor-text-changed', text)
  }

  //
  // Editor Cursor
  //
  useEditorCursor = () => {
    return eventEffect(
      this,
      'editor-cursor-changed',
      this._cursor,
      (cursor: Cursor) => {
        this._cursor = cursor
        this._updateLevelHiglightedTile()
      }
    )
  }

  setEditorCursor(cursor: Cursor) {
    if (this._cursor.equals(cursor)) return
    this.emit('editor-cursor-changed', cursor)
    this._setCoordinates(cursor.position)
  }

  _onEditorTileSelected = ({ cursor }: TileSelectedEventArgs) => {
    const text = this._textController.applyPaintAtCursor(
      cursor.position,
      this._paintType
    )
    this.setEditorText(text)
    this.emit('editor-cursor-changed', cursor)
  }

  _onEditorTileHover = ({ cursor, tile }: TileSelectedEventArgs) => {
    this._updateLevelHoveredTile(cursor.position, tile)
  }

  //
  // Zoom/TileSize
  //
  useTileSize = () => {
    return eventEffect(
      this,
      'tilesize-changed',
      this._tileSize,
      (tileSize: number) => {
        this._tileSize = tileSize
        this._updateLevelArena()
        this._updateLevelHiglightedTile()
      }
    )
  }

  setTileSize(tileSize: number) {
    this.emit('tilesize-changed', tileSize)
  }

  //
  // Paint Type
  //
  usePaintType = () => {
    return eventEffect(
      this,
      'painttype-changed',
      this._paintType,
      (paintType: PaintType) => (this._paintType = paintType)
    )
  }

  setPaintType(paintType: PaintType) {
    this.emit('painttype-changed', paintType)
  }

  private _onKeyPress = ({ code, key }: KeyEvent) => {
    if (this.isEditorFocused) return
    switch (key) {
      case 'q':
        this.setPaintType('none')
        break
      case 'w':
        this.setPaintType('wall')
        break
      case 'e':
        this.setPaintType('erase')
        break
      case 'r':
        this.setPaintType('empty')
        break
      case 'a':
        this.setPaintType('bomb')
        break
      case 's':
        this.setPaintType('shield')
        break
      case 'd':
        this.setPaintType('medkit')
        break
      case 'f':
        this.setPaintType('player')
        break
      case 'u':
        this.undo()
        break
      default:
        console.log('ignoring [%s] [%s]', key, code)
    }
  }

  //
  // Editor Mode
  //
  useEditorMode = () => {
    return eventEffect(
      this,
      'editormode-changed',
      this._editorMode,
      (mode: EditorMode) => {
        this._editorMode = mode
        this._storageController.setConfig(EDITOR_MODE, mode)
      }
    )
  }

  setEditorMode = (mode: EditorMode) => {
    this.emit('editormode-changed', mode)
  }

  //
  // Editor Current Level
  //
  useEditorCurrentLevel = () => {
    return eventEffect(
      this,
      'currentlevel-changed',
      this._currentLevel,
      (level: EditorLevel) => {
        this._currentLevel = level
        const cannedLevel = levels.get(level)
        if (cannedLevel != null && cannedLevel != this._textController.text) {
          this.setEditorText(cannedLevel)
        }
      }
    )
  }

  setCurrentLevel(level: EditorLevel) {
    this.emit('currentlevel-changed', level)
  }

  //
  // Coordinates
  //
  useCoordinates = () => {
    // updated by hovering over a tile or by changing cursor position
    return eventEffect(this, 'coordinates-changed', Offset.empty)
  }

  private _setCoordinates(coordinates: Offset) {
    this.emit('coordinates-changed', coordinates)
  }

  //
  // Canvas
  //
  setCanvas(canvas: Canvas) {
    this._level.canvas = canvas
    this._updateLevelArena()
  }

  //
  // Editor Actions
  //
  undo = () => {
    this._aceEditor?.undo()
  }

  redo = () => {
    this._aceEditor?.redo()
  }

  //
  // Effects
  //
  _updateLevelArena() {
    try {
      const level = this._textController.text
      const tilemap = Tilemap.build(level)
      const arena = Arena.fromTilemap(tilemap, this._tileSize)
      this._level.updateArena(arena)
      this._level.render()
      this._storageController.setCurrentLevel(level)
    } catch (err) {
      // TODO: surface this error in the UI
      console.error(err)
    }
  }

  _updateLevelHiglightedTile() {
    this._level.updateHiglightedTileFromCursor(this._cursor.position)
    this._level.render()
  }

  _updateLevelHoveredTile(cursor: Offset, tile: Offset) {
    this._level.updateHiglightedTileFromCursor(cursor)
    this._level.render()
    this._setCoordinates(tile)
  }
}
