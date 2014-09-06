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
          return stdout.push stdout: "highlight: no such file or directory: #{absPath}"

        if 'tree' is node.get 'type'
          return stdout.push stdout: "highlight: not a file: #{absPath}"

        require ["text!../#{absPath}"], (content) ->
          stdout.push markdown: "```\n#{content}\n```"

      return undefined
