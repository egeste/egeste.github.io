define [
  'oraculum', 'marked'
  'oraculum/views/mixins/templating-interface'
], (Oraculum, marked) ->
  'use strict'

  Oraculum.defineMixin 'MarkdownTemplating.ViewMixin', {

    render: ->
      template = @mixinOptions.template
      template = template.call this if typeof template is 'function'
      @$el.html marked template if template
      return this

  }, mixins: ['TemplatingInterface.ViewMixin']
