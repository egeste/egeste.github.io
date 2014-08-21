define [
  'oraculum'
  'oraculum/views/mixins/layout'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Console.Layout', {
    el: document.body

    mixinOptions:
      regions:
        session: '#session'
        background: '#background'

  }, mixins: ['Layout.ViewMixin']
