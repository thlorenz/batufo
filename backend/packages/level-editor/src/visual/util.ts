import { Offset } from '../models/offset'

export function relativeOffset(e: MouseEvent) {
  if (e.target == null) return Offset.empty
  // @ts-ignore getBoundingClientRect does exist
  const rect = e.target.getBoundingClientRect()
  const x = e.clientX - rect.left
  const y = e.clientY - rect.top
  return new Offset(x, y)
}
