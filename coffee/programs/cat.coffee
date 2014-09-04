define ['cs!programs/realpath'], (realpath) ->
  return (session) ->
    return (newPwd) ->
      unless path = realpath(session)(newPwd).stdout.replace /^\//, ''
        session.set pwd: '/'
      else unless tree = session.get('tree').findWhere {path}
        return stdout: "cat: no such file or directory: #{path}"
      else if 'tree' is tree.get 'type'
        return stdout: "cat: not a file: #{path}"
      else require ["text!../#{path}"], (stdout) ->
        session.get('stdout').push {stdout}
      return undefined
