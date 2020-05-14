///
//  Generated code. Do not modify.
//  source: message_bus.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const PlayRequest$json = const {
  '1': 'PlayRequest',
  '2': const [
    const {'1': 'levelName', '3': 1, '4': 1, '5': 9, '10': 'levelName'},
  ],
};

const GameStateEvent$json = const {
  '1': 'GameStateEvent',
  '2': const [
    const {'1': 'gameState', '3': 1, '4': 1, '5': 11, '6': '.PackedServerUpdate', '10': 'gameState'},
  ],
};

const PackedServerUpdate$json = const {
  '1': 'PackedServerUpdate',
  '2': const [
    const {'1': 'players', '3': 1, '4': 3, '5': 11, '6': '.PackedPlayerModel', '10': 'players'},
    const {'1': 'spawnedBullets', '3': 2, '4': 3, '5': 11, '6': '.PackedBulletModel', '10': 'spawnedBullets'},
  ],
};

const PlayingClient$json = const {
  '1': 'PlayingClient',
  '2': const [
    const {'1': 'gameID', '3': 1, '4': 1, '5': 13, '10': 'gameID'},
    const {'1': 'clientID', '3': 2, '4': 1, '5': 13, '10': 'clientID'},
    const {'1': 'arena', '3': 3, '4': 1, '5': 11, '6': '.PackedArena', '10': 'arena'},
  ],
};

const PackedArena$json = const {
  '1': 'PackedArena',
  '2': const [
    const {'1': 'floorTiles', '3': 1, '4': 3, '5': 11, '6': '.PackedTilePosition', '10': 'floorTiles'},
    const {'1': 'walls', '3': 2, '4': 3, '5': 11, '6': '.PackedTilePosition', '10': 'walls'},
    const {'1': 'playerPositions', '3': 3, '4': 3, '5': 11, '6': '.PackedTilePosition', '10': 'playerPositions'},
    const {'1': 'nrows', '3': 4, '4': 1, '5': 13, '10': 'nrows'},
    const {'1': 'ncols', '3': 5, '4': 1, '5': 13, '10': 'ncols'},
  ],
};

const PlayingClientEvent$json = const {
  '1': 'PlayingClientEvent',
  '2': const [
    const {'1': 'client', '3': 1, '4': 1, '5': 11, '6': '.PlayingClient', '10': 'client'},
    const {'1': 'spawnedBullet', '3': 2, '4': 1, '5': 11, '6': '.PackedBulletModel', '10': 'spawnedBullet'},
    const {'1': 'player', '3': 3, '4': 1, '5': 11, '6': '.PackedPlayerModel', '10': 'player'},
  ],
};

const PackedPlayerModel$json = const {
  '1': 'PackedPlayerModel',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'tilePosition', '3': 2, '4': 1, '5': 11, '6': '.PackedTilePosition', '10': 'tilePosition'},
    const {'1': 'velocity', '3': 3, '4': 1, '5': 11, '6': '.PackedFractionalPoint', '10': 'velocity'},
    const {'1': 'angle', '3': 4, '4': 1, '5': 11, '6': '.DoubleFourDecimals', '10': 'angle'},
    const {'1': 'health', '3': 5, '4': 1, '5': 11, '6': '.DoubleTwoDecimals', '10': 'health'},
  ],
};

const PackedBulletModel$json = const {
  '1': 'PackedBulletModel',
  '2': const [
    const {'1': 'tilePosition', '3': 1, '4': 1, '5': 11, '6': '.PackedTilePosition', '10': 'tilePosition'},
    const {'1': 'velocity', '3': 2, '4': 1, '5': 11, '6': '.PackedFractionalPoint', '10': 'velocity'},
  ],
};

const PackedTilePosition$json = const {
  '1': 'PackedTilePosition',
  '2': const [
    const {'1': 'colRow', '3': 1, '4': 1, '5': 11, '6': '.PackedPoint', '10': 'colRow'},
    const {'1': 'relXY', '3': 2, '4': 1, '5': 11, '6': '.PackedFractionalPoint', '10': 'relXY'},
  ],
};

const PackedFractionalPoint$json = const {
  '1': 'PackedFractionalPoint',
  '2': const [
    const {'1': 'xy', '3': 1, '4': 1, '5': 13, '10': 'xy'},
  ],
};

const PackedPoint$json = const {
  '1': 'PackedPoint',
  '2': const [
    const {'1': 'xy', '3': 1, '4': 1, '5': 13, '10': 'xy'},
  ],
};

const DoubleTwoDecimals$json = const {
  '1': 'DoubleTwoDecimals',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
  ],
};

const DoubleFourDecimals$json = const {
  '1': 'DoubleFourDecimals',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
  ],
};

