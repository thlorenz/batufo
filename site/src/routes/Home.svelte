<script>
  export let title
  export let embedPlaylist
  export let subChannelURL
  export let gameWebURL
  export let latestReleaseURL
</script>

<main>
  <h1>{title}</h1>
  <h4>
    Building a game in
    <a href="https://flutter.dev/">#flutter</a>
    without any libraries or frameworks
  </h4>
  <iframe
    class="center"
    width="560"
    height="315"
    src="{embedPlaylist}"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope;
    picture-in-picture"
    allowfullscreen
  ></iframe>
  <p>
    <a href="{subChannelURL}" target="_blank">Subscribe</a>
  </p>

</main>
