import 'package:batufo/models/player_model.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';

// This is mutable on purpose to allow emitting one of those
// per game loop without incurring too much garbage.
// The rpc/client packs it whenever sending a message anyways while
// 90% of emitted values are ignored due to throttling.
class ClientPlayerUpdate {
  final int clientID;
  PlayerModel _player;

  ClientPlayerUpdate(this.clientID);

  set player(PlayerModel value) {
    _player = value;
  }

  PackedClientPlayerUpdate pack() {
    final packedUpdate = PackedClientPlayerUpdate();
    packedUpdate.clientID = clientID;
    packedUpdate.player = _player?.pack();
    return packedUpdate;
  }

  factory ClientPlayerUpdate.unpack(PackedClientPlayerUpdate update) {
    return ClientPlayerUpdate(update.clientID)
      ..player = PlayerModel.unpack(update.player);
  }

  String toString() {
    return '''ClientPlayerUpdate {
  player: $_player
}''';
  }
}
