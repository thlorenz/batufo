<style>
  .italic {
    font-style: italic;
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

  $: videoWidth = Math.min(windowWidth * 0.66, 560)
  $: videoHeight = videoWidth / 1.77
</script>

<main>
  <h1>{title}</h1>
  <h2>Source and Releases</h2>

  <p>
    <a href="{latestReleaseURL}" target="_blank">Latest Release</a>
    <span class="italic">now with sound effects and a beautiful universe!</span>
  </p>
  <p>
    <a href="{githubSourceURL}" target="_blank">Source on Github</a>
  </p>
  <h2>Play the Web Version</h2>
  <iframe
    title="game"
    class="center"
    width="{videoWidth}"
    height="{videoHeight}"
    src="{gameWebURL}"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope;
    picture-in-picture"
    allowfullscreen
    bind:this="{iframe}"
  ></iframe>
 <p>
   <a href="{gameWebURL}" target="_blank">Full Screen</a>
   <em>Make sure to keep the window small or performance will suffer.</em>
 </p>
</main>
