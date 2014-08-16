define [
  'oraculum'
  'oraculum/application/controller'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'Controller', 'Index.Controller', {

    index: ->
      console.log 'Index.Controller#index'

  }, inheritMixins: true
