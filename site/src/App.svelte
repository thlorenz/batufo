<style>
  @import url('https://fonts.googleapis.com/css?family=Space+Mono&display=swap');
  :global(main) {
    font-family: 'Space Mono', monospace;
    text-align: center;
    padding: 0.3em;
    max-width: none;
    margin: 0 auto;
    width: fit-content;
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
  import Editor from './routes/Editor.svelte'
  import Watch from './routes/Watch.svelte'
  import Sponsor from './routes/Sponsor.svelte'
  import Devlog from './routes/Devlog.svelte'

  export let title
  export let embedPlaylist
  export let subChannelURL
  export let gameWebURL
  export let editorURL
  export let twitchChannelURL
  export let latestReleaseURL
  export let twitterURL
  export let youtubePlaylistURL
  export let state
  export let routes
  export let rootURL
  export let githubSourceURL

  export let githubSponsorURL
  export let paypalSponsorURL
  export let patreonSponsorURL

  const getWindowWidth = () => window.innerWidth
    || document.documentElement.clientWidth
    || document.body.clientWidth

  const getWindowHeight = () => window.innerHeight
    || document.documentElement.clientHeight
    || document.body.clientHeight

  $: homeClass = state.currentRoute === routes.home ? 'underline' : ''
  $: editorClass = state.currentRoute === routes.editor ? 'underline' : ''
  $: watchClass = state.currentRoute === routes.watch ? 'underline' : ''
  $: sponsorClass = state.currentRoute === routes.sponsor ? 'underline' : ''
  $: devlogClass = isOnDevlogPage() ? 'underline' : ''
  $: windowWidth = getWindowWidth()
  $: windowHeight = getWindowHeight()


  const navigateHome = () => {
    state.currentRoute = routes.home
    state = state
      window.history.state
  }
  const navigateEditor = () => {
    state.currentRoute = routes.editor
    state = state
  }

  const navigateWatch = () => {
    state.currentRoute = routes.watch
    state = state
  }

  const navigateSponsor = () => {
    state.currentRoute = routes.sponsor
    state = state
  }

  const navigateDevlog = () => {
    state.currentRoute = routes.devlog
    state = state
  }

  const isOnDevlogPage = () => {
    const hash = location.hash
    return hash.startsWith(routes.devlog.hash)
  }

  window.onresize = () => {
    windowWidth = getWindowWidth()
    windowHeight = getWindowHeight()
  }
</script>

<main>
  <nav>
    <a href="{rootURL + routes.home.hash }"
       class="{homeClass}"
       on:click={navigateHome}>Home</a>
    <a href="{rootURL + routes.watch.hash }"
       class="{watchClass}"
       on:click={navigateWatch}>Watch</a>
    <a href="{rootURL + routes.devlog.hash }"
       class="{devlogClass}"
       on:click={navigateDevlog}>Devlog</a>
    <a href="{rootURL + routes.editor.hash}"
       class="{editorClass}"
       on:click={navigateEditor}>Editor</a>
  </nav>
  <div>
    {#if state.currentRoute === routes.home}
      <Home
        {title}
        {embedPlaylist}
        {gameWebURL}
        {twitterURL}
        {twitchChannelURL}
        {latestReleaseURL}
        {githubSourceURL}
        {windowWidth}
      />
    {:else if state.currentRoute === routes.editor}
      <Editor {title} {editorURL} {windowWidth} {windowHeight} />
    {:else if state.currentRoute === routes.watch}
      <Watch {title}
        {subChannelURL}
        {twitchChannelURL}
        {youtubePlaylistURL}
        {windowWidth}
        {embedPlaylist} />
    {:else if state.currentRoute === routes.sponsor}
      <Sponsor {title}
        {githubSponsorURL}
        {paypalSponsorURL}
        {patreonSponsorURL} />
    {:else if state.currentRoute === routes.devlog || isOnDevlogPage()}
      <Devlog />
    {/if}
  </div>
</main>
