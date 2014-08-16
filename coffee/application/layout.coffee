define [
  'oraculum'
  'oraculum/views/mixins/layout'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Blog.Layout', {
    el: document.body

    mixinOptions:
      regions:
        content: '#main_content'

  }, mixins: ['Layout.ViewMixin']
