define [
  'oraculum'
  'cs!views/session'
  'cs!models/session'
  'oraculum/application/controller'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'Controller', 'Index.Controller', {

    beforeAction: ->
      session = @__factory().get 'Session.Model'
      tree = session.get 'tree'
      return tree.fetch() unless tree.isSynced()

    index: ->
      session = @__factory().get 'Session.Model'
      @reuse 'session', 'Session.View',
        model: session
        container: document.body
      # stdout = @__factory().get 'stdout'

  }, inheritMixins: true
