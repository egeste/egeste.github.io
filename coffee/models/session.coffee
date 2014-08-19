define [
  'oraculum'
  'cs!models/tree'
  'cs!models/command'
  'oraculum/models/mixins/sync-machine'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'Model', 'Session.Model', {

    defaults: ->
      pwd: '/'
      tree: @__factory().get 'Tree.Collection'
      stdout: @__factory().get 'Command.Collection'

    run: (input) ->
      tree = @get 'tree'
      stdout = @get 'stdout'
      [command, args...] = input.split /\s+/
      stdout.push {input, command, args}
      unless tree.findWhere(path: "coffee/programs/#{command}.coffee")
        return stdout.push stdout: "command not found: #{command}"
      require ["cs!programs/#{command}"], (cmd) =>
        if result = cmd(this) args...
          stdout.add result

  }, {
    singleton: true
    mixins: ['SyncMachine.ModelMixin']
  }
