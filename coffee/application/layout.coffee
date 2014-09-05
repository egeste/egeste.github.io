define [
  'oraculum'
  'oraculum/views/mixins/layout'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Console.Layout', {
    el: document.body

    mixinOptions:
      layout:
        scrollTo: false

  }, mixins: ['Layout.ViewMixin']
