define [
  'oraculum'
  'oraculum/mixins/evented-method'
], (Oraculum) ->
  'use strict'

  Oraculum.defineMixin 'JSONP.ModelMixin', {

    mixinOptions:
      eventedMethods:
        sync: {}

    mixinitialize: ->
      @on 'sync:before', @_setJsonpBit, this

    _setJsonpBit: (method, model, options) ->
      options.cache = true
      options.dataType = 'jsonp'
      options.jsonpCallback = 'callbackulum'

  }, mixins: [
    'EventedMethod.Mixin'
  ]
