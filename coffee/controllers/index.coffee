define [
  'disqus'
  'oraculum'
  'oraculum/libs'

  'cs!models/session'

  'cs!views/session'
  'cs!views/background'

  'oraculum/mixins/evented'
  'oraculum/application/controller'
], (disqus, Oraculum) ->
  'use strict'

  $ = Oraculum.get 'jQuery'

  Oraculum.extend 'Controller', 'Index.Controller', {

    constructed: ->
      @session = @__factory().get 'Session.Model'
      @listenTo @session.get('stdout'), 'add', (model) =>
        window.scrollTo 0, document.body.scrollHeight
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
      @reuse 'background', 'Background.View',
        region: 'background'
        collection: @session.get 'tree'
      @reuse 'session', 'Session.View',
        model: @session
        region: 'session'
      return if redirected
      return @session.run 'markdown posts/welcome.md' unless input
      @session.run decodeURIComponent input
      disqus.reset
        reload: true
        config: ->
          @page.identifier = input
          @page.url = window.location.href

  }, {
    inheritMixins: true
    mixins: ['Evented.Mixin']
  }
