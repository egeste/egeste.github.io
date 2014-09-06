define [
  'oraculum'
  'cs!libs'

  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/attach'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/static-classes'
], (Oraculum) ->
  'use strict'

  Datamap = Oraculum.get 'Datamap'

  Oraculum.extend 'View', 'Hitmap.View', {

    mixinOptions:
      staticClasses: ['hitmap-view']
      listen:
        'addedToParent this': '_renderDatamaps'

    _renderDatamaps: -> _.defer =>
      @map = new Datamap
        width: @$el.innerWidth()
        height: @$el.innerHeight()
        element: @el
        geographyConfig:
          popupOnHover: false
        setProjection: (element) ->
          projection = d3.geo.mercator()
            .rotate([100, 0])
            .precision(.5)
            .translate([element.offsetWidth / 2, element.offsetHeight / 1.45])
            .scale((element.offsetWidth + 1) / 2 / Math.PI)
          path = d3.geo.path().projection(projection)
          return {path, projection}

  }, mixins: [
    'Listener.Mixin'
    'Disposable.Mixin'
    'Attach.ViewMixin'
    'StaticClasses.ViewMixin'
    'AutoRender.ViewMixin'
  ]
