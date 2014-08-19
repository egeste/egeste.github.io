define [
  'oraculum'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'Model', 'Command.Model',
    defaults: -> _timestamp: Date.now()

  Oraculum.extend 'Collection', 'Command.Collection',
    model: 'Command.Model'
