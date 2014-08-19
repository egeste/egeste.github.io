define [
  'oraculum'
  'oraculum/libs'
  'cs!views/session'
  'cs!models/session'
  'oraculum/mixins/evented'
  'oraculum/application/controller'
], (Oraculum) ->
  'use strict'

  $ = Oraculum.get 'jQuery'

  Oraculum.extend 'Controller', 'Index.Controller', {

    constructed: ->
      @session = @__factory().get 'Session.Model'
      @listenTo @session.get('stdout'), 'add', (model) =>
        window.scrollTo 0, document.body.scrollHeight
        return unless input = model.get 'input'
        @redirectTo 'Index.Controller#index', {input},
          redirected: true

    beforeAction: ->
      tree = @session.get 'tree'
      return tree.fetch() unless tree.isSynced()

    index: ({input}, route, {redirected}) ->
      $('#github-is-slow').remove()
      @reuse 'session', 'Session.View',
        model: @session
        container: document.body
      return if redirected
      return @session.run input if input
      @session.run 'markdown posts/welcome.md'

  }, {
    inheritMixins: true
    mixins: ['Evented.Mixin']
  }
