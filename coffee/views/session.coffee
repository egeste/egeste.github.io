define [
  'oraculum'
  'cs!views/input'
  'cs!views/stdout'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/subview'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/region-attach'
  'oraculum/views/mixins/static-classes'
  'oraculum/views/mixins/remove-disposed'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Session.View', {

    mixinOptions:
      staticClasses: ['session-view']
      subviews:
        stdout: ->
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
    'Subview.ViewMixin'
    'RegionAttach.ViewMixin'
    'StaticClasses.ViewMixin'
    'RemoveDisposed.ViewMixin'
    'AutoRender.ViewMixin'
  ]
