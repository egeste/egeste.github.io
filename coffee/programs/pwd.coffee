define ['cs!programs/realpath'], (realpath) ->
  return (session) ->
    return -> realpath(session) '.'
