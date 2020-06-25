import 'package:batufo/controllers/helpers/player_status.dart';
import 'package:batufo/diagnostics/logger.dart';
import 'package:batufo/models/bomb_model.dart';
import 'package:batufo/models/bullet_model.dart';
import 'package:batufo/models/pickups_model.dart';
import 'package:batufo/models/player_model.dart';
import 'package:batufo/models/radar_model.dart';
import 'package:flutter/foundation.dart';

final _log = Log<ClientGameState>();

class ClientGameState {
  final int clientID;
  final int totalPlayers;
  final Map<int, PlayerModel> players;
  final List<BulletModel> bullets;
  final List<BombModel> bombs;
  final PickupsModel pickups;
  final RadarModel radar;

  bool synced = false;

  ClientGameState({
    @required this.totalPlayers,
    @required this.clientID,
    @required this.players,
    @required this.pickups,
    @required this.bullets,
    @required this.bombs,
    @required this.radar,
  });

  PlayerModel get hero => players[clientID];
  int get remainingPlayers => players.length;
  int get playersAlive => players.values.where(PlayerStatus.isAlive).length;
  bool hasPlayer(int clientID) => players.containsKey(clientID);

  void updatePlayer(PlayerModel player) {
    assert(player != null, 'cannot add null as player');
    players[player.id] = player;
    _log.finest('updated player now have ${players.length} players');
  }

  void removePlayer(int clientID) {
    players.remove(clientID);
  }

  void addBullet(BulletModel bullet) {
    bullets.add(bullet);
  }

  void addBomb(BombModel bomb) {
    bombs.add(bomb);
  }

  void clearBullets() {
    bullets.clear();
  }

  String toString() {
    return '''ClientGameState {
    player: $players
    bullets: $bullets
    pickups: $pickups
    bombs: $bombs
    }''';
  }
}
