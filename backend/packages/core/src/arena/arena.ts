import { Levels } from './levels'
import { TilePosition } from './tile-position'
import { Tile, Tilemap } from './tilemap'
import { PackedArena } from '../generated/message_bus_pb'
import { Pickup, PickupType } from './pickup'
import { UnreachableCaseError } from '../types'

export class Arena {
  constructor(
    readonly floorTiles: TilePosition[],
    readonly walls: TilePosition[],
    readonly players: TilePosition[],
    readonly pickups: Pickup[],
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
    const pickups: Pickup[] = []
    const initialPlayers: TilePosition[] = []

    for (let row = 0; row < nrows; row++) {
      for (let col = 0; col < ncols; col++) {
        const tile = tilemap.tiles[row * ncols + col]
        if (Tilemap.needsFloorTile(tile)) {
          floorTiles.push(new TilePosition(col, row, center, center))
        }
        switch (tile) {
          case Tile.Wall:
            walls.push(new TilePosition(col, row, center, center))
            break
          case Tile.Player:
            initialPlayers.push(new TilePosition(col, row, center, center))
            break
          case Tile.Medkit:
            pickups.push(
              new Pickup(
                PickupType.Medkit,
                new TilePosition(col, row, center, center)
              )
            )
            break
          case Tile.Shield:
            pickups.push(
              new Pickup(
                PickupType.Shield,
                new TilePosition(col, row, center, center)
              )
            )
            break
          case Tile.Bomb:
            pickups.push(
              new Pickup(
                PickupType.Bomb,
                new TilePosition(col, row, center, center)
              )
            )
            break
          case Tile.OutOfBounds:
          case Tile.Empty:
          case Tile.Hole:
            break
          default:
            throw new UnreachableCaseError(tile)
        }
      }
    }
    return new Arena(
      floorTiles,
      walls,
      initialPlayers,
      pickups,
      nrows,
      ncols,
      tileSize
    )
  }

  pack(): PackedArena {
    const packedFloorTiles = this.floorTiles.map((x) => x.pack())
    const packedWalls = this.walls.map((x) => x.pack())
    const packedPlayerPositions = this.players.map((x) => x.pack())
    const packedPickups = this.pickups.map((x) => x.pack())

    const packedArena = new PackedArena()
    packedArena.setNrows(this.nrows)
    packedArena.setNcols(this.ncols)
    packedArena.setTilesize(this.tileSize)

    packedArena.setFloortilesList(packedFloorTiles)
    packedArena.setWallsList(packedWalls)
    packedArena.setPlayerpositionsList(packedPlayerPositions)
    packedArena.setPickupsList(packedPickups)

    return packedArena
  }

  unpack(data: PackedArena): Arena {
    const floorTiles = data.getFloortilesList().map(TilePosition.unpack)
    const walls = data.getWallsList().map(TilePosition.unpack)
    const playerPositions = data
      .getPlayerpositionsList()
      .map(TilePosition.unpack)
    const pickups = data.getPickupsList().map(Pickup.unpack)

    return new Arena(
      floorTiles,
      walls,
      playerPositions,
      pickups,
      data.getNrows(),
      data.getNcols(),
      data.getTilesize()
    )
  }

  static forLevel(levelName: string, tileSize: number): Arena {
    const tilemap = Levels.tilemapForLevel(levelName)
    return Arena.fromTilemap(tilemap, tileSize)
  }

  static empty(): Arena {
    return new Arena([], [], [], [], 0, 0, 0)
  }

  static TILE_SIZE = 40

  toString(): string {
    return `
Arena: ${this.nrows}x${this.ncols}
  players: {this.players}
  walls: {this.walls}
  pickups: {this.pickups}
`
  }
}
