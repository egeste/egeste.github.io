define [
  'underscore'
  'cs!programs/realpath'
], (_, realpath) ->

  parseOptions = (args) ->
    return _.reduce args, ((memo, arg) ->
      switch arg
        when '-l' then memo.list = true
        else memo.paths.push arg
      return memo
    ), { paths: [] }

  return (session) ->
    fileTree = session.get 'tree'
    return (args...) ->
      {paths, list} = parseOptions args
      paths.push '.' unless paths.length
      return _.map paths, (path) ->
        absPath = realpath(session)(path).stdout
        testPath = absPath.replace /^\//, ''
        paths = _.chain(fileTree.pluck 'path').filter((node) ->
          return ///^#{testPath}\/?[^\/]*$///.test node
        ).map((node) ->
          return node.replace ///^#{testPath}\/?///, ''
        ).compact().value()
        return stdout: "#{absPath}:\n  #{paths.join '\n  '}"
