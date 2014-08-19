define ->
  return (session) ->
    tree = session.get 'tree'
    return ->
      programs = _.chain(tree.pluck 'path').filter((path) ->
        return /^coffee\/programs\/.+\.coffee$/.test path
      ).map((path) ->
        return /^coffee\/programs\/(.+)\.coffee$/.exec(path)[1]
      ).value()
      return stdout: """Egeste.NET v5
Available programs:
  #{programs.join '\n  '}
"""
