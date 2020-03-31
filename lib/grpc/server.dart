import 'package:batufo/grpc/game_updates_service.dart';
import 'package:grpc/grpc.dart';

const PORT = 8080;

class GameUpdatesServer {
  Future<void> init(List<String> args) async {
    final server = Server([GameUpdatesService()]);
    await server.serve(port: PORT);
    print('server listening on port ${server.port}');
  }
}

Future<void> main(List<String> args) {
  return GameUpdatesServer().init(args);
}
