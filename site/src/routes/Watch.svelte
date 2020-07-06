<script>
  export let title
  export let embedPlaylist
  export let twitchChannelURL
  export let subChannelURL
  export let youtubePlaylistURL

  export let windowWidth

  $: videoWidth = Math.min(windowWidth * 0.66, 560)
  $: videoHeight = videoWidth / 1.77
</script>

<main>
  <h1>{title}</h1>
  <h4>Watch Game Development on YouTube or live on Twitch</h4>
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
  <div>
    <a href="{subChannelURL}" target="_blank">Subscribe on YouTube</a> |
    <a href="{twitchChannelURL}" target="_blank">Twitch Channel</a> |
    <a href="{youtubePlaylistURL}" target="_blank">YouTube Playlist</a>
  </div>
</main>
