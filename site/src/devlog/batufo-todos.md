<script>
    export let link
</script>

# [What's left to go to _"Production"_]({link})

<p class="right">`Friday, May 8, 2020`</p>

The game is basically finished at this point. We demonstrated that it is possible to build
Multiplayer games like this with Flutter.

We also learned that making the server authoritative adds a lot of complexity. Not that it
isn't solvable, but not worrying about cheaters makes the life of us developers a lot easier ;)

Below I'm listing known issues that would need to be considered/fixed before the game as is
would be ready to go to _"production"_ to be played by people all over the world.

The video series doesn't include these fixes as it ends here as its purpose was merely to get
people excited about building games in general and to demonstrate that Flutter is a viable and
also fun technology to do so.

If you're inspired you may continue building the game or build your own.

If you do the former you can start attacking issues listed below and/or refactor the code to
not require an authoritative server and get an idea how much easier things become as a result.

Happy Hacking!

## Client Side

-  sync player position smoothly
  - when position differs from server sent position don't jump to it immediately
  - instead adjust players velocity so that it converges towards the server position
  - over time server and client positions should either sync up or at least they don't go
    further out of sync event though we don't force correct with a jump

-  client networking
  - when client disconnects i.e. I'm in a tunnel it needs to be able to reconnect
  - this requires some logic to detect disconnects and have a reconnect strategy, i.e. [circuit breaker](https://en.wikipedia.org/wiki/Circuit_breaker_design_pattern) to prevent it trying to reconnect indefinitely
  - if reconnection fails tell the client that game is over or similar

## Server Side

-  Clean up Games
  - as of now games that finished never get collected
  - first we need a way to detect if a game is over
    - when only one player is alive
    - it is nice to show player still floating around even when game is over
    - how long do we give all players to restart game before we collect it
    - what if all players disconnect?
    - how long can a player be disconnected until it is disqualified and declared dead?

-  Server needs to handle client reconnecting
  - when client provides game + client ids we reconnect the update streams

-  Make Server resilient
  - what happens if server crashes?
  - need to have a way to detect that and have it restarted
  - this can be handled by tools like systemd or load balancers

-  How do sticky sessions work when we have multiple servers
  - only need to fix this once we have certain success and lots of concurrent players
  - once we have multiple servers need to figure out how to propagate RPC streams
  - which load balancers support those + http2

-  deploy server(s)
  - where can we deploy dart servers?

## Added Features

-  Pickups
  - have health packets to allow players to pickup and increase their health balance
  - other pickups could increase player score

-  Black Holes
  - draw players in to make things more interesting

-  Visualize Thrust + Bullet State
  - players can only apply thrust and shoot at certain intervals
  - it would be nice to visualize the time left until we can do either
  - it could look similar to the health bar
