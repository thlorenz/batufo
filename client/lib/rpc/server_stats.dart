import 'package:batufo/rpc/generated/message_bus.pb.dart';
import 'package:equatable/equatable.dart';

class ServerStats extends Equatable {
  final int totalGames;
  final int totalPlayers;
  final Map<String, int> runningLevelsCounts;
  final Map<String, int> waitingForLevesCounts;

  const ServerStats._(
    this.totalGames,
    this.totalPlayers,
    this.runningLevelsCounts,
    this.waitingForLevesCounts,
  );

  factory ServerStats.fromServerStatsUpdate(ServerStatsUpdate update) {
    return ServerStats._(
      update.totalGames,
      update.totalPlayers,
      update.runningLevelsCounts,
      update.waitingForLevelsCounts,
    );
  }

  factory ServerStats.empty() {
    return ServerStats._(0, 0, {}, {});
  }

  @override
  String toString() {
    return 'ServerStats [ $totalGames, $totalPlayers ]';
  }

  List<Object> get props => [
        totalGames,
        totalPlayers,
        runningLevelsCounts.length,
        waitingForLevesCounts.length
      ];
}
