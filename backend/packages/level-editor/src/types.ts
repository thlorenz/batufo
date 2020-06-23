export const PaintTypes = [
  'none',
  'wall',
  'player',
  'shield',
  'bomb',
  'medkit',
  'empty',
  'erase',
] as const

export type PaintType = typeof PaintTypes[number]

export type UpdateOrigin = 'editor' | 'visual' | 'none'

export type KeyEvent = {
  code: string
  key: string
  shift: boolean
  ctrl: boolean
  alt: boolean
  meta: boolean
  event: KeyboardEvent
}

export type EditorMode = 'vim' | 'emacs' | 'vscode'

export type EditorLevel = 'custom' | 'square'
