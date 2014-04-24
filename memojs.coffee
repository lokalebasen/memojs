class Memo
  constructor: ->
    @_storageKeyEventListeners = {}

  set: (key, value)->
    unless value is undefined
      serializedValue = JSON.stringify(value)
      window.localStorage[key] = serializedValue
      value

  get: (key) ->
    if value = localStorage[key]
      try
        JSON.parse(value)
      catch error # It's not valid JSON, so probably set by something using localStorage directly.
        value
    else
      null

  keys: ->
    Object.keys(localStorage)

  delete: (key) ->
    localStorage.removeItem(key)

  clear: ->
    localStorage.clear()

  all: ->
    object = {}
    @keys().map (key) =>
      object[key] = @get(key)
    object

  addListener: (key, handler) ->
    if handlers = @_storageKeyEventListeners[key]
      handlers.push(handler)
    else
      @_storageKeyEventListeners[key] = [handler]

  _fireChange: (storageEvent) =>
    listeners = @_storageKeyEventListeners[storageEvent.key] || []
    eventObject =
      key: storageEvent.key
      oldValue: JSON.parse(storageEvent.oldValue)
      newValue: JSON.parse(storageEvent.newValue)
      url: storageEvent.url
    for listener in listeners
      listener(eventObject)

memo = new Memo

window.addEventListener 'storage', memo._fireChange, false
window.memo = memo
