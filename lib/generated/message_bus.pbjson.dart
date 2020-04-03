///
//  Generated code. Do not modify.
//  source: message_bus.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Empty$json = const {
  '1': 'Empty',
};

const PlayRequest$json = const {
  '1': 'PlayRequest',
  '2': const [
    const {'1': 'levelName', '3': 1, '4': 1, '5': 9, '10': 'levelName'},
  ],
};

const GameStateEvent$json = const {
  '1': 'GameStateEvent',
  '2': const [
    const {'1': 'gameState', '3': 1, '4': 1, '5': 11, '6': '.PackedGameState', '10': 'gameState'},
  ],
};

const PackedGameState$json = const {
  '1': 'PackedGameState',
  '2': const [
    const {'1': 'players', '3': 1, '4': 3, '5': 11, '6': '.PackedPlayerModel', '10': 'players'},
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
    const {'1': 'players', '3': 3, '4': 3, '5': 11, '6': '.PackedInitialPlayer', '10': 'players'},
    const {'1': 'nrows', '3': 4, '4': 1, '5': 13, '10': 'nrows'},
    const {'1': 'ncols', '3': 5, '4': 1, '5': 13, '10': 'ncols'},
  ],
};

const PackedInitialPlayer$json = const {
  '1': 'PackedInitialPlayer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'tilePosition', '3': 2, '4': 1, '5': 11, '6': '.PackedTilePosition', '10': 'tilePosition'},
  ],
};

const PlayingClientEvent$json = const {
  '1': 'PlayingClientEvent',
  '2': const [
    const {'1': 'client', '3': 1, '4': 1, '5': 11, '6': '.PlayingClient', '10': 'client'},
    const {'1': 'playerInputs', '3': 2, '4': 1, '5': 11, '6': '.PlayerInputs', '10': 'playerInputs'},
  ],
};

const PlayerInputs$json = const {
  '1': 'PlayerInputs',
  '2': const [
    const {'1': 'pressedKeys', '3': 1, '4': 1, '5': 13, '10': 'pressedKeys'},
  ],
};

const PackedPlayerModel$json = const {
  '1': 'PackedPlayerModel',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'tilePosition', '3': 2, '4': 1, '5': 11, '6': '.PackedTilePosition', '10': 'tilePosition'},
    const {'1': 'velocity', '3': 3, '4': 1, '5': 11, '6': '.PackedFractionalPoint', '10': 'velocity'},
    const {'1': 'angle', '3': 4, '4': 1, '5': 11, '6': '.DoubleFourDecimals', '10': 'angle'},
    const {'1': 'flags', '3': 5, '4': 1, '5': 13, '10': 'flags'},
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

