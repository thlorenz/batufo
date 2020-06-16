declare module '6bit-encoder' {
  const SEPARATOR: string
  function encode(val: number): string
  function decode(val: string): number
}
