<style>
  article {
    text-align: left;
    max-width: 700px;
    margin: 1em auto;
    padding: 0.2em 0.4em;
  }
  .separator {
    background: #aaa;
    border: solid #aaa 0.04em;
    border-radius: 2px;
  }
  :global(article h1, article h2, article h3, article h4, article h4, article
      h5) {
    text-align: left;
  }
  :global(article h1) {
    font-size: 1.7em;
    text-align: left;
  }
  :global(article h2) {
    padding-left: 0.1em;
    text-align: left;
  }
  :global(article h3, article h4, article h4, article h5) {
    padding-left: 0.4em;
  }
  :global(article .right) {
    text-align: right;
  }
</style>

<script>
  import Networking from '../devlog/networking.md'
  import BatufoNetworking from '../devlog/batufo-networking.md'
  import BatufoTodos from '../devlog/batufo-todos.md'
  import BatufoAttrib from '../devlog/batufo-attrib.md'
  const bafuNetworkingID = 'devlog-applying-strategies'
  const multiplayerArchitectureID = 'devlog-multiplayer-architecture'
  const batufoTodosID = 'devlog-batufo-todos'
  const batufoAttribID = 'devlog-batufo-attrib'
</script>

<main>
  <article id="{batufoAttribID}">
    <BatufoAttrib link="#{batufoAttribID}" />
  </article>
  <article id="{batufoTodosID}">
    <BatufoTodos link="#{batufoTodosID}" />
  </article>
  <article id="{bafuNetworkingID}">
    <BatufoNetworking link="#{bafuNetworkingID}" />
  </article>
  <p class="separator"></p>
  <article id="{multiplayerArchitectureID}">
    <Networking link="#{multiplayerArchitectureID}" />
  </article>
</main>
