# batufo

UFO mutli-player game using Flutter.

## Notest Regarding Flutter

### Lifecycle methods on Stateful Widget

#### Start App

- `initState` which must return synchronously
- `didChangeDependencies` which can return asynchronously
- `build`

#### Hot restart App

- `initState` which must return synchronously
- `didChangeDependencies` which can return asynchronously
- `build`
- `reassemble`
- `build`

#### Hot reload App

- `reassemble`
- `build`

#### Never Called

Did not see any calls to these methods, however it is possible they are invoked
when application unloads.

- `didUpdateWidget`
- `deactivate` 
- `dispose` 

