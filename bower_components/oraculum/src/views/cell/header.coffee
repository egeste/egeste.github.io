define [
  'oraculum'
  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/cell'
  'oraculum/views/mixins/attach'
  'oraculum/views/mixins/dom-cache'
  'oraculum/views/mixins/static-classes'
  'oraculum/views/mixins/html-templating'
], (Oraculum) ->
  'use strict'

  ###
  Header.Cell
  ===========
  Like all other concrete implementations in Oraculum, this class exists as a
  convenience/example. Please feel free to override or simply not use this
  definition.
  ###

  ###
  This definition is part of Oraculum's tabular interface.
  For more information see:

  @see views/cell/text.coffee
  @see views/cell/header.coffee
  @see views/cell/checkbox.coffee
  @see views/mixins/cell.coffee
  @see views/mixins/column-list.coffee
  @see models/mixins/sortable-column.coffee
  ###

  Oraculum.extend 'View', 'Header.Cell', {

    events:
      'click a': '_sort'

    mixinOptions:
      staticClasses: ['header-cell-view']
      eventedMethods:
        render: {}
      listen:
        'render:after this': '_update'
        'change:label column': '_updateLabel'
        'change:sortable column': '_updateEnabled'
        'change:attribute column': '_updateLabel'
      template: '''
        <a href="javascript:void(0);" />
      '''

    _update: ->
      @_updateLabel()
      @_updateEnabled()

    _updateLabel: ->
      label = @column.get 'label'
      label ?= @column.get 'attribute'
      @$('a').text label

    _updateEnabled: ->
      sortable = Boolean @column.get 'sortable'
      @$('a').toggleClass 'disabled', not sortable

    _sort: ->
      return unless Boolean @column.get 'sortable'
      @column.nextDirection()

  }, mixins: [
    'Cell.ViewMixin'
    'Listener.Mixin'
    'Disposable.Mixin'
    'EventedMethod.Mixin'
    'StaticClasses.ViewMixin'
    'HTMLTemplating.ViewMixin'
  ]
