import 'package:equatable/equatable.dart';

enum ConnectionStates { Initializing, Connected, Disconnected }

class ConnectionState extends Equatable {
  final ConnectionStates kind;
  final String reason;
  const ConnectionState(this.kind, {this.reason});

  @override
  List<Object> get props => [kind, reason];
}
