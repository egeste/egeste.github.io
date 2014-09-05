define [
  'oraculum'
  'cs!views/hitmap'
  'oraculum/mixins/evented-method'
], (Oraculum) ->
  'use strict'

  Oraculum.defineMixin 'HitmapComposer.ControllerMixin', {

    mixinOptions:
      eventedMethods:
        beforeAction: {}

    mixinitialize: ->
      @on 'beforeAction:after', @_composeHitmap, this

    _composeHitmap: ->
      @reuse 'hitmap', 'Hitmap.View',
        container: '#hitmap'
        className: 'panel black full-height'

  }, mixins: ['EventedMethod.Mixin']
