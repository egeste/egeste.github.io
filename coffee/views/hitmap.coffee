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
        element: @el
        geographyConfig:
          popupOnHover: false
        setProjection: (element) ->
          projection = d3.geo.equirectangular()
            .rotate([100, -40])
            .translate([element.offsetWidth / 2, element.offsetHeight / 2])
          path = d3.geo.path().projection(projection)
          return {path, projection}

  }, mixins: [
    'Listener.Mixin'
    'Disposable.Mixin'
    'Attach.ViewMixin'
    'StaticClasses.ViewMixin'
    'AutoRender.ViewMixin'
  ]
