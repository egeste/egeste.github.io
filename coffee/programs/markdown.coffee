define [
  'underscore'
  'cs!programs/realpath'
], (_, realpath) ->

  return (session) ->
    tree = session.get 'tree'
    stdout = session.get 'stdout'

    return (files...) ->

      _.each files, (file) ->
        absPath = realpath(session)(file).stdout
        path = absPath.replace /^\//, ''

        unless node = tree.findWhere {path}
          return stdout.push stdout: "markdown: no such file or directory: #{absPath}"

        if 'tree' is node.get 'type'
          return stdout.push stdout: "markdown: not a file: #{absPath}"

        unless /\.md/i.test absPath
          return stdout.push stdout: "Cannot render: #{absPath}"

        require ["text!../#{absPath}"], (markdown) ->
          stdout.push {markdown}

      return undefined
