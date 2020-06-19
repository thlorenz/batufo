<style>
  .italic {
    font-style: italic;
  }
  .release-link {
    background-color: yellow;
    border-radius: 3px;
    text-decoration: underline;
    padding: 5px 10px;
  }
</style>

<script>
  import { onMount } from 'svelte'

  export let title
  export let gameWebURL
  export let latestReleaseURL
  export let githubSourceURL
  export let iframe = null
  export let windowWidth

  onMount(() => iframe.focus())

  $: gameWidth = Math.min(windowWidth * 0.66, 560)
  $: gameHeight = gameWidth
</script>

<main>
  <h1>{title}</h1>
  <p>
    Get the
    <a class="release-link" href="{latestReleaseURL}" target="_blank">
      Latest Release
    </a>
    <span class="italic">with sound effects and a beautiful universe!</span>
  </p>
  <p>You can also try the web version below.</p>
  <p>
    However keep in mind that the performance of the native apps is far
    superior.
  </p>
  <iframe
    title="game"
    class="center"
    width="{gameWidth}"
    height="{gameHeight}"
    src="{gameWebURL}"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope;
    picture-in-picture"
    allowfullscreen
    bind:this="{iframe}"
  ></iframe>
  <p>
    <a href="{githubSourceURL}" target="_blank">Source on Github</a>
  </p>
</main>
