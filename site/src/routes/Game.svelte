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
  .narrow {
    max-width: 500px; 
    padding: 20px;
    margin: auto;
  }
</style>

<script>
  export let title
  export let gameWebURL
  export let latestReleaseURL
  export let githubSourceURL
  export let windowWidth
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
  <a href="{gameWebURL}">You can also try the web version.</a>
  <p class="narrow">
    However keep in mind that the performance of the native apps is far
    superior and make sure to keep your browser window small for better game play.
  </p>
  <p>
    <a href="{githubSourceURL}" target="_blank">Source on Github</a>
  </p>
</main>
