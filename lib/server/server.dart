import 'package:batufo/server/game_service.dart';
import 'package:batufo/shared/diagnostics/logger.dart';
import 'package:grpc/grpc.dart';

const PORT = 8080;

final _log = Log<GameUpdatesServer>();

class GameUpdatesServer {
  Future<void> init(List<String> args) async {
    Log.activateConsole();
    Log.rootLevel = Level.FINEST;

    final server = Server([GameService()]);
    await server.serve(port: PORT);
    _log.info('server listening on port ${server.port}');
  }
}

Future<void> main(List<String> args) {
  return GameUpdatesServer().init(args);
}
