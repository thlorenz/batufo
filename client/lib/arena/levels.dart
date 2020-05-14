import 'package:batufo/arena/test/large.dart';
import 'package:batufo/arena/test/simple.dart';
import 'package:batufo/arena/tilemap.dart';

const Map<String, String> levels = {
  'simple': Levels.simple,
  'large': Levels.large,
};

class Levels {
  static const simple = simpleLevel;
  static const large = largeLevel;

  static Tilemap tilemapForLevel(String levelName) {
    assert(levels.containsKey(levelName), 'cannot find level $levelName');
    return Tilemap.build(levels[levelName]);
  }
}
