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

export class PlayRequest extends jspb.Message {
  getLevelname(): string;
  setLevelname(value: string): void;

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
  }
}

export class GameStateEvent extends jspb.Message {
  hasGamestate(): boolean;
  clearGamestate(): void;
  getGamestate(): PackedServerUpdate | undefined;
  setGamestate(value?: PackedServerUpdate): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): GameStateEvent.AsObject;
  static toObject(includeInstance: boolean, msg: GameStateEvent): GameStateEvent.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: GameStateEvent, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): GameStateEvent;
  static deserializeBinaryFromReader(message: GameStateEvent, reader: jspb.BinaryReader): GameStateEvent;
}

export namespace GameStateEvent {
  export type AsObject = {
    gamestate?: PackedServerUpdate.AsObject,
  }
}

export class PackedServerUpdate extends jspb.Message {
  clearPlayersList(): void;
  getPlayersList(): Array<PackedPlayerModel>;
  setPlayersList(value: Array<PackedPlayerModel>): void;
  addPlayers(value?: PackedPlayerModel, index?: number): PackedPlayerModel;

  clearSpawnedbulletsList(): void;
  getSpawnedbulletsList(): Array<PackedBulletModel>;
  setSpawnedbulletsList(value: Array<PackedBulletModel>): void;
  addSpawnedbullets(value?: PackedBulletModel, index?: number): PackedBulletModel;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PackedServerUpdate.AsObject;
  static toObject(includeInstance: boolean, msg: PackedServerUpdate): PackedServerUpdate.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PackedServerUpdate, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PackedServerUpdate;
  static deserializeBinaryFromReader(message: PackedServerUpdate, reader: jspb.BinaryReader): PackedServerUpdate;
}

export namespace PackedServerUpdate {
  export type AsObject = {
    playersList: Array<PackedPlayerModel.AsObject>,
    spawnedbulletsList: Array<PackedBulletModel.AsObject>,
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
  }
}

export class PlayingClientEvent extends jspb.Message {
  hasClient(): boolean;
  clearClient(): void;
  getClient(): GameCreated | undefined;
  setClient(value?: GameCreated): void;

  hasSpawnedbullet(): boolean;
  clearSpawnedbullet(): void;
  getSpawnedbullet(): PackedBulletModel | undefined;
  setSpawnedbullet(value?: PackedBulletModel): void;

  hasPlayer(): boolean;
  clearPlayer(): void;
  getPlayer(): PackedPlayerModel | undefined;
  setPlayer(value?: PackedPlayerModel): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): PlayingClientEvent.AsObject;
  static toObject(includeInstance: boolean, msg: PlayingClientEvent): PlayingClientEvent.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: PlayingClientEvent, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): PlayingClientEvent;
  static deserializeBinaryFromReader(message: PlayingClientEvent, reader: jspb.BinaryReader): PlayingClientEvent;
}

export namespace PlayingClientEvent {
  export type AsObject = {
    client?: GameCreated.AsObject,
    spawnedbullet?: PackedBulletModel.AsObject,
    player?: PackedPlayerModel.AsObject,
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
  }
}

export class PackedBulletModel extends jspb.Message {
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
    tileposition?: PackedTilePosition.AsObject,
    velocity?: PackedFractionalPoint.AsObject,
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

