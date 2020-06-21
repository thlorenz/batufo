import React from 'react'
import SplitPane from 'react-split-pane'
import { EditorComponent } from './editor'
import { VisualComponent } from './visual'
import { AppController } from '../controllers'
import { VisualMenuComponent } from './visual-menu'
import styled from 'styled-components'
import { EditorMenuComponent } from './editor-menu'

const EditorArea = styled.div``
const VisualArea = styled.div``

export type AppProps = { app: AppController }

export function AppComponent({ app }: AppProps) {
  return (
    <SplitPane
      split="vertical"
      minSize={200}
      defaultSize={'30%'}
      pane2Style={{ overflow: 'scroll' }}
    >
      <EditorArea>
        <EditorMenuComponent app={app} />
        <EditorComponent app={app} />
      </EditorArea>
      <VisualArea>
        <VisualMenuComponent app={app} />
        <VisualComponent app={app} />
      </VisualArea>
    </SplitPane>
  )
}
