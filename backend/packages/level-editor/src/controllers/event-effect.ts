import EventEmitter from 'eventemitter3'

import { EffectCallback, useEffect, useState } from 'react'

export function eventEffect<T>(
  owner: EventEmitter,
  event: string,
  initialValue: T,
  onEvent: (arg: T) => void = (_: T) => {}
): T {
  const [state, setState]: [
    T | null,
    React.Dispatch<React.SetStateAction<T>>
  ] = useState(initialValue)

  const effect: EffectCallback = () => {
    const handleEvent = (arg: T) => {
      setState(arg)
      onEvent(arg)
    }
    owner.on(event, handleEvent)
    return () => {
      owner.off(event, handleEvent)
    }
  }
  useEffect(effect)

  return state
}
