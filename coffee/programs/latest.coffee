define ->
  return (session) ->
    tree = session.get 'tree'

    return -> tree.chain().filter(
        (model) -> /^posts\//.test model.get 'path'
      ).map((model) ->
        path = "/#{model.get 'path'}"
        markdown: "[#{path}](#!markdown #{path})"
      ).value()
