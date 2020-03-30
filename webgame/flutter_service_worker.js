'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "88bc388509fdbc7e8442fa297342aaae",
"main.dart.js": "378a3bb20720a48bbd24cd2481719f5d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "68b08c8a6d0616cc196c6e68837902b7",
"assets/LICENSE": "5cdba8b3c16ebbd57fc962cf8aef0c11",
"assets/AssetManifest.json": "311037d46ec8b09ce87a808cf2d92bfa",
"assets/FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/images/static/wall-metal.png": "1200e3ff1937655117c1beeb32b056f6",
"assets/assets/images/bg/floor-tiles.png": "0b273917f95708851f7c8b6ce5754c1f",
"assets/assets/images/sprites/thrust.png": "fbfb9eff8657d27d7d11203ef1da839c",
"assets/assets/images/sprites/bullet-explosion.png": "4310b53845b066f1bd7419726a1d787d",
"assets/assets/images/sprites/player.png": "79ee2d8cd0091bf8a35e1c6e5eeeb390"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
