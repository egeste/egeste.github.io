define [
  'oraculum'
  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/list'
  'oraculum/views/mixins/attach'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/static-classes'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Files.View', {
    tagName: 'ul'
    className: 'list-unstyled'

    initialize: ->
      @collection = @model.get 'output'

    mixinOptions:
      staticClasses: ['files-view']
      list: modelView: 'File.View'

  }, mixins: [
    'Disposable.Mixin'
    'List.ViewMixin'
    'Attach.ViewMixin'
    'StaticClasses.ViewMixin'
    'AutoRender.ViewMixin'
  ]

  Oraculum.extend 'View', 'File.View', {
    tagName: 'li'

    initialize: ->
      @_updateTypeClass()

    mixinOptions:
      staticClasses: ['file-view']
      listen:
        'change:type model': '_updateTypeClass'
      template: '''
        <span data-prop="model" data-prop-attr="name"/>
      '''

    _updateTypeClass: ->
      @$el.removeClass @model.previous 'type'
      @$el.addClass @model.get 'type'

  }, mixins: [
    'Listener.Mixin'
    'Disposable.Mixin'
    'StaticClasses.ViewMixin'
    'HTMLTemplating.ViewMixin'
    'DOMPropertyBinding.ViewMixin'
  ]
