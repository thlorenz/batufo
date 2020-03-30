import App from './App.svelte'

import gameUpdate from '../data/game-update.json'

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
  },
})

export default app
