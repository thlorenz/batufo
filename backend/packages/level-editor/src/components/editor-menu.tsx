import { AppController } from '../controllers'
import React from 'react'
import styled from 'styled-components'
import { EditorLevel, EditorMode } from '../types'

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
  padding: 5px 5px 5px 5px;
`

const LevelSelect = styled.select`
  margin: 0 5px 0 0;
  cursor: pointer;
`

export type EditorMenuProps = { app: AppController }
export function EditorMenuComponent({ app }: EditorMenuProps) {
  const editorMode = app.useEditorMode()
  const currentLevel = app.useEditorCurrentLevel()
  return (
    <MenuContainer>
      <EditorModeSelectorContainer>
        {...EditorModeSelector('vscode', editorMode, app)}
        {...EditorModeSelector('vim', editorMode, app)}
        {...EditorModeSelector('emacs', editorMode, app)}
      </EditorModeSelectorContainer>
      <LevelSelect
        name="cars"
        id="cars"
        onChange={(e) => app.setCurrentLevel(e.target.value as EditorLevel)}
      >
        {levelOption('custom', currentLevel)}
        {levelOption('square', currentLevel)}
      </LevelSelect>
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
      key={mode}
      type="radio"
      checked={selectedMode === mode}
      name="mode"
      onChange={() => app.setEditorMode(mode)}
    />,
    <label key={`${mode}-label`}>{mode}</label>,
  ]
}

function levelOption(level: EditorLevel, selectedLevel: EditorLevel) {
  return (
    <option value={level} selected={level === selectedLevel}>
      {level}
    </option>
  )
}
