<script>
  export let title
  export let twitterURL
  export let githubSourceURL

  export let latestReleaseURL
  let macOSReleaseURL = latestReleaseURL.replace('tag', 'download') + '/batufo-macos.zip'
</script>

<style>
</style>

<main class="main">
  <h1>{title}</h1>
  <div class="installs">
  <h5>Android</h5>
  <a href='https://play.google.com/store/apps/details?id=com.thlorenz.batufo&utm_source=home-page&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'>
    <img width="208px" alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/>
  </a>
  <h5>Linux</h5>
  <a href="https://snapcraft.io/batufo">
    <img alt="Get it from the Snap Store" src="https://snapcraft.io/static/images/badges/en/snap-store-black.svg" />
  </a>
  <h5>macOS</h5>
  <a href="{macOSReleaseURL}">
    <img width="108px" alt="Install on macOS" src="https://cdn1.iconfinder.com/data/icons/system-black-circles/512/mac_os_X-512.png" />
  </a>
  <h5>Play Online</h5>
  <a href="http://thlorenz.com/batufo/webgame">
    <img width="128px" alt="Play in the Browser" src="https://icons.iconarchive.com/icons/google/chrome/128/Google-Chrome-icon.png" />
  </a>
  <div>
  <p>
    <a href="{twitterURL}" target="_blank">Follow on Twitter</a> |
    <a href="{githubSourceURL}" target="_blank">Source on Github</a>
  </p>
</main>
