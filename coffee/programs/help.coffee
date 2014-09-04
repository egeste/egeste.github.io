define ->
  return (session) ->
    tree = session.get 'tree'
    stdout = session.get 'stdout'
    return ->
      programs = _.chain(tree.pluck 'path').filter((path) ->
        return /^coffee\/programs\/.+\.coffee$/.test path
      ).map((path) ->
        return /^coffee\/programs\/(.+)\.coffee$/.exec(path)[1]
      ).value()
      stdout.push stdout: 'Egeste.NET v5'
      stdout.push stdout: 'Available Commands:'
      for program in programs
        stdout.push
          stdout: program
          viewOptions:
            className: 'inline-block'
      return undefined
