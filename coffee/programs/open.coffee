define ['cs!programs/realpath'], (realpath) ->
  return (session) ->
    return (files...) ->
      window.open realpath(session)(file).stdout for file in files
      return undefined
