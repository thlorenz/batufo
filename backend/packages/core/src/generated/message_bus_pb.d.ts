// package: 
// file: message_bus.proto

import * as jspb from "google-protobuf";

export class InfoRequest extends jspb.Message {
  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): InfoRequest.AsObject;
  static toObject(includeInstance: boolean, msg: InfoRequest): InfoRequest.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: InfoRequest, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): InfoRequest;
  static deserializeBinaryFromReader(message: InfoRequest, reader: jspb.BinaryReader): InfoRequest;
}

export namespace InfoRequest {
  export type AsObject = {
  }
}

export class PlayRequest extends jspb.Message {
  getLevelname(): string;
  setLevelname(value: string): void;

  getPlatform(): PlatformMap[keyof PlatformMap];
  setPlatform(value: PlatformMap[keyof PlatformMap]): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PlayRequest.AsObject;
  static toObject(includeInstance: boolean, msg: PlayRequest): PlayRequest.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PlayRequest, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PlayRequest;
  static deserializeBinaryFromReader(message: PlayRequest, reader: jspb.BinaryReader): PlayRequest;
}

export namespace PlayRequest {
  export type AsObject = {
    levelname: string,
    platform: PlatformMap[keyof PlatformMap],
  }
}

export class InfoResponse extends jspb.Message {
  clearLevelsList(): void;
  getLevelsList(): Array<LevelInfo>;
  setLevelsList(value: Array<LevelInfo>): void;
  addLevels(value?: LevelInfo, index?: number): LevelInfo;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): InfoResponse.AsObject;
  static toObject(includeInstance: boolean, msg: InfoResponse): InfoResponse.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: InfoResponse, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): InfoResponse;
  static deserializeBinaryFromReader(message: InfoResponse, reader: jspb.BinaryReader): InfoResponse;
}

export namespace InfoResponse {
  export type AsObject = {
    levelsList: Array<LevelInfo.AsObject>,
  }
}

export class ServerStatsUpdate extends jspb.Message {
  getTotalgames(): number;
  setTotalgames(value: number): void;

  getTotalplayers(): number;
  setTotalplayers(value: number): void;

  getRunninglevelscountsMap(): jspb.Map<string, number>;
  clearRunninglevelscountsMap(): void;
  getWaitingforlevelscountsMap(): jspb.Map<string, number>;
  clearWaitingforlevelscountsMap(): void;
  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): ServerStatsUpdate.AsObject;
  static toObject(includeInstance: boolean, msg: ServerStatsUpdate): ServerStatsUpdate.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: ServerStatsUpdate, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): ServerStatsUpdate;
  static deserializeBinaryFromReader(message: ServerStatsUpdate, reader: jspb.BinaryReader): ServerStatsUpdate;
}

export namespace ServerStatsUpdate {
  export type AsObject = {
    totalgames: number,
    totalplayers: number,
    runninglevelscountsMap: Array<[string, number]>,
    waitingforlevelscountsMap: Array<[string, number]>,
  }
}

export class PlayerDeparted extends jspb.Message {
  getClientid(): number;
  setClientid(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PlayerDeparted.AsObject;
  static toObject(includeInstance: boolean, msg: PlayerDeparted): PlayerDeparted.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PlayerDeparted, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PlayerDeparted;
  static deserializeBinaryFromReader(message: PlayerDeparted, reader: jspb.BinaryReader): PlayerDeparted;
}

export namespace PlayerDeparted {
  export type AsObject = {
    clientid: number,
  }
}

export class PlayerJoined extends jspb.Message {
  getClientid(): number;
  setClientid(value: number): void;

  getPlayerindex(): number;
  setPlayerindex(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PlayerJoined.AsObject;
  static toObject(includeInstance: boolean, msg: PlayerJoined): PlayerJoined.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PlayerJoined, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PlayerJoined;
  static deserializeBinaryFromReader(message: PlayerJoined, reader: jspb.BinaryReader): PlayerJoined;
}

export namespace PlayerJoined {
  export type AsObject = {
    clientid: number,
    playerindex: number,
  }
}

export class LevelInfo extends jspb.Message {
  getName(): string;
  setName(value: string): void;

