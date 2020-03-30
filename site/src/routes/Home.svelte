<script>
  export let title
  export let embedPlaylist
  export let subChannelURL
  export let twitchChannelURL
  export let twitterURL
  export let windowWidth

  $: videoWidth = Math.min(windowWidth * 0.66, 560)
  $: videoHeight = videoWidth / 1.77
</script>

<main>
  <h1>{title}</h1>
  <h4>
    Building a game in
    <a href="https://flutter.dev/">#flutter</a>
    without any libraries or frameworks
  </h4>
  <iframe
    title="YouTube"
    class="center"
    width="{videoWidth}"
    height="{videoHeight}"
    src="{embedPlaylist}"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope;
    picture-in-picture"
    allowfullscreen
  ></iframe>
  <p>
    <a href="{twitchChannelURL}" target="_blank">Follow on Twitch</a>
    |
    <a href="{subChannelURL}" target="_blank">Subscribe on YouTube</a>
    |
    <a href="{twitterURL}" target="_blank">Follow on Twitter</a>
  </p>

</main>
