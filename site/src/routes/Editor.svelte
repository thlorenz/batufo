<style>
  .italic {
    font-style: italic;
  }
</style>

<script>
  import { onMount } from 'svelte'

  export let title
  export let editorURL
  export let iframe = null
  export let windowWidth
  export let windowHeight

  onMount(() => iframe.focus())

  $: editorWidth = windowWidth * 0.95
  $: editorHeight =windowHeight * 0.80
</script>

<main>
  <h1>{title}</h1>
  <p>
  <a href="{editorURL}" target="_blank">Full Screen</a> <span class="italic">Recommended</span>
  </p>
  <iframe
    title="game"
    class="center"
    width="{editorWidth}"
    height="{editorHeight}"
    src="{editorURL}"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope;
    picture-in-picture"
    allowfullscreen
    bind:this="{iframe}"
  ></iframe>
</main>