  getNplayers(): number;
  setNplayers(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): LevelInfo.AsObject;
  static toObject(includeInstance: boolean, msg: LevelInfo): LevelInfo.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: LevelInfo, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): LevelInfo;
  static deserializeBinaryFromReader(message: LevelInfo, reader: jspb.BinaryReader): LevelInfo;
}

export namespace LevelInfo {
  export type AsObject = {
    name: string,
    nplayers: number,
  }
}

export class PackedClientPlayerUpdate extends jspb.Message {
  hasPlayer(): boolean;
  clearPlayer(): void;
  getPlayer(): PackedPlayerModel | undefined;
  setPlayer(value?: PackedPlayerModel): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedClientPlayerUpdate.AsObject;
  static toObject(includeInstance: boolean, msg: PackedClientPlayerUpdate): PackedClientPlayerUpdate.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedClientPlayerUpdate, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedClientPlayerUpdate;
  static deserializeBinaryFromReader(message: PackedClientPlayerUpdate, reader: jspb.BinaryReader): PackedClientPlayerUpdate;
}

export namespace PackedClientPlayerUpdate {
  export type AsObject = {
    player?: PackedPlayerModel.AsObject,
  }
}

export class PackedClientSpawnedBulletUpdate extends jspb.Message {
  hasSpawnedbullet(): boolean;
  clearSpawnedbullet(): void;
  getSpawnedbullet(): PackedBulletModel | undefined;
  setSpawnedbullet(value?: PackedBulletModel): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedClientSpawnedBulletUpdate.AsObject;
  static toObject(includeInstance: boolean, msg: PackedClientSpawnedBulletUpdate): PackedClientSpawnedBulletUpdate.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedClientSpawnedBulletUpdate, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedClientSpawnedBulletUpdate;
  static deserializeBinaryFromReader(message: PackedClientSpawnedBulletUpdate, reader: jspb.BinaryReader): PackedClientSpawnedBulletUpdate;
}

export namespace PackedClientSpawnedBulletUpdate {
  export type AsObject = {
    spawnedbullet?: PackedBulletModel.AsObject,
  }
}

export class PackedClientSpawnedBombUpdate extends jspb.Message {
  hasSpawnposition(): boolean;
  clearSpawnposition(): void;
  getSpawnposition(): PackedTilePosition | undefined;
  setSpawnposition(value?: PackedTilePosition): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedClientSpawnedBombUpdate.AsObject;
  static toObject(includeInstance: boolean, msg: PackedClientSpawnedBombUpdate): PackedClientSpawnedBombUpdate.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedClientSpawnedBombUpdate, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedClientSpawnedBombUpdate;
  static deserializeBinaryFromReader(message: PackedClientSpawnedBombUpdate, reader: jspb.BinaryReader): PackedClientSpawnedBombUpdate;
}

export namespace PackedClientSpawnedBombUpdate {
  export type AsObject = {
    spawnposition?: PackedTilePosition.AsObject,
  }
}

export class GameCreated extends jspb.Message {
  getGameid(): number;
  setGameid(value: number): void;

  getClientid(): number;
  setClientid(value: number): void;

  getPlayerindex(): number;
  setPlayerindex(value: number): void;

  hasArena(): boolean;
  clearArena(): void;
  getArena(): PackedArena | undefined;
  setArena(value?: PackedArena): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): GameCreated.AsObject;
  static toObject(includeInstance: boolean, msg: GameCreated): GameCreated.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: GameCreated, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): GameCreated;
  static deserializeBinaryFromReader(message: GameCreated, reader: jspb.BinaryReader): GameCreated;
}

export namespace GameCreated {
  export type AsObject = {
    gameid: number,
    clientid: number,
    playerindex: number,
    arena?: PackedArena.AsObject,
  }
}

export class PackedPickup extends jspb.Message {
  getType(): PackedPickupTypeMap[keyof PackedPickupTypeMap];
  setType(value: PackedPickupTypeMap[keyof PackedPickupTypeMap]): void;

  hasTileposition(): boolean;
  clearTileposition(): void;
  getTileposition(): PackedTilePosition | undefined;
  setTileposition(value?: PackedTilePosition): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedPickup.AsObject;
  static toObject(includeInstance: boolean, msg: PackedPickup): PackedPickup.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedPickup, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedPickup;
  static deserializeBinaryFromReader(message: PackedPickup, reader: jspb.BinaryReader): PackedPickup;
}

export namespace PackedPickup {
  export type AsObject = {
    type: PackedPickupTypeMap[keyof PackedPickupTypeMap],
    tileposition?: PackedTilePosition.AsObject,
  }
}

export class PackedClientPickedUpUpdate extends jspb.Message {
  hasColrow(): boolean;
  clearColrow(): void;
  getColrow(): PackedPoint | undefined;
  setColrow(value?: PackedPoint): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedClientPickedUpUpdate.AsObject;
  static toObject(includeInstance: boolean, msg: PackedClientPickedUpUpdate): PackedClientPickedUpUpdate.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedClientPickedUpUpdate, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedClientPickedUpUpdate;
  static deserializeBinaryFromReader(message: PackedClientPickedUpUpdate, reader: jspb.BinaryReader): PackedClientPickedUpUpdate;
}

export namespace PackedClientPickedUpUpdate {
  export type AsObject = {
    colrow?: PackedPoint.AsObject,
  }
}

