import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' show Image, decodeImageFromList;

import 'package:flutter/services.dart';

class Images {
  final Map<String, Image> loaded = <String, Image>{};

  Future<void> load(List<String> paths) {
    final loaders = paths.map(_load);
    return Future.wait(loaders);
  }

  Image getImage(String path) {
    assert(
      loaded.containsKey(path),
      'Must load all images at game start [$path] was not.',
    );
    return loaded[path];
  }

  Future<void> _load(String path) async {
    final image = await _fetchFromMemory(path);
    loaded[path] = image;
  }

  Future<Image> _fetchFromMemory(String path) async {
    final data = await rootBundle.load(path);
    final bytes = Uint8List.view(data.buffer);
    final completer = Completer<Image>();
    decodeImageFromList(bytes, completer.complete);
    return completer.future;
  }

  static final _instance = Images();
  static Images get instance => _instance;
}
