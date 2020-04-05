# Appling Multiplayer Strategies to Our Game

<p class="right">`Saturday, April 4, 2020`</p>

## Main Strategy Used

- authoritative server sending updates every 100ms
- client updates are limited to 10/second
- client side prediction is used to exrapolate opponent's position from previous position and
  their velocity
- other players and bullets are predicted on the client from previous position and velocity
  - same controllers as on server are used which allows us to predict collisions client side as
    well
- use dead reckoning to correct client predictions, both for opponents and bullets as well as
  our own player
 

## Limiting Player Inputs

- require 100ms between each shot
  - instead of sending a key press we send `bulletCreated(angle)`
- require 100ms between each thrust
  - instead of sending key press we send `appliedThrust(anger)`
  - server then calculates velocity
- instead of sending rotation input we send `updatedAngle(angle)`
- change of player angle happens in real time but is reported to the server at a 100ms interval
  even if no other client action occured

## Server Processing of Player Inputs

- delay execution of action until server tick
  - in the worst case bullet is trailing client side prediction by 100ms
- find way to align client input ticks to server ticks

## To be seen

- test how well dead reckoning works for our game and try the following if we end up with lots
  of player position jumps
- apply smooting to correct position slowly over time
- if nothing else works look into interpolation

## Smaller Packets

- if packets get too large we can omit bullet positions
  - instead rely on client prediction to show bullets in flight
  - use server to report created bullets `createBullet(bulletID, position, velocity)`
    - after that client predicts positions
  - and exploded bullets
    - `explodedBullet(bulletID, position)`
- alternative is to limit amount of bullets / ammo available