export class PackedArena extends jspb.Message {
  clearFloortilesList(): void;
  getFloortilesList(): Array<PackedTilePosition>;
  setFloortilesList(value: Array<PackedTilePosition>): void;
  addFloortiles(value?: PackedTilePosition, index?: number): PackedTilePosition;

  clearWallsList(): void;
  getWallsList(): Array<PackedTilePosition>;
  setWallsList(value: Array<PackedTilePosition>): void;
  addWalls(value?: PackedTilePosition, index?: number): PackedTilePosition;

  clearPlayerpositionsList(): void;
  getPlayerpositionsList(): Array<PackedTilePosition>;
  setPlayerpositionsList(value: Array<PackedTilePosition>): void;
  addPlayerpositions(value?: PackedTilePosition, index?: number): PackedTilePosition;

  getNrows(): number;
  setNrows(value: number): void;

  getNcols(): number;
  setNcols(value: number): void;

  getTilesize(): number;
  setTilesize(value: number): void;

  clearPickupsList(): void;
  getPickupsList(): Array<PackedPickup>;
  setPickupsList(value: Array<PackedPickup>): void;
  addPickups(value?: PackedPickup, index?: number): PackedPickup;

  clearTeleportsList(): void;
  getTeleportsList(): Array<PackedTeleport>;
  setTeleportsList(value: Array<PackedTeleport>): void;
  addTeleports(value?: PackedTeleport, index?: number): PackedTeleport;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedArena.AsObject;
  static toObject(includeInstance: boolean, msg: PackedArena): PackedArena.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedArena, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedArena;
  static deserializeBinaryFromReader(message: PackedArena, reader: jspb.BinaryReader): PackedArena;
}

export namespace PackedArena {
  export type AsObject = {
    floortilesList: Array<PackedTilePosition.AsObject>,
    wallsList: Array<PackedTilePosition.AsObject>,
    playerpositionsList: Array<PackedTilePosition.AsObject>,
    nrows: number,
    ncols: number,
    tilesize: number,
    pickupsList: Array<PackedPickup.AsObject>,
    teleportsList: Array<PackedTeleport.AsObject>,
  }
}

export class PackedPlayerModel extends jspb.Message {
  getId(): number;
  setId(value: number): void;

  hasTileposition(): boolean;
  clearTileposition(): void;
  getTileposition(): PackedTilePosition | undefined;
  setTileposition(value?: PackedTilePosition): void;

  hasVelocity(): boolean;
  clearVelocity(): void;
  getVelocity(): PackedFractionalPoint | undefined;
  setVelocity(value?: PackedFractionalPoint): void;

  hasAngle(): boolean;
  clearAngle(): void;
  getAngle(): DoubleFourDecimals | undefined;
  setAngle(value?: DoubleFourDecimals): void;

  hasHealth(): boolean;
  clearHealth(): void;
  getHealth(): DoubleTwoDecimals | undefined;
  setHealth(value?: DoubleTwoDecimals): void;

  getShieldremainingms(): number;
  setShieldremainingms(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedPlayerModel.AsObject;
  static toObject(includeInstance: boolean, msg: PackedPlayerModel): PackedPlayerModel.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedPlayerModel, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedPlayerModel;
  static deserializeBinaryFromReader(message: PackedPlayerModel, reader: jspb.BinaryReader): PackedPlayerModel;
}

export namespace PackedPlayerModel {
  export type AsObject = {
    id: number,
    tileposition?: PackedTilePosition.AsObject,
    velocity?: PackedFractionalPoint.AsObject,
    angle?: DoubleFourDecimals.AsObject,
    health?: DoubleTwoDecimals.AsObject,
    shieldremainingms: number,
  }
}

export class PackedBulletModel extends jspb.Message {
  getClientid(): number;
  setClientid(value: number): void;

  hasTileposition(): boolean;
  clearTileposition(): void;
  getTileposition(): PackedTilePosition | undefined;
  setTileposition(value?: PackedTilePosition): void;

