export class UnreachableCaseError extends Error {
  constructor(val: never | undefined) {
    super(`Unreachable case inside switch statement: ${val}`)
  }
}

