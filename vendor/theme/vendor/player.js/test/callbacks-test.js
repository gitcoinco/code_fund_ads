import test from 'ava';
import { callbackMap, storeCallback, getCallbacks, removeCallback, shiftCallbacks, swapCallbacks } from '../src/lib/callbacks';

test('storeCallback adds the callback when the name doesn’t exist', (t) => {
    const player = {
        element: {}
    };

    const cb = () => {};

    storeCallback(player, 'test', cb);
    t.true('test' in callbackMap.get(player.element));
    t.true(Array.isArray(callbackMap.get(player.element).test));
    t.true(callbackMap.get(player.element).test[0] === cb);
});

test('storeCallback adds the callback when the name already exists', (t) => {
    const player = {
        element: {}
    };

    const cb = () => {};
    const cb2 = () => {};

    storeCallback(player, 'test', cb);
    storeCallback(player, 'test', cb2);
    t.true(callbackMap.get(player.element).test.length === 2);
    t.true(callbackMap.get(player.element).test[1] === cb2);
});

test('getCallbacks returns an empty array when there are no callbacks', (t) => {
    t.deepEqual(getCallbacks({ element: {} }, 'test'), []);
});

test('getCallbacks returns the callbacks', (t) => {
    const player = {
        element: {}
    };

    const cb = () => {};

    callbackMap.set(player.element, { test: [cb] });
    t.deepEqual(getCallbacks(player, 'test'), [cb]);
});

test('removeCallback does nothing if there are no callbacks', (t) => {
    t.true(removeCallback({ element: {} }, 'test'));
});

test('removeCallback removes all callbacks without a callback arg', (t) => {
    const player = {
        element: {}
    };

    const cb = () => {};
    const cb2 = () => {};

    callbackMap.set(player.element, { test: [cb, cb2] });
    t.true(removeCallback(player, 'test'));
    t.deepEqual(callbackMap.get(player.element), { test: [] });
});

test('removeCallback removes just the callback specified', (t) => {
    const player = {
        element: {}
    };

    const cb = () => {};
    const cb2 = () => {};

    callbackMap.set(player.element, { test: [cb, cb2] });
    t.true(removeCallback(player, 'test', cb2) === false);
    t.deepEqual(callbackMap.get(player.element), { test: [cb] });
});

test('removeCallback does nothing if the callback passed isn’t in the map', (t) => {
    const player = {
        element: {}
    };

    const cb = () => {};
    const cb2 = () => {};

    callbackMap.set(player.element, { test: [cb] });
    t.true(removeCallback(player, 'test', cb2) === false);
    t.deepEqual(callbackMap.get(player.element), { test: [cb] });
});

test('shiftCallbacks shifts a single callback from the callback array', (t) => {
    const player = {
        element: {}
    };

    const cb = () => {};
    const cb2 = () => {};

    callbackMap.set(player.element, { test: [cb, cb2] });

    t.true(shiftCallbacks(player, 'test') === cb);

    const callbacks = getCallbacks(player, 'test');
    t.true(callbacks.length === 1);
    t.true(callbacks[0] === cb2);
});

test('shiftCallbacks returns false when there are no callbacks', (t) => {
    const player = {
        element: {}
    };

    callbackMap.set(player.element, { test: [] });
    t.true(shiftCallbacks(player, 'test') === false);
});

test('swapCallbacks moves the callbacks from one key to another', (t) => {
    const oldElement = {};
    const newElement = {};
    const cb = () => {};

    callbackMap.set(oldElement, { test: [cb] });
    swapCallbacks(oldElement, newElement);

    t.true(callbackMap.get(oldElement) === undefined);
    t.deepEqual(callbackMap.get(newElement), { test: [cb] });
});
