<script>
  export let title

  export let githubSponsorURL
  export let paypalSponsorURL
  export let patreonSponsorURL
</script>

<style>
  .narrow {
    max-width: 680px;
    margin: 0 auto;
  }
  .buttons {
    padding: 50px;
  }
  .buttons > a {
    padding: 10px;
  }
</style>

<main>
  <h1>{title}</h1>
  <h3>Help me keep developing and sharing this Open Source Game</h3>

  <p class="narrow">
    Many nights and weekends went into the current version of the game.
    <br>
    <br>
    I love sharing it with others so they can enjoy it and learn how games are developed.
    <br>
    <br>
    I am asking for your support to keep the game server running and be able to invest more time.
    <br>
    <br>
    If you like the game and related content please click one of the links below.
  </p>

  <div class="buttons">
    <a href="{githubSponsorURL}">
      Sponsor me on Github 💰
    </a>
    <br>
    <br>
    <a href="{paypalSponsorURL}">Send me a Paypal Token of Appreciation 💸</a>
    <br>
    <br>
    <a href="{patreonSponsorURL}"><img alt="become a patron" src="https://c5.patreon.com/external/logo/become_a_patron_button.png" height="35px"></a>
  </div>
  <p class="narrow">
   💖 I appreciate your help, you are great! 💖
  </p>

</main>
