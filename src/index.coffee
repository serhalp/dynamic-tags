tags = {}

module.exports =
  registerTag: (tag, fn) ->
    tags[tag] = fn
    return

  computeTag: (tag, obj) ->
    tags[tag]?(obj)
