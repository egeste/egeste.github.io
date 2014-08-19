define [
  'underscore'
  'cs!programs/realpath'
], (_, realpath) ->
  return (session) ->
    tree = session.get 'tree'
    stdout = session.get 'stdout'
    return (files...) ->
      renderable = []
      unrenderable = []
      _.each files, (file) ->
        absPath = realpath(session)(file).stdout
        unless /\.md/i.test absPath
          return stdout.push stdout: "Cannot render: #{absPath}"
        require ["text!../#{absPath}"], (markdown) ->
          stdout.push {markdown}
      return undefined
