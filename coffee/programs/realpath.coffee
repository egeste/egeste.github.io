resolveRoot = (newPwd, oldPwd) ->
  newPwd = newPwd.split /\/+/
  oldPwd = oldPwd.split /\/+/
  switch newPwd[0]
    when '' then newPwd.shift()
    when '.' then newPwd = oldPwd.concat newPwd
    when '..'
      oldPwd.pop()
      newPwd.shift()
      newPwd = oldPwd.concat newPwd
  return newPwd

absPath = (pathSpec) ->
  return _.reduce(pathSpec, ((memo, pathSpec) ->
    switch pathSpec
      when '.' then #nop
      when '..' then memo.pop()
      else memo.push pathSpec
    return memo
  ), []).join '/'

define ->
  return (session) ->
    return (newPwd) ->
      oldPwd = session.get 'pwd'
      pathSpec = resolveRoot newPwd, oldPwd
      return output: absPath pathSpec
