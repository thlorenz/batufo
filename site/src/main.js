import App from './App.svelte'

import gameUpdate from '../data/game-update.json'

const routes = {
  home: { id: 'home', hash: '' },
  game: { id: 'game', hash: '#game' },
  watch: { id: 'watch', hash: '#watch' },
  devlog: { id: 'devlog', hash: '#devlog' },
}

const isOnDevlogPage = () => {
  const hash = location.hash
  return hash.startsWith(routes.devlog.hash)
}

const hash = location.hash
const startingRoute =
  hash === routes.game.hash
    ? routes.game
    : hash === routes.watch.hash
    ? routes.watch
    : isOnDevlogPage()
    ? routes.devlog
    : routes.home

const rootURL = location.href.includes('localhost')
  ? '/'
  : 'https://thlorenz.github.io/batufo/'

const app = new App({
  target: document.body,
  props: {
    title: '2D Multiplayer Flutter Game',
    embedVideo: 'https://www.youtube.com/embed/xTcO6lPMUaA',
    embedPlaylist:
      'https://www.youtube.com/embed/videoseries?list=PL4k64WemroGlTDHJzVo_O1l6C0nuwRc6G',
    subChannelURL: 'https://www.youtube.com/user/thlorenz10?sub_confirmation=1',
    gameWebURL: 'https://thlorenz.github.io/batufo/webgame',
    latestReleaseURL: gameUpdate.release.url,
    githubSourceURL: 'https://github.com/thlorenz/batufo',
    youtubePlaylistURL:
      'https://www.youtube.com/watch?list=PL4k64WemroGlTDHJzVo_O1l6C0nuwRc6G&v=xTcO6lPMUaA',
    twitchChannel: 'thlorenz',
    twitchChannelURL: 'https://www.twitch.tv/thlorenz',
    twitterURL: 'https://twitter.com/thlorenz',
    routes,
    state: {
      currentRoute: startingRoute,
    },
    rootURL,
  },
})

export default app
