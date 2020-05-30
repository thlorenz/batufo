import 'package:batufo/game_props.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class StatsState extends Equatable {
  final double health;
  final int playersAlive;
  final int totalPlayers;

  const StatsState({
    @required this.health,
    @required this.totalPlayers,
    @required this.playersAlive,
  });

  String toString() {
    return 'Stats [ $health, $playersAlive/$totalPlayers ]';
  }

  static StatsState initial(int totalPlayers) {
    return StatsState(
      health: GameProps.playerTotalHealth,
      playersAlive: totalPlayers,
      totalPlayers: totalPlayers,
    );
  }

  @override
  List<Object> get props => [health, totalPlayers, playersAlive];
}
