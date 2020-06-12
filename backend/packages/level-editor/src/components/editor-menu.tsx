import { AppController } from '../controllers'
import React from 'react'
import styled from 'styled-components'
import { EditorMode } from '../types'

const MenuContainer = styled.div`
  display: flex;
  justify-content: space-between;
  height: 50px;
`

const MenuButton = styled.input`
  cursor: pointer;
  font-size: 22px;
  display: inline;
  margin: 5px 5px 0 20px;
`

const EditorModeSelectorContainer = styled.div`
  padding: 5px 5px 5px 15px;
`

export type EditorMenuProps = { app: AppController }
export function EditorMenuComponent({ app }: EditorMenuProps) {
  const editorMode = app.useEditorMode()
  return (
    <MenuContainer>
      <EditorModeSelectorContainer>
        {...EditorModeSelector('default', editorMode, app)}
        {...EditorModeSelector('vim', editorMode, app)}
        {...EditorModeSelector('emacs', editorMode, app)}
      </EditorModeSelectorContainer>
    </MenuContainer>
  )
}

function EditorModeSelector(
  mode: EditorMode,
  selectedMode: EditorMode,
  app: AppController
) {
  return [
    <MenuButton
      type="radio"
      checked={selectedMode === mode}
      name="mode"
      onClick={() => app.setEditorMode(mode)}
    />,
    <label>{mode}</label>,
  ]
}
