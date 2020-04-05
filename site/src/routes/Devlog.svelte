<style>
  article {
    text-align: left;
    max-width: 700px;
    margin: 1em auto;
    padding: 0.2em 2em;
  }
  .separator {
      background: #aaa;
      border: solid #aaa 0.04em ;
      border-radius: 2px;
  }
  :global(article h1) {
    font-size: 1.7em;
      text-align: center;
  }
  :global(article .right) {
    text-align: right;
  }
</style>

<script>
  import Networking from '../devlog/networking.md'
  import BatufoNetworking from '../devlog/batufo-networking.md'
</script>

<main>
  <article>
    <BatufoNetworking />
  </article>
  <p class="separator"></p>
  <article>
    <Networking />
  </article>
</main>
