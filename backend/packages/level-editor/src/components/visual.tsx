import React, { ReactElement, useEffect, useRef } from 'react'
import { Canvas } from '../visual'
import { AppController } from '../controllers'

export type VisualProps = { app: AppController }

export function VisualComponent({ app }: VisualProps): ReactElement {
  const canvasElement = useRef<HTMLCanvasElement>(null)
  const containerElement = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (canvasElement.current != null) {
      const context = canvasElement?.current.getContext('2d')
      if (context != null) {
        app.setCanvas(new Canvas(canvasElement.current, context))
      }
    }
  }, [])

  const paintType = app.usePaintType()
  const cursorIcon = app.images.cursorForPaintType(paintType)
  const cursor = app.useEditorCursor()
  const tileSize = app.useTileSize()

  if (app.isEditorFocused && cursor.updateOrigin === 'editor') {
    const el = containerElement.current
    if (el != null) {
      const centerX = el.clientWidth / 2
      const centerY = el.clientHeight / 2
      el.scroll({
        left: cursor.position.x * tileSize - centerX,
        top: cursor.position.y * tileSize - centerY,
      })
    }
  }

  return (
    <div
      style={{ cursor: cursorIcon, overflow: 'scroll', height: '90vh' }}
      ref={containerElement}
    >
      <canvas ref={canvasElement} />
    </div>
  )
}
