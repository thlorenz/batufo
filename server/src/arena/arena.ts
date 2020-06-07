import { PackedArena } from '../generated/message_bus_pb'
import { Levels } from './levels'
import { TilePosition } from './tile-position'
import { Tile, Tilemap } from './tilemap'

export class Arena {
  constructor(
    readonly floorTiles: TilePosition[],
    readonly walls: TilePosition[],
    readonly players: TilePosition[],
    readonly nrows: number,
    readonly ncols: number,
    readonly tileSize: number
  ) {}

  isFull(registeredPlayers: number) {
    return this.players.length == registeredPlayers
  }

  static fromTilemap(tilemap: Tilemap, tileSize: number) {
    const nrows = tilemap.nrows
    const ncols = tilemap.ncols
    const center = tileSize / 2
    const floorTiles: TilePosition[] = []
    const walls: TilePosition[] = []
    const initialPlayers: TilePosition[] = []

    for (let row = 0; row < nrows; row++) {
      for (let col = 0; col < ncols; col++) {
        const tile = tilemap.tiles[row * ncols + col]
        if (Tilemap.needsFloorTile(tile)) {
          floorTiles.push(new TilePosition(col, row, center, center))
        }
        if (tile === Tile.Wall || tile === Tile.Boundary) {
          walls.push(new TilePosition(col, row, center, center))
        }
        if (tile === Tile.Player) {
          initialPlayers.push(new TilePosition(col, row, center, center))
        }
      }
    }
    return new Arena(floorTiles, walls, initialPlayers, nrows, ncols, tileSize)
  }

  pack(): PackedArena {
    const packedFloorTiles = this.floorTiles.map((x) => x.pack())
    const packedWalls = this.walls.map((x) => x.pack())
    const packedPlayerPositions = this.players.map((x) => x.pack())

    const packedArena = new PackedArena()
    packedArena.setNrows(this.nrows)
    packedArena.setNcols(this.ncols)
    packedArena.setTilesize(this.tileSize)

    packedArena.setFloortilesList(packedFloorTiles)
    packedArena.setWallsList(packedWalls)
    packedArena.setPlayerpositionsList(packedPlayerPositions)

    return packedArena
  }

  unpack(data: PackedArena): Arena {
    const floorTiles = data
      .getFloortilesList()
      .map((x) => TilePosition.unpack(x))
    const walls = data.getWallsList().map((x) => TilePosition.unpack(x))
    const playerPositions = data
      .getPlayerpositionsList()
      .map((x) => TilePosition.unpack(x))

    return new Arena(
      floorTiles,
      walls,
      playerPositions,
      data.getNrows(),
      data.getNcols(),
      data.getTilesize()
    )
  }

  static forLevel(levelName: string, tileSize: number): Arena {
    const tilemap = Levels.tilemapForLevel(levelName)
    return Arena.fromTilemap(tilemap, tileSize)
  }

  static TILE_SIZE = 40

  toString(): string {
    return `
Arena: ${this.nrows}x${this.ncols}
  players: {this.players}
  walls: {this.walls}
`
  }
}
