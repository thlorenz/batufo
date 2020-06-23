import { AppController } from '../controllers'
import React, { ChangeEvent } from 'react'
import styled from 'styled-components'
import { PaintType } from '../types'
import { strict as assert } from 'assert'
import { Offset } from '../models'

const MenuContainer = styled.div`
  display: flex;
  justify-content: space-between;
  height: 50px;
`

const Zoom = styled.div`
  padding: 5px 5px 0 5px;
`
const ZoomLabel = styled.span`
  padding: 0 10px 0 0;
`
const ZoomSlider = styled.input`
  cursor: pointer;
  margin: 10px 0 0 0;
  max-width: 80px;
`
const Coordinates = styled.span`
  padding: 10px 10px 0 20px;
  font-size: 16px;
  font-family: monospace;
`

const PaintTypeSelectorItem = styled.img`
  padding: 5px;
`

const MenuButton = styled.input`
  cursor: pointer;
  font-size: 22px;
  display: inline;
  margin: 5px 2px 0 0;
`

function formatCoordinates(coords: Offset) {
  const x = coords.x.toString().padStart(3, '0')
  const y = coords.y.toString().padStart(3, '0')
  return `${x}:${y}`
}

export type VisualMenuProps = { app: AppController }
export function VisualMenuComponent({ app }: VisualMenuProps) {
  function onTileSizeChanged(e: ChangeEvent<HTMLInputElement>) {
    const tileSize = parseInt(e.currentTarget.value)
    app.setTileSize(tileSize)
  }

  const tileSize = app.useTileSize()
  const coordinates = app.useCoordinates()
  return (
    <MenuContainer>
      <PaintTypeSelectors app={app} />
      <div>
        <MenuButton type="button" value={'↪️'} onClick={app.undo} />
        <MenuButton type="button" value={'↩️'} onClick={app.redo} />
      </div>

      <Zoom>
        <ZoomLabel>Zoom:</ZoomLabel>
        <ZoomSlider
          type="range"
          min="10"
          max="100"
          value={tileSize}
          onChange={onTileSizeChanged}
        />
      </Zoom>

      <Coordinates>{formatCoordinates(coordinates)}</Coordinates>
    </MenuContainer>
  )
}

const EntityDiv = styled.div`
  cursor: pointer;
`

type PaintTypeSelectorsProps = { app: AppController }

function PaintTypeSelectors({ app }: PaintTypeSelectorsProps) {
  return (
    <EntityDiv>
      <PaintTypeSelector app={app} paintType={'none'} />
      <PaintTypeSelector app={app} paintType={'wall'} />
      <PaintTypeSelector app={app} paintType={'erase'} />
      <PaintTypeSelector app={app} paintType={'empty'} />
      <PaintTypeSelector app={app} paintType={'bomb'} />
      <PaintTypeSelector app={app} paintType={'shield'} />
      <PaintTypeSelector app={app} paintType={'medkit'} />
      <PaintTypeSelector app={app} paintType={'player'} />
    </EntityDiv>
  )
}

type PaintTypeSelectorProps = {
  app: AppController
  paintType: PaintType
}

function PaintTypeSelector({ app, paintType }: PaintTypeSelectorProps) {
  const currentPaintType = app.usePaintType()
  const border =
    paintType === currentPaintType ? 'solid gray 4px' : 'solid transparent 4px'
  const image = app.images.iconForPaintType(paintType)
  assert(image != null, 'cannot show selector for paint type without icon')
  return (
    <PaintTypeSelectorItem
      style={{ border }}
      src={image.currentSrc}
      onClick={() => app.setPaintType(paintType)}
    />
  )
}
