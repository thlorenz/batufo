<script>
  import { onMount } from 'svelte'
  export let title
  export let twitchChannelURL
  export let twitchChannel
  export let youtubePlaylistURL

  export let windowWidth

  $: videoWidth = Math.min(windowWidth * 0.66, 1400)
  $: videoHeight = videoWidth / 1.77
  $: layout = videoWidth > 900 ? 'video-with-chat' : 'video'

  onMount(
    () =>
      new window.Twitch.Embed('twitch-embed', {
        width: videoWidth,
        height: videoHeight,
        layout,
        channel: twitchChannel,
      })
  )
</script>

<main>
  <h1>{title}</h1>
  <h2>Watch live on Twitch</h2>

  <div id="twitch-embed"></div>
  <a href="{twitchChannelURL}" target="_blank">Twitch Channel</a>
  |
  <a href="{youtubePlaylistURL}" target="_blank">YouTube Playlist</a>
</main>
