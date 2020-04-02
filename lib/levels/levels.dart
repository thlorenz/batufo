import 'package:batufo/levels/test/simple.dart';
import 'package:batufo/levels/tilemap.dart';

const Map<String, String> levels = {'simple': Levels.simple};

class Levels {
  static const simple = simpleLevel;

  static Tilemap tilemapForLevel(String levelName) {
    assert(levels.containsKey(levelName), 'cannot find level $levelName');
    return Tilemap.build(levels[levelName]);
  }
}
