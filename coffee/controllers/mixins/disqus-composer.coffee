define [
  'disqus'
  'oraculum'
  'oraculum/mixins/evented-method'
], (disqus, Oraculum) ->
  'use strict'

  Oraculum.defineMixin 'DisqusComposer.ControllerMixin', {

    mixinOptions:
      eventedMethods:
        execute: {}

    mixinitialize: ->
      @on 'execute:after', @_resetDisqus, this

    _resetDisqus: ({input}) ->
      return unless input
      _.defer -> disqus.reset
        reload: true
        config: ->
          @page.identifier = input
          @page.url = window.location.href

  }, mixins: ['EventedMethod.Mixin']
