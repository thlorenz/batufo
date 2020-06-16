import { EditorLevel } from '../types'

const square = `==========================
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=                        =
=    p                   =
=                        =
==========================
`

export const levels: Map<EditorLevel, string | null> = new Map([
  ['custom', null],
  ['square', square],
])
