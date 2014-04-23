memojs
======

A lightweight wrapper around the localStorage API.

### How to use

Add `memojs` to your Gemfile and require memojs in your JavaScript manifest. Add this line to your application.js file:

    //= require memojs

`window` will now have a `memo` object with the following somewhat self-explanatory functions.

  set(key, value)
  Adds `value` to the store using `key`

  get(key)
  Returns the value for the given `key`. Returns null for keys without values.

  keys()
  Returns an array with all keys present in the store

  delete(key)
  Removes `key` from the store

  clear()
  Removes all keys from the store

  all()
  Returns a JavaScript object with all keys and their values.

### Is JSON supported?

Yes. Under the hood memojs uses JSON.stringify/parse allowing you set objects and read objects.

    memo.set("colors", ["red", "blue", "green"])
    memo.get("colors")
    => ["red", "blue", "green"]

### Supported browsers

memojs has only been tested with Chrome 34 for Mac, but should work with IE9+ and all recent versions of other browsers.
