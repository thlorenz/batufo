import React from 'react'
import AceEditor from 'react-ace'
import { AppController } from '../controllers'
import { UpdateOrigin } from '../types'
import { Cursor, Offset } from '../models'

require('ace-builds/src-noconflict/keybinding-vim')
require('ace-builds/src-noconflict/keybinding-emacs')
require('ace-builds/src-noconflict/keybinding-vscode')
require('ace-builds/src-noconflict/theme-dracula')

let settingCursor = false

export type EditorProps = { app: AppController }

const origin: UpdateOrigin = 'editor'
export function EditorComponent({ app }: EditorProps) {
  const text = app.useEditorText()
  const cursor = app.useEditorCursor()
  const editorMode = app.useEditorMode()

  setTimeout(() => {
    if (cursor.updateOrigin !== origin) {
      settingCursor = true
      app.moveEditorCursorToPosition(cursor.position)
      settingCursor = false
    }
  }, 0)

  return (
    <AceEditor
      mode="text"
      theme="dracula"
      showGutter={false}
      showPrintMargin={false}
      wrapEnabled={false}
      enableBasicAutocompletion={false}
      fontSize={20}
      width={'100%'}
      height={'90vh'}
      value={text}
      keyboardHandler={editorMode}
      style={{ fontFamily: "'Roboto Mono', monospace", letterSpacing: '0.1em' }}
      onLoad={app.handleAceEditorLoaded}
      onChange={(text: string) => app.setEditorText(text)}
      onCursorChange={(e: any) => {
        if (settingCursor) return
        app.setEditorCursor(
          new Cursor(new Offset(e.cursor.column, e.cursor.row), origin)
        )
      }}
    />
  )
}
