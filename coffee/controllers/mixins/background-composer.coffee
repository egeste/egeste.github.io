define [
  'oraculum'
  'cs!views/background'
  'oraculum/mixins/evented-method'
], (Oraculum) ->
  'use strict'

  Oraculum.defineMixin 'BackgroundComposer.ControllerMixin', {

    mixinOptions:
      eventedMethods:
        beforeAction: {}

    mixinitialize: ->
      @on 'beforeAction:after', @_composeBackground, this

    _composeBackground: ->
      @reuse 'background', 'Background.View',
        container: '#background'
        collection: @session.get 'tree'

  }, mixins: ['EventedMethod.Mixin']
