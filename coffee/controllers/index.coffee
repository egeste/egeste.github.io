define [
  'oraculum'
  'oraculum/libs'

  'cs!views/session'
  'cs!models/session'

  'cs!controllers/mixins/disqus-composer'
  'cs!controllers/mixins/hitmap-composer'
  # 'cs!controllers/mixins/background-composer'

  'oraculum/mixins/evented'
  'oraculum/application/controller'
], (disqus, Oraculum) ->
  'use strict'

  $ = Oraculum.get 'jQuery'

  Oraculum.extend 'Controller', 'Index.Controller', {

    constructed: ->
      @session = @__factory().get 'Session.Model'
      @listenTo @session.get('stdout'), 'add', (model) =>
        return unless input = model.get 'input'
        @redirectTo 'Index.Controller#execute', {
          input: encodeURIComponent input
        }, redirected: true

    beforeAction: ->
      tree = @session.get 'tree'
      unless tree.isSynced()
        return tree.fetch().then ->
          $('#github-is-slow').remove()

    hashbang: ({input}) ->
      @redirectTo 'Index.Controller#execute', {input}

    execute: ({input}, route, {redirected}) ->
      console.log arguments

      @reuse 'session', 'Session.View',
        model: @session
        container: '#session'
        className: 'panel black full-height'
        collection: @session.get 'stdout'

      if input
        @session.run decodeURIComponent input unless redirected
      else
        @session.run 'markdown /posts/welcome.md' unless redirected

  }, {
    inheritMixins: true
    mixins: [
      'Evented.Mixin'
      'DisqusComposer.ControllerMixin'
      'HitmapComposer.ControllerMixin'
      # 'BackgroundComposer.ControllerMixin'
    ]
  }
