# Migrating from Froogaloop

Follow these steps to update your code from Froogaloop.

## Step 1: Modify the embed code

The first step in the migration is to remove the `api` and `player_id` query
parameters from the embed code. Query parameters are no longer required to
enable the Player JS API. You can leave the `player_id` if you wish, but we
encourage you to use the player object itself to keep track of multiple players.

## Step 2: Update the constructors

The parameters passed to the constructor haven’t changed, so the only thing
you’ll need to do is update the name:

```js
var froogaloop = $f(iframe);
```

becomes:

```js
var player = new Vimeo.Player(iframe);
```

## Step 3: Remove the ready handler

The JS API library no longer requires you to wait for the `ready` event to begin
using the player, so the `ready` handler can be completely removed.

```js
froogaloop.addEvent('ready', function() {
    froogaloop.addEvent('pause', onPause);
});
```

becomes:

```js
player.on('pause', onPause);
```

If you’d prefer to keep your setup code in a ready handler, you can use the
`ready()` promise, but we’d recommend against using it.

```js
player.ready().then(function() {
    player.on('pause', onPause);
});
```

## Step 4: Update event listeners

The JS API library uses `.on()` to register events, so you’ll need to update any
calls to `.addEvent()`:

```js
froogaloop.addEvent('finish', callback);
```

becomes:

```js
player.on('ended', callback);
```

The `data` object passed to your event callback remains the same, so no changes
are necessary for your callback function.

Note that some event names have been updated to match their equivalent name in
the HTML spec:

| old          | new        |
| ------------ | ---------- |
| playProgress | timeupdate |
| loadProgress | progress   |
| finish       | ended      |
| seek         | seeked     |


## Step 5: Update method calls, getters, and setters

All methods, getters, and setters are now functions directly on the `Player`
object, rather than being passed as a string to the `.api()` function:

```js
froogaloop.api('getVideoUrl', function(url) {
    console.log('url:', url);
});

froogaloop.api('setColor', '00adef');

froogaloop.api('play');
```

becomes:

```js
player.getVideoUrl().then(function(url) {
    console.log('url:', url);
}).catch(function(error) {
    console.error('error:', error.name);
});

player.setColor('00adef').then(function(color) {
    console.log('color set to:', color);
}).catch(function(error) {
    console.error('error setting color:', error.name);
});

player.play().catch(function(error) {
    console.error('error playing the video:', error.name);
});
```

Notice that all methods return a promise, so it’s a good idea to make sure that
there is a `catch()` after every method call so you can react to any errors
that may happen.
