// matches client/lib/setup/config.dart enum of same name
// and related message type
export const Platforms = [
  'MacOS',
  'Android',
  'Linux',
  'Windows',
  'IOS',
  'Fuchsia',
  'Web',
] as const

export type Platform = typeof Platforms[number]
