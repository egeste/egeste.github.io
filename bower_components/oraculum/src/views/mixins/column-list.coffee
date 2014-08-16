define [
  'oraculum'
  'oraculum/libs'
  'oraculum/views/mixins/list'
], (Oraculum) ->
  'use strict'

  ###
  ColumnList.ViewMixin
  ====================
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

  Oraculum.defineMixin 'ColumnList.ViewMixin', {

    initModelView: (column) ->
      {modelView, viewOptions} = @mixinOptions.list

      modelView = column.get('modelView') or modelView
      throw new TypeError '''
        ColumList.ViewMixin modelView option must be defined.
      ''' unless modelView

      model = @model or column
      viewOptions = if _.isFunction viewOptions
      then viewOptions.call this, { model, column }
      else _.extend { model, column }, viewOptions

      attribute = column.get 'attribute'
      viewOptions = _.extend {}, viewOptions, column.get 'viewOptions'

      view = @createView { view: modelView , viewOptions }
      return view

  }, mixins: [
    'List.ViewMixin'
  ]