  hasVelocity(): boolean;
  clearVelocity(): void;
  getVelocity(): PackedFractionalPoint | undefined;
  setVelocity(value?: PackedFractionalPoint): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedBulletModel.AsObject;
  static toObject(includeInstance: boolean, msg: PackedBulletModel): PackedBulletModel.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedBulletModel, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedBulletModel;
  static deserializeBinaryFromReader(message: PackedBulletModel, reader: jspb.BinaryReader): PackedBulletModel;
}

export namespace PackedBulletModel {
  export type AsObject = {
    clientid: number,
    tileposition?: PackedTilePosition.AsObject,
    velocity?: PackedFractionalPoint.AsObject,
  }
}

export class PackedBombModel extends jspb.Message {
  hasTileposition(): boolean;
  clearTileposition(): void;
  getTileposition(): PackedTilePosition | undefined;
  setTileposition(value?: PackedTilePosition): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedBombModel.AsObject;
  static toObject(includeInstance: boolean, msg: PackedBombModel): PackedBombModel.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedBombModel, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedBombModel;
  static deserializeBinaryFromReader(message: PackedBombModel, reader: jspb.BinaryReader): PackedBombModel;
}

export namespace PackedBombModel {
  export type AsObject = {
    tileposition?: PackedTilePosition.AsObject,
  }
}

export class PackedTeleport extends jspb.Message {
  hasPorta(): boolean;
  clearPorta(): void;
  getPorta(): PackedPoint | undefined;
  setPorta(value?: PackedPoint): void;

  hasPortb(): boolean;
  clearPortb(): void;
  getPortb(): PackedPoint | undefined;
  setPortb(value?: PackedPoint): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedTeleport.AsObject;
  static toObject(includeInstance: boolean, msg: PackedTeleport): PackedTeleport.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedTeleport, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedTeleport;
  static deserializeBinaryFromReader(message: PackedTeleport, reader: jspb.BinaryReader): PackedTeleport;
}

export namespace PackedTeleport {
  export type AsObject = {
    porta?: PackedPoint.AsObject,
    portb?: PackedPoint.AsObject,
  }
}

export class PackedTilePosition extends jspb.Message {
  hasColrow(): boolean;
  clearColrow(): void;
  getColrow(): PackedPoint | undefined;
  setColrow(value?: PackedPoint): void;

  hasRelxy(): boolean;
  clearRelxy(): void;
  getRelxy(): PackedFractionalPoint | undefined;
  setRelxy(value?: PackedFractionalPoint): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedTilePosition.AsObject;
  static toObject(includeInstance: boolean, msg: PackedTilePosition): PackedTilePosition.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedTilePosition, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedTilePosition;
  static deserializeBinaryFromReader(message: PackedTilePosition, reader: jspb.BinaryReader): PackedTilePosition;
}

export namespace PackedTilePosition {
  export type AsObject = {
    colrow?: PackedPoint.AsObject,
    relxy?: PackedFractionalPoint.AsObject,
  }
}

export class PackedFractionalPoint extends jspb.Message {
  getXy(): number;
  setXy(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedFractionalPoint.AsObject;
  static toObject(includeInstance: boolean, msg: PackedFractionalPoint): PackedFractionalPoint.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedFractionalPoint, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedFractionalPoint;
  static deserializeBinaryFromReader(message: PackedFractionalPoint, reader: jspb.BinaryReader): PackedFractionalPoint;
}

export namespace PackedFractionalPoint {
  export type AsObject = {
    xy: number,
  }
}

export class PackedPoint extends jspb.Message {
  getXy(): number;
  setXy(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedPoint.AsObject;
  static toObject(includeInstance: boolean, msg: PackedPoint): PackedPoint.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedPoint, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedPoint;
  static deserializeBinaryFromReader(message: PackedPoint, reader: jspb.BinaryReader): PackedPoint;
}

export namespace PackedPoint {
  export type AsObject = {
    xy: number,
  }
}

export class DoubleTwoDecimals extends jspb.Message {
  getValue(): number;
  setValue(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): DoubleTwoDecimals.AsObject;
  static toObject(includeInstance: boolean, msg: DoubleTwoDecimals): DoubleTwoDecimals.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: DoubleTwoDecimals, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): DoubleTwoDecimals;
  static deserializeBinaryFromReader(message: DoubleTwoDecimals, reader: jspb.BinaryReader): DoubleTwoDecimals;
}

export namespace DoubleTwoDecimals {
  export type AsObject = {
    value: number,
  }
}

export class DoubleFourDecimals extends jspb.Message {
  getValue(): number;
  setValue(value: number): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): DoubleFourDecimals.AsObject;
  static toObject(includeInstance: boolean, msg: DoubleFourDecimals): DoubleFourDecimals.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: DoubleFourDecimals, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): DoubleFourDecimals;
  static deserializeBinaryFromReader(message: DoubleFourDecimals, reader: jspb.BinaryReader): DoubleFourDecimals;
}

export namespace DoubleFourDecimals {
  export type AsObject = {
    value: number,
  }
}

export interface PlatformMap {
  MACOS: 0;
  ANDROID: 1;
  LINUX: 2;
  WINDOWS: 3;
  IOS: 4;
  FUCHSIA: 5;
  WEB: 6;
}

export const Platform: PlatformMap;

export interface PackedPickupTypeMap {
  MEDKIT: 0;
  SHIELD: 1;
  BOMB: 2;
}

export const PackedPickupType: PackedPickupTypeMap;

