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
      @_parseJSONSilently(value)
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
      oldValue: @_parseJSONSilently(storageEvent.oldValue)
      newValue: @_parseJSONSilently(storageEvent.newValue)
      url: storageEvent.url
    for listener in listeners
      listener(eventObject)

  _parseJSONSilently: (jsonString) ->
    try
      JSON.parse(jsonString)
    catch error
      jsonString


memo = new Memo

window.addEventListener 'storage', memo._fireChange, false
window.memo = memo
