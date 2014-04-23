window.memo =
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
