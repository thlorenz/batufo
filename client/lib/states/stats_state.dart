import 'package:batufo/game_props.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class StatsState extends Equatable {
  final double health;
  final int playersAlive;
  final int totalPlayers;
  final int percentReadyToShoot;
  final int percentReadyToThrust;

  const StatsState({
    @required this.health,
    @required this.totalPlayers,
    @required this.playersAlive,
    @required this.percentReadyToShoot,
    @required this.percentReadyToThrust,
  });

  String toString() {
    return 'Stats [ $health, $playersAlive/$totalPlayers ]';
  }

  static StatsState initial(int totalPlayers) {
    return StatsState(
      health: GameProps.playerTotalHealth,
      playersAlive: totalPlayers,
      totalPlayers: totalPlayers,
      percentReadyToShoot: 100,
      percentReadyToThrust: 100,
    );
  }

  @override
  List<Object> get props => [
        health,
        totalPlayers,
        playersAlive,
        percentReadyToShoot,
        percentReadyToThrust,
      ];
}
