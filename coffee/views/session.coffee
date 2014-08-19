define [
  'oraculum'
  'cs!views/input'
  'cs!views/stdout'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/attach'
  'oraculum/views/mixins/subview'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/static-classes'
  'oraculum/views/mixins/remove-disposed'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Session.View', {

    mixinOptions:
      staticClasses: ['session-view']
      subviews:
        output: ->
          view: 'STDOUT.View'
          viewOptions:
            container: @el
            collection: @model.get 'stdout'
        input: ->
          view: 'Input.View'
          viewOptions:
            model: @model
            container: @el

  }, mixins: [
    'Disposable.Mixin'
    'Attach.ViewMixin'
    'Subview.ViewMixin'
    'StaticClasses.ViewMixin'
    'RemoveDisposed.ViewMixin'
    'AutoRender.ViewMixin'
  ]
