import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' show Image, decodeImageFromList;

import 'package:flutter/services.dart';

class Images {
  final loaded = Map<String, Image>();

  Future<List<Image>> loadAll(List<String> paths) {
    final loaders = paths.map(load);
    return Future.wait(loaders);
  }

  Future<Image> load(String path) async {
    if (!loaded.containsKey(path)) {
      final image = await _fetchFromMemory(path);
      loaded[path] = image;
    }
    return loaded[path];
  }

  Future<Image> _fetchFromMemory(String path) async {
    final data = await rootBundle.load(path);
    final bytes = Uint8List.view(data.buffer);
    final completer = Completer<Image>();
    decodeImageFromList(bytes, (image) => completer.complete(image));
    return completer.future;
  }

  static final _instance = Images();
  static Images get instance => _instance;
}
