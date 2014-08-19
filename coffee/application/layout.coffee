define [
  'oraculum'
  'oraculum/views/mixins/layout'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Console.Layout', {
    el: document.body

    mixinOptions:
      layout:
        scrollTo: [0, '100%']

  }, mixins: ['Layout.ViewMixin']
