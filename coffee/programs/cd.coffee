define ['cs!programs/realpath'], (realpath) ->
  return (session) ->
    return (newPwd) ->
      unless path = realpath(session)(newPwd).stdout.replace /^\//, ''
        session.set pwd: '/'
      else unless tree = session.get('tree').findWhere {path}
        return stdout: "cd: no such file or directory: #{path}"
      else unless 'tree' is tree.get 'type'
        return stdout: "cd: not a directory: #{path}"
      else session.set pwd: "/#{tree.get 'path'}"
      return undefined
