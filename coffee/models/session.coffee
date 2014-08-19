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
      stdout = @get 'stdout'
      [command, args...] = input.split /\s+/
      stdout.push {input, command, args}
      require ["cs!programs/#{command}"], (cmd) =>
        if output = cmd(this) args...
          stdout.add output

  }, {
    singleton: true
    mixins: ['SyncMachine.ModelMixin']
  }
