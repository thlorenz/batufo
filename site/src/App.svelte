<style>
  @import url('https://fonts.googleapis.com/css?family=Space+Mono&display=swap');
  :global(main) {
    font-family: 'Space Mono', monospace;
    text-align: center;
    padding: 1em;
    max-width: none;
    margin: 0 auto;
  }

  :global(h1) {
    color: #2E577C;
    text-transform: uppercase;
    font-size: 2.4em;
    font-weight: 100;
  }
  :global(h2) {
    margin-bottom: 2em;
    font-size: 1.4em;
  }
  :global(h4) {
    margin-bottom: 2em;
    font-size: 1em;
  }
  nav {
    text-align: center;
  }
  :global(nav > a) {
    margin: 0 1em 0 1em;
    cursor: pointer;
    font-size: 1.1em;
  }
  :global(.underline) {
    text-decoration: underline;
  }
</style>

<script>
  import Home from './routes/Home.svelte'
  import Game from './routes/Game.svelte'
  import Watch from './routes/Watch.svelte'

  export let title
  export let embedPlaylist
  export let subChannelURL
  export let gameWebURL
  export let twitchChannel
  export let twitchChannelURL
  export let latestReleaseURL
  export let twitterURL
  export let youtubePlaylistURL
  export let state
  export let routes
  export let rootURL

  const getWindowWidth = () => window.innerWidth
    || document.documentElement.clientWidth
    || document.body.clientWidth

  const getWindowHeight = () => window.innerHeight
    || document.documentElement.clientHeight
    || document.body.clientHeight

  $: homeClass = state.currentRoute === routes.home ? 'underline' : ''
  $: gameClass = state.currentRoute === routes.game ? 'underline' : ''
  $: watchClass = state.currentRoute === routes.watch ? 'underline' : ''
  $: windowWidth = getWindowWidth()
  $: windowHeight = getWindowHeight()


  const navigateHome = () => {
    state.currentRoute = routes.home
    state = state
  }
  const navigateGame = () => {
    state.currentRoute = routes.game
    state = state
  }

  const navigateWatch = () => {
    state.currentRoute = routes.watch
    state = state
  }

  window.onresize = () => {
    windowWidth = getWindowWidth()
    windowHeight = getWindowHeight()
  }

  export let githubSourceURL

</script>

<main>
  <nav>
    <a href="{rootURL + routes.home.hash }" class="{homeClass}" on:click={navigateHome}>Home</a>
    <a href="{rootURL + routes.game.hash }" class="{gameClass}" on:click={navigateGame}>Game</a>
    <a href="{rootURL + routes.watch.hash }" class="{watchClass}" on:click={navigateWatch}>Watch</a>
  </nav>
  <div>
    {#if state.currentRoute === routes.home}
      <Home
        {title}
        {embedPlaylist}
        {subChannelURL}
        {gameWebURL}
        {twitterURL}
        {twitchChannelURL}
        {latestReleaseURL}
        {windowWidth}
      />
    {:else if state.currentRoute === routes.game}
      <Game {title} {gameWebURL} {latestReleaseURL} {githubSourceURL} {windowWidth} />
    {:else if state.currentRoute === routes.watch}
      <Watch {title} {twitchChannelURL} {twitchChannel} {youtubePlaylistURL} {windowWidth} />
    {/if}
  </div>
</main>
