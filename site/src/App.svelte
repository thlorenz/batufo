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
    color: #ff3e00;
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
    font-size: 1.0em;
  }
  nav {
    text-align: center;
  }
  :global(nav > a) {
    margin: 0 1em 0 1em;
  }
</style>

<script>
  import { Router, Link, Route } from 'svelte-routing'
  import Home from './routes/Home.svelte'
  import Game from './routes/Game.svelte'

  export let title
  export let embedPlaylist
  export let subChannelURL
  export let gameWebURL
  export let latestReleaseURL
  export let githubSourceURL

  export let url = ''
</script>

<Router {url}>
  <nav>
    <Link to="/">Home</Link>
    <Link to="game">Game</Link>
  </nav>
  <div>
    <Route path="game">
      <Game {title} {gameWebURL} {latestReleaseURL} {githubSourceURL} />
    </Route>
    <Route path="/">
      <Home
        {title}
        {embedPlaylist}
        {subChannelURL}
        {gameWebURL}
        {latestReleaseURL}
      />
    </Route>
  </div>
</Router>
