define [
  'oraculum'
  'cs!views/mixins/markdown-templating'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'MDOUT.View', {

    mixinOptions:
      staticClasses: ['mdout-view']
      template: ->
        return @model.get 'markdown'

  }, mixins: [
    'Disposable.Mixin'
    'StaticClasses.ViewMixin'
    'MarkdownTemplating.ViewMixin'
  ]
